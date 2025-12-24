LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Mode_G02 IS
	PORT (D								: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			Clkin, reset, enable 	: IN STD_LOGIC;
			Complete						: OUT STD_LOGIC);
END Mode_G02;

ARCHITECTURE Behaviour OF Mode_G02 IS
SIGNAL ENC, Counter		: INTEGER RANGE 0 to 1000 := 0;
SIGNAL Mode					: STD_LOGIC;
BEGIN
ENC <= 50 WHEN D(0) = '1' ELSE
		250 WHEN D(1) = '1' ELSE
		500 WHEN D(2) = '1' ELSE
		 NULL;
Mode <= D(0) OR D(1) OR D(2);
PROCESS (Clkin, Reset, Mode)
BEGIN
	IF reset = '1' THEN
		Counter <= 0;
		Complete <=	'0';
	ELSE IF rising_edge(Clkin) AND Mode ='1' THEN
		IF Enable = '1' THEN
			IF Counter < ENC THEN
				Counter <= Counter + 1;
				Complete <= '0';
			ELSE
				Complete <= '1';
		END IF;
	ELSE
		Counter <= 0;
		Complete <= '0';
	END IF;
	END IF;
	END IF;
END PROCESS;
END Behaviour;
		
				
		
