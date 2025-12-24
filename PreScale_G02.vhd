LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
ENTITY PreScale_G02 IS
	PORT (Clkin 	: IN STD_LOGIC;
			Clkout	: OUT STD_LOGIC);
END PreScale_G02;

ARCHITECTURE Behaviour OF PreScale_G02 IS
SIGNAL O : UNSIGNED (19 DOWNTO 0) := (OTHERS => '0');
SIGNAL P : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
	PROCESS (Clkin)
	BEGIN
	IF Clkin'EVENT and Clkin='1'
		THEN O<=O+1;
	END IF;
	END PROCESS;
	Clkout<=STD_LOGIC(O(19));
END Behaviour;
	
	