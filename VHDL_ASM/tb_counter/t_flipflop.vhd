LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY t_flipflop IS
  
  PORT ( 
         T : IN STD_LOGIC;
			clk,reset : IN STD_LOGIC;
			Q : BUFFER STD_LOGIC
			
			);
END t_flipflop;

ARCHITECTURE behavior OF t_flipflop IS

 
 BEGIN
  
 ff : PROCESS(T, clk,reset)
		  
		  BEGIN
		  IF (reset = '1') THEN		-- reset asincrono 
		        Q <= '0';
				  
		   ELSIF (clk'EVENT AND clk = '1') THEN
					IF ( T = '1' ) THEN
						Q <= NOT Q;	
					END IF;
				
			 END IF;
		
		END PROCESS;
		
END behavior;
		
		
