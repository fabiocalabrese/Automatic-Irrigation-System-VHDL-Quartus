LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY t_flipflop IS
  
  PORT ( 
         T : IN STD_LOGIC;
			clk,resetn : IN STD_LOGIC;
			Q : BUFFER STD_LOGIC
			
			);
END t_flipflop;

ARCHITECTURE behavior OF t_flipflop IS

 
 BEGIN
  
 ff : PROCESS(T, clk)
		  
		  BEGIN
		  
		    IF (clk'EVENT AND clk = '1') THEN
			 
				IF (resetn = '0') THEN		-- reset sincrono negativo
		        Q <= '0';
            ELSE
					IF ( T = '1' ) THEN
						Q <= NOT Q;	
					END IF;
				END IF;
			 END IF;
		
		END PROCESS;
		
END behavior;
		
		
