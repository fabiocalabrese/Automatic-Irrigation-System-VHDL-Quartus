LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
--creazione del multiplexer2_1 a 16bit a partire da entity:

ENTITY multiplexer2to1_16bit IS
   GENERIC( n : INTEGER := 16);
	PORT (x: IN SIGNED(n-1 DOWNTO 0); 
			y: IN SIGNED(n-1 DOWNTO 0); 
			s: IN STD_LOGIC;                       
			m: OUT SIGNED(n-1 DOWNTO 0));

END multiplexer2to1_16bit;


-- definisco l'architettura del multiplexer


ARCHITECTURE behavior OF multiplexer2to1_16bit IS 

 
	COMPONENT multiplexer2to1
	
		PORT (x, y : IN STD_LOGIC;
	         s : IN STD_LOGIC;	
				m: OUT STD_LOGIC);
				
	END COMPONENT;

 
 
	BEGIN
    
	 -- istanzio 16 mux 2to1.
		G1 : FOR i IN 0 TO n-1 GENERATE
		mux: multiplexer2to1 PORT MAP(x(i), y(i), s, m(i)); 
      
		END GENERATE;
		
END behavior;

