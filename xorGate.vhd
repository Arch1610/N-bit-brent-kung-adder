library ieee;
use ieee.std_logic_1164.all;

entity xorGate is
port(x,y: in std_logic; z: out std_logic);
end entity;

architecture dataflowXOR of xorGate is
begin
--z <= x xor y after 100ps;
z <= x xor y;
end architecture;