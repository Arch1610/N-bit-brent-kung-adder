library ieee; use ieee.std_logic_1164.all; USE IEEE.NUMERIC_STD.ALL;
package adderUtils is function numberOfStages(a: integer) return integer;
end package;

package body adderUtils is
function numberOfStages(a: integer) return integer is 
	variable tmp: integer;
	variable count: integer := 1;
	begin tmp := a;
	loop
		if(tmp = 1) then exit;
		else tmp := tmp/2; 
			count := count+1;
		end if;
	end loop;
	return count;
end function;
end package body;