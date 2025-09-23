LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY tbirrigation_system IS
END tbirrigation_system;


ARCHITECTURE  behavior OF tbirrigation_system IS

  COMPONENT irrigation_system
  PORT(clock_asm, reset_asm, start : IN STD_LOGIC; 
		done_sig : OUT STD_LOGIC;
		irr_alarm : BUFFER STD_LOGIC;
		threshold : IN SIGNED(15 DOWNTO 0);
		data_ext : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		data_out_MEMB : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
   
  END COMPONENT;
	
	

SIGNAL clock, reset, strt, finito, allarme : STD_LOGIC;
SIGNAL data_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL data_out_B : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL soglia : SIGNED( 15 DOWNTO 0 ) ;

 BEGIN
 
 strt <= '0', '1' after 6 ps, '0' after 10 ps, '1' after 6700 ps, '0' after 6800 ps;--, '1' AFTER 1 ps;
 -- reset <= '0', '1' AFTER 2 ps, '0' AFTER 6 ps;
 soglia <= "1111111111111100";   -- -3
 clock_process : PROCESS
          
			 BEGIN
			 clock <= '0';
			 WAIT FOR 1 ps;
			 clock <= '1';
			 WAIT FOR 1 ps;
			 
			 END PROCESS clock_process;
			 
  dati_inA : PROCESS
           
			  BEGIN
                       
			  data_in <= "00000000"; -- -15
			  WAIT FOR 2 ps;
			  data_in <= "10000000";    
			  WAIT FOR  2 ps;
			  data_in <= "00000100"; -- -7
			  WAIT FOR 2 ps;
			  data_in <= "10000000";    -- media = -11 ( 1111111111110100) 
			  WAIT FOR 2 ps;                   --> higest = -15 (data_40)
			  data_in <= "00000000";
			  WAIT FOR 2 ps;
			  data_in <=  (others => ('0'));    --   0
			  WAIT FOR  2 ps;
			  data_in <= "11101011";	-- - 20
			  WAIT FOR 2 ps;
			  data_in <= (others => ('1'));     --  media = -10 (1111 1111 1111 0010) --imposta soglia di -3
			  WAIT FOR 2 ps;
                          data_in <= "11110000"; -- -15
			  WAIT FOR 2 ps;
			  data_in <=  (others => ('1'));
			  WAIT FOR 2 ps;				  -- 0 	(-15, -7) (-20, 0), (0, -15)                                                               --> higest = -20 (data_40)
			  data_in <= "00000000";
			  WAIT FOR 2 ps;
			  data_in <=  (others => ('0'));
			  WAIT FOR 2 ps;				  -- 
			  
			  END PROCESS dati_inA;
			  

dut : irrigation_system PORT MAP( clock_asm => clock, reset_asm => reset, start => strt, done_sig => finito, irr_alarm => allarme ,threshold => soglia, data_ext => data_in, data_out_MEMB => data_out_B ); 


END ARCHITECTURE;