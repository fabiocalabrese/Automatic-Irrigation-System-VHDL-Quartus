LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY fulladder IS
   
	PORT(a, b, cin: IN STD_LOGIC; -- input signals whose values must be added, in this case there is also the carry-in cin
    f, cout: OUT STD_LOGIC); -- sum and carry out signals

	 
END fulladder;

ARCHITECTURE behavior OF fulladder IS
  
  -- declare the components to be employed in this circuit
  COMPONENT multiplexer2_1
      PORT (x,y,s:in STD_LOGIC; -- voglio un ingresso x,y a 1 bit
		m: OUT STD_LOGIC);-- voglio che l'uscita sia x o y
   
	END COMPONENT;
  
  -- declare the signals to be employed in this circuit
  SIGNAL selettore: STD_LOGIC; 
  
  BEGIN
    
	 selettore <= a XOR b;
	 f <= cin XOR selettore;
    
	 mu1: multiplexer2_1 PORT MAP( x => b, y => cin, s => selettore, m => cout);
    
END ARCHITECTURE;