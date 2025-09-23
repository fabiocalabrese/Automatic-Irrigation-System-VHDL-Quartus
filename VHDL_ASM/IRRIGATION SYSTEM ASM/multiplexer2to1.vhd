LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
--creazione del multiplexer2to1 a partire da entity:

ENTITY multiplexer2to1 IS

	PORT ( x, y : IN STD_LOGIC	; -- voglio un ingresso x,y a 1 bit
	       s : IN  STD_LOGIC;
	m: OUT STD_LOGIC); -- voglio che l'uscita sia x o y

END multiplexer2to1;

-- definizione dell'architettura

ARCHITECTURE behavior OF multiplexer2to1 IS
	BEGIN

		m <= (NOT (s) AND x) OR (s AND y); -- struttura interna
 
END behavior;