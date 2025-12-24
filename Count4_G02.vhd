LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY Count4_G02 IS
	PORT (load, enable, clock 	 : IN STD_LOGIC;
			D      					 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			Q		 					 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END Count4_G02;

ARCHITECTURE Behaviour OF Count4_G02 IS
SIGNAL O, S, X, Y: STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	X(0)<=enable AND O(0);
	X(1)<= X(0) AND O(1);
	X(2)<= X(1) AND O(2);
	X(3)<= X(2) AND O(3);
	S(0)<=enable XOR O(0);
	S(1)<=X(0) XOR O(1);
	S(2)<=X(1) XOR O(2);
	S(3)<=X(2) XOR O(3);
	WITH load SELECT
		Y<=S WHEN '0',
		   D WHEN '1';
	PROCESS (clock)
	BEGIN
	IF clock'EVENT AND clock='1'
		THEN O<=Y;
	END IF;
	END PROCESS;
	Q<=O;
END Behaviour;
