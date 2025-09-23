LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY irrigation_system IS 

	PORT(clock_asm, reset_asm, start : IN STD_LOGIC; -- potremmo mettere anche la soglia come ingresso oppure penso andrebbe messa costante dopo
		done, irrigation_alarm : OUT STD_LOGIC;
		data_ext : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		data_out_MEMB : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
		

END irrigation_system;

ARCHITECTURE behavior OF irrigation_system IS


   COMPONENT ripple_carry_sub IS
	    GENERIC ( n: INTEGER := 16 );
        PORT (  x_in: IN SIGNED(n-1 DOWNTO 0);
           y_in : IN SIGNED(n-1 DOWNTO 0);
			  SUB : IN STD_LOGIC;              -- Tale ingresso non è altro che il carry in del primo full adder, se SUB = '1'
			  cout : OUT STD_LOGIC; 
			  s_out : OUT SIGNED(n DOWNTO 0)  -- si effettua la sottrazione, altrimenti si effettua la somma.
			 );                                
			 
   END COMPONENT;
	
	
	COMPONENT regn_16bit 
	   GENERIC ( N : integer:= 16); 
       PORT (
         R : IN SIGNED(N-1 DOWNTO 0);
         Clock, Resetn : IN STD_LOGIC; 
		   Q : OUT SIGNED(N-1 DOWNTO 0)
			);

   END COMPONENT;
	
	
	COMPONENT regn_8bit
	    GENERIC ( N : integer:= 8); 
  
        PORT (
         R : IN SIGNED(N-1 DOWNTO 0);
         Clock, Resetn : IN STD_LOGIC; 
		   Q : OUT SIGNED(N-1 DOWNTO 0)
			);

   END COMPONENT;
  
  
  COMPONENT register_file
      PORT( data_in : IN STD_LOGIC_VECTOR(7 downto 0);
			address : IN STD_LOGIC_VECTOR(2 downto 0);
			cs, wr_n, rd, clock : IN STD_LOGIC;
			data_out : OUT STD_LOGIC_VECTOR(7 downto 0)
			);
			
   END COMPONENT;
	
	
	COMPONENT multiplexer4to1_8bit
	   
		PORT(u, v, w, x: IN SIGNED(7 DOWNTO 0);                   -- ingressi del mu4to1.
							selettore: IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- selettore, costituito da 2 bit.
				         f: OUT SIGNED(7 DOWNTO 0)              -- uscita del mu4to1.
							);                
   END COMPONENT;
	
	
	COMPONENT multiplexer2to1_16bit
	   
		GENERIC( n : INTEGER := 16);
	    PORT (x: IN SIGNED(n-1 DOWNTO 0); 
			y: IN SIGNED(n-1 DOWNTO 0); 
			s: IN STD_LOGIC;                       
			m: OUT SIGNED(n-1 DOWNTO 0));

   END COMPONENT;
	
	
	COMPONENT multiplexer2to1_10bit
	
	    GENERIC( n : INTEGER := 10);
	     PORT (x: IN SIGNED(n-1 DOWNTO 0); 
			y: IN SIGNED(n-1 DOWNTO 0); 
			s: IN STD_LOGIC;                       
			m: OUT SIGNED(n-1 DOWNTO 0));
	
	END COMPONENT;
	
	
	COMPONENT flag_counter
	  
	   GENERIC ( n : INTEGER := 4);
	   	PORT ( 
         enb : IN STD_LOGIC;
			clock,reset : IN STD_LOGIC;
			Qs : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
			
			);
   END COMPONENT;
	
	
	COMPONENT count_1
	 
	    GENERIC ( n : INTEGER := 10);
       PORT ( 
         enb : IN STD_LOGIC;
			clock,reset : IN STD_LOGIC;
			Qs : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
	
      	);
    END COMPONENT;
	 
	 

	TYPE state_type IS (RESET, WR_MEMA, RD_MEMA1, RD_MEMA2, RD_MEMA3, RD_MEMA4, EN_DATA, WR_AVR, DATA_COMP,			-- tutti gli stati possibili
								WR_HIGH_40, WR_HIGH_20, FLAG_COMP, RES_FLAG, EN_FLAG, WR_MEMB1, WR_MEMB2, WR_MEMB3, WR_MEMB4,
								DONE);
	
	SIGNAL state : state_type;		-- stato che viene gestito nell'implementazione a due processi
	
	SIGNAL reset_DP, reset_flag_counter cs_a, cs_b, wr_a_n, wr_b_n, rd_a, rd_b, en_reg1, en_reg2, en_reg3, en_reg4, en_reg40, en_reg20,	-- ogni segnale e bus del DP
			mux_sel_0, mux_sel_1, mux_sel_2, mux_sel_3, mux_sel_5, sub_add_n, msb_result, en_average,
			en_thr, en_high, en_cnt_1, en_cnt_2, en_cnt_flag, irr_alarm, tc_1, tc_2 : STD_LOGIC;
			
	SIGNAL  mux_sel_4 : STD_LOGIC_VECTOR(1 DOWNTO 0);
			
	SIGNAL data_out_a, reg1_out, reg2_out, reg3_out, reg4_out, mux4_out, lsb_mux4, msb_mux4, zero_mux4 : SIGNED(7 DOWNTO 0);
	
	SIGNAL address_a, address_b : STD_LOGIC_VECTOR(9 DOWNTO 0);
	
	SIGNAL cnt_flag : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL reg40_in, reg20_in, data_40, data_20, mux1_out, mux2_out, mux3_out, mux5_out regAvr_in, regAvr_out,
			regHigh_out, regThr_out : SIGNED(15 DOWNTO 0);
	
	SIGNAL in_left_summ, in_right_summ, out_summ : SIGNED(16 DOWNTO 0);
	
	
	
	state_transition : PROCESS(clock_asm) 		-- descrizione delle transizioni di stato
  
    BEGIN
	 
	  IF (clock_asm'EVENT AND clock_asm = '1') THEN
	  
	
		IF reset_asm = '1' THEN   
		
		   state <= RESET;      
		
		ELSE
		
			CASE state IS
			
				WHEN RESET => IF start = '1' THEN state <= WR_MEMA;
									ELSE state <= RESET;
									
				WHEN WR_MEMA => IF tc_1 = '1' THEN state <= RD_MEMA1;
									ELSE state <= WR_MEMA;
				

				WHEN RD_MEMA1 => state <= RD_MEMA2;
				
				
				WHEN RD_MEMA2 => state <= RD_MEMA3;
									
									
				WHEN RD_MEMA3 => state <= RD_MEMA4;
				
				WHEN RD_MEMA4 => state <= EN_DATA;
				
				WHEN EN_DATA => state <= WR_AVR;
				
				WHEN WR_AVR => state <= DATA_COMP;
				
				WHEN DATA_COMP => IF msb_result = '1' THEN
											state <= WR_HIGH_40;
										ELSE
											state <= WR_HIGH_20;
											
				WHEN WR_HIGH_40 => state <= FLAG_COMP;
				
				WHEN WR_HIGH_20 => state <= FLAG_COMP;
				
				WHEN FLAG_COMP => IF msb_result = '1' THEN
											IF irr_alarm = '1' THEN
												state <= WR_MEMB1;
											ELSE
												state <= EN_FLAG;
											END IF;
										ELSE 
											state <= RES_FLAG;
										END IF;
										
				WHEN RES_FLAG => state <= WR_MEMB1;
				
				WHEN EN_FLAG => state <= WR_MEMB1;
				
				WHEN WR_MEMB1 => state <= WR_MEMB2;
				
				WHEN WR_MEMB2 => state <= WR_MEMB3;
				
				WHEN WR_MEMB3 => state <= WR_MEMB4;
				
				WHEN WR_MEMB4 => IF tc_2 = '1'THEN
											state <= DONE;
										ELSE
											state <= EN_DATA;
									  END IF;
									  
				WHEN DONE => IF start = '1' THEN
										state <= DONE;
									ELSE 
										state <= RESET;
										
								 END IF;
												
			END CASE;	
				
		END IF;
	   
	  END IF;
	  
	END PROCESS state_transition;
	
	
	state_outputs : PROCESS(state)  -- definisco i segnali attivati in ogni strato mettendone prima i valori di default
	
		BEGIN
		
			cs_a = '0'; cs_b = '0'; wr_a_n = '1'; wr_b_n = '1'; rd_a = '0'; rd_b = '0'; 
			en_reg1 = '0'; en_reg2 = '0'; en_reg3 = '0'; en_reg4 = '0'; en_reg40 = '0'; en_reg20 = '0';
			mux_sel_0 = '0'; mux_sel_1 = '0'; mux_sel_2 = '0'; mux_sel_3 = '0'; mux_sel_4 = "00"; mux_sel_5 = '0'; sub_add_n = '0';
			en_average = '0'; en_thr = '0'; en_high = '0'; en_cnt_1 = '0'; en_cnt_2 = '0'; en_cnt_flag = '0'; reset_flag_counter = '0';
			done = '0';
			-- irr_alarm = '0'; tc_1 = '0'; tc_2 = '0'; 
			
			CASE state IS
			
					WHEN RESET =>
						
						reset_DP <= '1';
						
					WHEN WR_MEMA =>
					
						cs_a = '1'; cs_b = '1'; wr_a_n = '0'; wr_b_n = '0'; en_cnt_1 = '1'; 
				   
					WHEN RD_MEMA1 => 
					
					  cs_a = '1'; rd_a = '1'; en_reg1 = '1'; en_cnt_1 = '1';
				
				
				   WHEN RD_MEMA2 =>
					
				     cs_a = '1'; rd_a = '1'; en_reg1 = '1'; en_reg2 = '1'; en_cnt_1 = '1';
									
									
				    WHEN RD_MEMA3 =>
			         
						cs_a = '1'; rd_a = '1'; en_reg1 = '1'; en_reg2 = '1'; en_reg3 = '1'; en_cnt_1 = '1';	
				
				    WHEN RD_MEMA4 => 
				  
				      cs_a = '1'; rd_a = '1'; en_reg1 = '1'; en_reg2 = '1'; en_reg3 = '1'; en_reg4 = '1'; en_cnt_1 = '1';
				
					WHEN EN_DATA =>
					
				     en_reg20 = '1'; en_reg40 = '1'; 
					
					WHEN WR_AVR =>
					 
					  en_average = '1';
					
					WHEN DATA_COMP =>
					  
					   sub_add_n = '1';
										
												
					WHEN WR_HIGH_40 => 
					  
					  mux_sel_5 = '1'; en_high = '1';
					
					WHEN WR_HIGH_20 => 
					  
					  en_high = '1';
					  
					WHEN FLAG_COMP 
					
					 mux_sel_1 = '1'; mux_sel_2 = '1'; sub_add_n = '1';
												
											
					WHEN RES_FLAG =>
					 
					 reset_flag_counter = '1';
					
					WHEN EN_FLAG => 
					 
					 en_cnt_flag = '1';
					
					WHEN WR_MEMB1 => 
					 
					 cs_a = '1'; cs_b = '1'; rd_a = '1'; wr_b_n = '0'; en_cnt_1 = '1'; en_cnt_2 = '1'; en_reg1 = '1'; 
					  mux_sel_3 = '1'; mux_sel_4 = "01";
					
					WHEN WR_MEMB2 =>
					   
						cs_a = '1'; cs_b = '1'; rd_a = '1'; wr_b_n = '0'; en_cnt_1 = '1'; en_cnt_2 = '1'; en_reg1= '1'; en_reg2 = '1'; 
					    mux_sel_3 = '1'; mux_sel_4 = "10";
					
					WHEN WR_MEMB3 => 
					    
						 cs_a = '1'; cs_b = '1'; rd_a = '1'; wr_b_n = '0'; en_cnt_1 = '1'; en_cnt_2 = '1'; en_reg1= '1'; en_reg2 = '1'; en_reg3 = '1'; 
					    mux_sel_4 = "01";
					
					WHEN WR_MEMB4 =>
					   
						cs_a = '1'; cs_b = '1'; rd_a = '1'; wr_b_n = '0'; en_cnt_1 = '1'; en_cnt_2 = '1'; en_reg1= '1'; en_reg2 = '1';en_reg3 = '1', en_reg4 = '1'; 
					   mux_sel_4 = "10";
										  
					WHEN DONE =>
					-- manca
			
			
		
 -- Datapath
 
 count1 : count_1 PORT MAP ( en => en_cnt_1, clock => clk_asm, reset => --reset_DP , Qs => address_a);
 
	





END behavior;