library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity testbench is end entity;

architecture testbench_arch of testbench is
constant nBit: integer := 32; signal A,B,sum: std_logic_vector(nBit-1 downto 0);
signal Cin, Carry_out:  std_logic; file inputFile, outputFile : text;
	
component finalAdder is generic(nBit : integer := 32);
port(	A,B: in std_logic_vector(nBit-1 downto 0); Cin: in std_logic;
		Sum: out std_logic_vector(nBit-1 downto 0); Carry_out: out std_logic); 
end component;

begin
dut : finalAdder generic map (nBit=>nBit) port map(A,B,Cin,Sum,Carry_out);
process
variable sum_cal,Sum_out: std_logic_vector(nBit-1 downto 0);
variable carry_ou,Carry,correct : std_logic;
begin
A <= "11100101011100110010000011011111";
B <= "10101010100010111001111010010110";
sum_cal := "10001111111111101011111101110101";
carry_ou := '1';
Cin <= '0';
wait for 100ns;
Sum_out := Sum;
Carry := Carry_out;
if (Sum_out = sum_cal) and (Carry = carry_ou) then correct := '1'; else correct := '0'; end if;
assert (correct = '1') report "Wrong Calculation" severity FAILURE;
wait; end process; end architecture;