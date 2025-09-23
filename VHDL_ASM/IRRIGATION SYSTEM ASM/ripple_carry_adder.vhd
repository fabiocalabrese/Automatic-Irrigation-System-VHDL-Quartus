LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- Dichiarazione delle porte di ingresso e di uscita del ripple carry adder.

ENTITY ripple_carry_adder IS
   
	GENERIC ( n: INTEGER := 16 );
   PORT (  x_in: IN SIGNED(n DOWNTO 0);
           y_in : IN SIGNED(n DOWNTO 0);
			  c_in : IN STD_LOGIC;             
			  c_out : OUT STD_LOGIC; 
			  s_out : OUT SIGNED(n DOWNTO 0)  
			 );                                
			 
END ripple_carry_adder;

-- Architettura del ripple carry. 
ARCHITECTURE behavior OF ripple_carry_adder IS 

-- richiamo il componente "fulladder".
 COMPONENT fulladder 
   
	PORT(a, b, cin: IN STD_LOGIC; 
    f, cout: OUT STD_LOGIC);
	 
 END COMPONENT;
 
 -- Dichiarazione dei segnali.
 
 SIGNAL cout_intermedi : STD_LOGIC_VECTOR(n-1 DOWNTO 0);          -- carry in uscita di ciascun full adder

 
 BEGIN
 
 -- Il ripple_carry a 17 bit è costituito da 17 full adder.
 
 fu_primo: fulladder PORT MAP( a => x_in(0), b => y_in(0), cin => c_in, f => s_out(0), cout => cout_intermedi(0));
       
 G2 : FOR i IN 1 TO n-1 GENERATE
      
		fu: fulladder PORT MAP( a => x_in(i), b => y_in(i), cin => cout_intermedi(i-1), f => s_out(i), cout => cout_intermedi(i));
       
		 END GENERATE;
 
 fu_final: fulladder PORT MAP( a => x_in(n), b => y_in(n), cin => cout_intermedi(n-1), f => s_out(n), cout => c_out);
       
 END ARCHITECTURE;
 