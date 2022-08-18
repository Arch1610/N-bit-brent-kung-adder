library ieee; use ieee.std_logic_1164.all; USE IEEE.NUMERIC_STD.ALL; use work.adderUtils.all;

entity finalAdder is generic(nBit : integer := 32);
port(	A,B: in std_logic_vector(nBit-1 downto 0); Cin: in std_logic;
		Sum: out std_logic_vector(nBit-1 downto 0); Carry_out: out std_logic); end entity;

architecture dataflowFinalAdder of finalAdder is
component andGate is port(x,y: in std_logic; z : out std_logic); end component andGate;
component xorGate is port(x,y: in std_logic; z : out std_logic); end component xorGate;
component otherGate is port(w,x,y: in std_logic; z : out std_logic); end component otherGate;
signal Carry: std_logic_vector(nBit downto 0);
constant stages: integer := numberOfStages(nBit);
TYPE DATA_ARRAY  IS ARRAY (1 TO stages) OF std_logic_vector(nBit-1 downto 0) ;
SIGNAL G,P : DATA_ARRAY := (others=> (others=>'0'));

begin 
--G(1)(0) <= ((A(0)) and (B(0))) or ((B(0)) and (Cin)) or ((Cin) and (A(0))) after 100ps;
G(1)(0) <= ((A(0)) and (B(0))) or ((B(0)) and (Cin)) or ((Cin) and (A(0)));
pgCalLevel1: 	for j in 0 to nBit-1 generate
pCal: 				xorGate port map(A(j),B(j),P(1)(j));
notForG0: 		if (j > 0) generate
gCal: 				andGate port map(A(j),B(j),G(1)(j)); end generate; end generate;

pgCal: 		for i in 2 to stages generate
allLevel: 		for j in 0 to (nBit/2)-1 generate
pCal: 				andGate port map(P(i-1)(2*j),P(i-1)((2*j)+1),P(i)(j));
gCal: 				otherGate port map(G(i-1)((2*j)+1),P(i-1)((2*j)+1),G(i-1)(2*j),G(i)(j));
end generate; end generate;

Carry(0) <= Cin;
carryGen1:	for i in 1 to stages generate
carryGen2:		for j in 0 to (2**(stages - i)) - 1 generate
carryGen3:			if (j = 0) generate 
							carry(nBit/(2**(stages - i))) <= G(i)(0);
						end generate carryGen3;
carryGen4:			if ((j > 0) and ((j rem 2) = 0)) generate
							carryGen: otherGate port map(G(i)(j),P(i)(j),Carry(j*(2**(i-1))),
							Carry((j*(2**(i-1)))+(2**(i-1))));
						end generate carryGen4;
					end generate carryGen2;
				end generate carryGen1;

sumCal: for i in 0 to nBit-1 generate
sum_0: xorGate port map(P(1)(i),Carry(i),sum(i)); end generate sumCal;
Carry_out <= Carry(nBit);
end architecture;