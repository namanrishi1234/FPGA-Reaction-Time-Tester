LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY TestReaction_G02 IS
	PORT(SW															: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		  KEY															: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		  CLOCK_50													: IN STD_LOGIC;
		  LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END TestReaction_G02;

ARCHITECTURE Behaviour OF TestReaction_G02 IS

SIGNAL Clkin, MUX0, MUX1, D0, D1, Clkout, Start0, Start1, P0, P1, Q0, Q1, S, Reset0, Reset1		:		STD_LOGIC;
SIGNAL BCD0, BCD1, BCD4, BCD5																							: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL Y0, Y1, Y2, Y4, Y5																								: STD_LOGIC_VECTOR(6 DOWNTO 0);
																
COMPONENT PreScale_G02 IS
	PORT (Clkin 	: IN STD_LOGIC;
			Clkout	: OUT STD_LOGIC);
END COMPONENT;

COMPONENT Mode_G02 IS
	PORT (D								: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			Clkin, reset, enable 	: IN STD_LOGIC;
			Complete						: OUT STD_LOGIC);
END COMPONENT;

COMPONENT BCDCount2_G02 IS
	PORT (clear, enable, clock		: IN STD_LOGIC;
			BCD0, BCD1					: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END COMPONENT;

COMPONENT SegDecoder_G02 IS
	PORT ( D : in std_logic_vector( 3 downto 0 );
			 Y : out std_logic_vector( 6 downto 0 ) );
END COMPONENT;

BEGIN
Reset0<=(NOT(KEY(0)) AND P0) OR SW(2);
PreScale: PreScale_G02 PORT MAP (CLOCK_50, Clkout);
Mode0: Mode_G02 PORT MAP (SW(9 DOWNTO 7), Clkout, Reset0, SW(0), Start0);
HEX3<="0001100";

PROCESS (Clkout, Reset0)
BEGIN
	IF Clkout'EVENT AND Clkout='1'
		THEN
		IF KEY(1)='0' AND Q0='1'
			THEN P0<=KEY(1);
		END IF;
	END IF;
	IF Reset0='1'
		THEN P0<='1';
	END IF;
END PROCESS;

WITH SW(0) SELECT
	MUX0<=Q0 WHEN '0',
		'1' WHEN '1';
D0<=P0 AND MUX0 AND NOT(Reset0) AND Start0;

PROCESS (Clkout)
BEGIN
	IF Clkout'EVENT AND Clkout='1'
		THEN Q0<=D0;
	END IF;
END PROCESS;

LEDR(0)<= Q0;

BCDCount20: BCDCount2_G02 PORT MAP(Reset0, Q0, Clkout, BCD0, BCD1);

SegDecoder0: SegDecoder_G02 PORT MAP(BCD0, Y0);
SegDecoder1: SegDecoder_G02 PORT MAP(BCD1, Y1);

HEX0<=Y0;
HEX1<=Y1;

PROCESS (Clkout, Reset0)
BEGIN
	IF Clkout'EVENT AND Clkout='1'
		THEN
		IF P0='0'
			THEN Y2<="0100100";
		END IF;
	END IF;
	IF Reset0='1'
		THEN Y2<="1111001";
	END IF;
END PROCESS;
HEX2<=Y2;

Reset1<=(NOT(KEY(2)) AND P1) OR SW(2);
Mode1: Mode_G02 PORT MAP(SW(9 DOWNTO 7), Clkout, Reset1, NOT(SW(0)), Start1);

PROCESS (Clkout, Reset1)
BEGIN
	IF Clkout'EVENT AND Clkout='1'
		THEN
		IF KEY(3)='0' AND Q1='1'
			THEN P1<=KEY(3);
		END IF;
	END IF;
	IF Reset1='1'
		THEN P1<='1';
	END IF;
END PROCESS;

S<=NOT(P0) AND NOT(SW(0));
WITH S SELECT
	MUX1<=Q1 WHEN '0',
		'1' WHEN '1';
D1<=P1 AND MUX1 AND NOT(Reset1) AND Start1;

PROCESS (Clkout)
BEGIN
	IF Clkout'EVENT AND Clkout='1'
		THEN Q1<=D1;
	END IF;
END PROCESS;

LEDR(1)<= Q1;

BCDCount21: BCDCount2_G02 PORT MAP(Reset1, Q1, Clkout, BCD4, BCD5);

SegDecoder4: SegDecoder_G02 PORT MAP(BCD4, Y4);
SegDecoder5: SegDecoder_G02 PORT MAP(BCD5, Y5);

HEX4<=Y4;
HEX5<=Y5;

END Behaviour;
	
	

		  