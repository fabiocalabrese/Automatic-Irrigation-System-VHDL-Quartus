LIBRARY ieee;
USE ieee.std_logic_1164.all;

--creazione del multiplexer2-1 a partire da entity:

entity multiplexer2_1 is

port (x,y,s:in std_logic; -- voglio un ingresso x,y a 1 bit
		m: out std_logic);-- voglio che l'uscita sia x o y
end multiplexer2_1;


-- definizione dell'architettura

architecture mup2_1 of multiplexer2_1 is
begin
 m <= (NOT (s) AND x) OR (s AND y); --struttura interna
 
 end mup2_1;