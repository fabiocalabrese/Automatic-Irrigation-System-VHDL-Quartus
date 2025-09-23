LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY regn_8bit IS

  GENERIC ( N : integer:= 8); 
  
  PORT (
         R : IN SIGNED(N-1 DOWNTO 0);
         Clock, Reset, enable : IN STD_LOGIC; 
		   Q : OUT SIGNED(N-1 DOWNTO 0)
			);

END regn_8bit;


ARCHITECTURE Behavior OF regn_8bit IS
   
	BEGIN
   
	PROCESS (Clock, Reset)
   
	BEGIN
  
     IF (Reset = '1') THEN
          Q <= (OTHERS => '0');     -- reset asincrono.

	   ELSIF (Clock'EVENT AND Clock = '1') THEN
           IF enable = '1' THEN
			     Q <= R;
		     END IF;
     
	  END IF;
    
	 END PROCESS;


END Behavior;