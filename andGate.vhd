library ieee;
use ieee.std_logic_1164.all;

entity andGate is
port(x,y: in std_logic; z: out std_logic);
end entity;

architecture dataflowAND of andGate is
begin
z <= x and y;
--z <= x and y after 100ps;
end architecture;