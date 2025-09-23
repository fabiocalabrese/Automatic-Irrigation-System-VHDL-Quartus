LIBRARY ieee;
USE ieee.std_logic_1164.all;



ENTITY flag_counter IS
  GENERIC ( n : INTEGER := 4);
  PORT ( 
         enb : IN STD_LOGIC;
			clock,reset : IN STD_LOGIC;
			Qs : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
			
			);
END flag_counter;


ARCHITECTURE behavir OF flag_counter IS

 COMPONENT t_flipflop 
 
  PORT ( 
         T : IN STD_LOGIC;
			clk,resetn : IN STD_LOGIC;
			Q : OUT STD_LOGIC
			
			);
			
 END COMPONENT;

 
 SIGNAL qsignal : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
 SIGNAL and_link : STD_LOGIC_VECTOR(n-2 DOWNTO 0);
 
  BEGIN
   
	tf1 : t_flipflop PORT MAP ( T => enb, clk => clock, resetn => reset,Q => qsignal(0));
     
	  and_link(0) <= enb AND qsignal(0);
	
	
	G : FOR i IN 1 TO n-2 GENERATE 
     
	  tf : t_flipflop PORT MAP ( T => and_link(i-1), clk => clock, resetn => reset, Q => qsignal(i));
	  and_link(i) <= and_link(i-1) AND qsignal(i);
	  
	  END GENERATE;
	  
	 tf_last : t_flipflop PORT MAP ( T => and_link(n-2) , clk => clock, resetn => reset, Q => qsignal(n-1));
	 
	 Qs <= qsignal;
	 
END ARCHITECTURE; 
  