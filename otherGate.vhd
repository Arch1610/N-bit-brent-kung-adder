library ieee;
use ieee.std_logic_1164.all;

entity otherGate is
port(w,x,y: in std_logic; z: out std_logic);
end entity;

architecture dataflowOTHER of otherGate is
begin
--z <= (w or (x and y)) after 100ps;
z <= (w or (x and y));
end architecture;