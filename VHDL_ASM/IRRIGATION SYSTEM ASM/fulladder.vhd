LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY fulladder IS
   
	PORT(a, b, cin: IN STD_LOGIC;
    f, cout: OUT STD_LOGIC);

	 
END fulladder;

ARCHITECTURE behavior OF fulladder IS
  
  COMPONENT multiplexer2to1
      PORT (x,y,s:in STD_LOGIC; -- voglio un ingresso x,y a 1 bit
		m: OUT STD_LOGIC);-- voglio che l'uscita sia x o y
   
	END COMPONENT;
  
  SIGNAL selettore: STD_LOGIC; 
  
  BEGIN
    
	 selettore <= a XOR b;
	 f <= cin XOR selettore;
    
	 mu1: multiplexer2to1 PORT MAP( x => b, y => cin, s => selettore, m => cout);
    
END ARCHITECTURE;