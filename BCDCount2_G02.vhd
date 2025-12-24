LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
ENTITY BCDCount2_G02 IS
	PORT (clear, enable, clock		: IN STD_LOGIC;
			BCD0, BCD1					: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END BCDCount2_G02;

ARCHITECTURE Behaviour OF BCDCount2_G02 IS
SIGNAL P, Q, R, S	: STD_LOGIC;
SIGNAL Q1, Q2		: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL D				: UNSIGNED (3 DOWNTO 0) := (OTHERS=>'0');
COMPONENT COUNT4_G02 IS
	PORT (load, enable, clock 	 : IN STD_LOGIC;
			D      					 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			Q		 					 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END COMPONENT;
BEGIN
	P<=Q1(0) AND Q1(3);
	Q<=Q2(0) AND Q2(3) AND P;
	R<=clear OR P;
	S<=clear OR Q;
	U1: Count4_G02 PORT MAP (R, enable, clock, STD_LOGIC_VECTOR(D), Q1);
	U2: Count4_G02 PORT MAP (S, P, clock, STD_LOGIC_VECTOR(D), Q2);
	BCD0 <= Q1;
	BCD1 <= Q2;
END Behaviour;

	