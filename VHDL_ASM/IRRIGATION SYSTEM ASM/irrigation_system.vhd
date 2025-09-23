LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- VHDL del datapath ed unità di controllo.


-- Entità del circuito.

ENTITY irrigation_system IS 

	PORT(clock_asm, reset_asm, start : IN STD_LOGIC; -- clock della macchina, reset esterno asincrono, e segnale di start.
		done_sig : OUT STD_LOGIC;                     -- done_sig è il segnale dato in uscita, solo dopo aver concluso tutte le operazioni.
		irr_alarm : BUFFER STD_LOGIC;                 -- segnale di allarme : si accende quando il valore "AVERAGE" è maggiore ( in valore assoluto ) della soglia.
																	 -- per dieci volte di fila.
		threshold : IN SIGNED(15 DOWNTO 0);           -- si suppone che la soglia venga impostata dall' utente.
		data_ext : IN STD_LOGIC_VECTOR(7 DOWNTO 0);   -- dati in ingresso ( misurati dai sensori ).
		data_out_MEMB : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); -- segnale non necessario ai fini del progetto, inserito solamente per come è stata strutturata la memoria e per completezza.
		

END irrigation_system;


-- Architettura.

ARCHITECTURE behavior OF irrigation_system IS

-- richiamo tutti i componenti necessari per la realizzazione del circuito.

   COMPONENT ripple_carry_adder IS
	    GENERIC ( n: INTEGER := 16 );
        PORT (  x_in: IN SIGNED(n DOWNTO 0);
           y_in : IN SIGNED(n DOWNTO 0);
			  c_in : IN STD_LOGIC;              
			  c_out : OUT STD_LOGIC; 
			  s_out : OUT SIGNED(n DOWNTO 0)  
			 );                                
			 
   END COMPONENT;
	
	
	COMPONENT regn_16bit 
	   GENERIC ( N : integer:= 16); 
       PORT (
         R : IN SIGNED(N-1 DOWNTO 0);
         Clock, Reset, enable : IN STD_LOGIC; 
		   Q : OUT SIGNED(N-1 DOWNTO 0)
			);

   END COMPONENT;
	
	
	COMPONENT regn_8bit
	    GENERIC ( N : integer:= 8); 
  
        PORT (
         R : IN SIGNED(N-1 DOWNTO 0);
         Clock, Reset, enable : IN STD_LOGIC; 
		   Q : OUT SIGNED(N-1 DOWNTO 0)
			);

   END COMPONENT;
  
  
  COMPONENT register_file
      PORT( data_in : IN STD_LOGIC_VECTOR(7 downto 0);
			address : IN STD_LOGIC_VECTOR(9 downto 0);
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
	     PORT (x: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
			y: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
			s: IN STD_LOGIC;                       
			m: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	
	END COMPONENT;
	
	
	COMPONENT flag_counter
	  
	   GENERIC ( n : INTEGER := 4);
	   	PORT ( 
         enb : IN STD_LOGIC;
			clock,reset_c : IN STD_LOGIC;
			Qs : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
			
			);
   END COMPONENT;
	
	
	COMPONENT count_1
	 
	    GENERIC ( n : INTEGER := 10);
       PORT ( 
         enb : IN STD_LOGIC;
			clock,reset_c : IN STD_LOGIC;
			Qs : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
	
      	);
    END COMPONENT;
	 
	 

	TYPE state_type IS (RESET, WR_MEMA, RD_MEMA1, RD_MEMA2, RD_MEMA3, RD_MEMA4, EN_DATA, WR_AVR, DATA_COMP,			-- tutti gli stati possibili
								WR_HIGH_40, WR_HIGH_20, FLAG_COMP, RES_FLAG, EN_FLAG, WR_MEMB1, WR_MEMB2, WR_MEMB3, WR_MEMB4,
								DONE);
	
	SIGNAL state : state_type;		-- stato che viene gestito nell'implementazione a due processi
	
	-- ogni segnale e bus del DP ( i segnali seguono fedelmente l'ASM di controllo e il datapath ) .
	SIGNAL reset_DP, reset_flag_counter, reset_final_flag_counter, cs_a, cs_b, wr_a_n, wr_b_n, rd_a, rd_b, en_reg1, en_reg2, en_reg3, en_reg4, en_reg40, en_reg20,
			mux_sel_0, mux_sel_1, mux_sel_2, mux_sel_3, mux_sel_5, sub_add_n, msb_result, en_average,
			en_thr, en_high, en_cnt_1, en_cnt_2, en_cnt_flag, tc_1, tc_2, carry_out : STD_LOGIC;
			
	SIGNAL  mux_sel_4 : STD_LOGIC_VECTOR(1 DOWNTO 0);
			
	SIGNAL reg1_in, reg1_out, reg2_out, reg3_out, reg4_out, mux4_out, lsb_mux4, msb_mux4, zero_mux4 : SIGNED(7 DOWNTO 0);
	
	SIGNAL data_in_b, data_out_a : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	SIGNAL counted_1, counted_2, address_a, address_b : STD_LOGIC_VECTOR(9 DOWNTO 0);
	
	SIGNAL cnt_flag : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL reg40_in, reg20_in, data_40, data_20, mux1_out, mux2_out, mux3_out, mux5_out, regAvr_in, regAvr_out,
			regHigh_out, regThr_out, xor_gate_out : SIGNED(15 DOWNTO 0);
	
	SIGNAL in_left_add, in_right_add, out_add : SIGNED(16 DOWNTO 0);
	
	
	BEGIN
	
	state_transition : PROCESS(clock_asm) 		-- descrizione delle transizioni di stato
  
    BEGIN
	 
	  IF (clock_asm'EVENT AND clock_asm = '1') THEN
	  
	
		IF reset_asm = '1' THEN   
		
		   state <= RESET;      
		
		ELSE
		
			CASE state IS
			
				WHEN RESET => IF start = '1' THEN state <= WR_MEMA;
									ELSE state <= RESET;
									END IF;
									
				WHEN WR_MEMA => IF tc_1 = '1' THEN state <= RD_MEMA1;
									ELSE state <= WR_MEMA;
									END IF;

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
											END IF;
											
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
		
			cs_a <= '0'; cs_b <= '0'; wr_a_n <= '1'; wr_b_n <= '1'; rd_a <= '0'; rd_b <= '0'; 
			en_reg1 <= '0'; en_reg2 <= '0'; en_reg3 <= '0'; en_reg4 <= '0'; en_reg40 <= '0'; en_reg20 <= '0';
			mux_sel_0 <= '0'; mux_sel_1 <= '0'; mux_sel_2 <= '0'; mux_sel_3 <= '0'; mux_sel_4 <= "00"; mux_sel_5 <= '0'; sub_add_n <= '0';
			en_average <= '0'; en_thr <= '0'; en_high <= '0'; en_cnt_1 <= '0'; en_cnt_2 <= '0'; en_cnt_flag <= '0'; reset_flag_counter <= '0';
			done_sig <= '0'; reset_DP <= '0';
			
			CASE state IS
			
					WHEN RESET =>
						
						reset_DP <= '1';
						en_thr <= '1';
						
						
					WHEN WR_MEMA =>
					
						cs_a <= '1'; cs_b <= '1'; wr_a_n <= '0'; wr_b_n <= '0'; en_cnt_1 <= '1'; -- scrivo in memoria A e B, incremento il contatore 1.
				   
					-- la sequenza di lettura iniziale legge un byte per volta per 4 colpi di clock, 4 incrementi del contatore 1.
					WHEN RD_MEMA1 => 
					
					  cs_a <= '1'; rd_a <= '1'; en_reg1 <= '1'; en_cnt_1 <= '1'; 
				
				
				   WHEN RD_MEMA2 =>
					
				     cs_a <= '1'; rd_a <= '1'; en_reg1 <= '1'; en_reg2 <= '1'; en_cnt_1 <= '1';
									
									
				    WHEN RD_MEMA3 =>
			         
						cs_a <= '1'; rd_a <= '1'; en_reg1 <= '1'; en_reg2 <= '1'; en_reg3 <= '1'; en_cnt_1 <= '1';	
				
				    WHEN RD_MEMA4 => 
				  
				      cs_a <= '1'; rd_a <= '1'; en_reg1 <= '1'; en_reg2 <= '1'; en_reg3 <= '1'; en_reg4 <= '1'; en_cnt_1 <= '1';
				
				  
					WHEN EN_DATA =>
					
				     en_reg20 <= '1'; en_reg40 <= '1';  -- dati raggruppati in registri da 16 bit, si ricostruisce il dato per intero.
					
					WHEN WR_AVR =>
					 
					  en_average <= '1';   -- si registra il valor medio, inoltre abbiamo ritenuto opportuno registrare il valore di soglia in questo stato.
                  
					
					WHEN DATA_COMP =>
					  
					   sub_add_n <= '1';   -- per effettuare la comparazione tra data_20 e data_40 è necessario convertire il sommatore in sottrattore.
										
												
					WHEN WR_HIGH_40 => 
					  
					  mux_sel_5 <= '1'; en_high <= '1';  -- registro  data_40 se è più grande in modulo. 
					
					WHEN WR_HIGH_20 => 
					  
					  en_high <= '1';          -- registro  data_20 se è più grande in modulo.
					  
					WHEN FLAG_COMP =>
					
					 mux_sel_1 <= '1'; mux_sel_2 <= '1'; sub_add_n <= '1';
												
											
					WHEN RES_FLAG =>
					 
					 reset_flag_counter <= '1';  -- resetto il contatore flag se non si ottengono 10 valori consecutivi soddisfacenti la condizione imposta.
					
					WHEN EN_FLAG => 
					 
					 en_cnt_flag <= '1';     -- incremento il contatore se ottengo un valore sottosoglia.
					
					
					--  la sequenza di controllo successiva legge un byte per volta per 4 colpi di clock, avviene la scrittura dei valori di AVERAGE E HIGHEST in MEM_B,
				   --	4 incrementi del contatore 1 e del contatore 2.
					WHEN WR_MEMB1 => 
					 
					 cs_a <= '1'; cs_b <= '1'; rd_a <= '1'; wr_b_n <= '0'; en_cnt_1 <= '1'; en_cnt_2 <= '1'; en_reg1 <= '1'; mux_sel_0 <= '1';
					  mux_sel_3 <= '1'; mux_sel_4 <= "01";
					
					WHEN WR_MEMB2 =>
					   
						cs_a <= '1'; cs_b <= '1'; rd_a <= '1'; wr_b_n <= '0'; en_cnt_1 <= '1'; en_cnt_2 <= '1'; en_reg1 <= '1'; en_reg2 <= '1'; 
						
                   mux_sel_0 <= '1'; mux_sel_3 <= '1'; mux_sel_4 <= "10";
					
					WHEN WR_MEMB3 => 
					    
						 cs_a <= '1'; cs_b <= '1'; rd_a <= '1'; wr_b_n <= '0'; en_cnt_1 <= '1'; en_cnt_2 <= '1'; en_reg1 <= '1'; en_reg2 <= '1'; en_reg3 <= '1'; 
					    mux_sel_0 <= '1';mux_sel_4 <= "01";
					
					WHEN WR_MEMB4 =>
					   
						cs_a <= '1'; cs_b <= '1'; rd_a <= '1'; wr_b_n <= '0'; en_cnt_1 <= '1'; en_cnt_2 <= '1'; en_reg1 <= '1'; en_reg2 <= '1'; en_reg3 <= '1'; en_reg4 <= '1'; 
					   mux_sel_0 <= '1';mux_sel_4 <= "10";
										  
					WHEN DONE =>
						done_sig <= '1';
					
			END CASE;
	END PROCESS state_outputs;		
			
		
 -- Datapath
 
	count1 : count_1 PORT MAP ( enb => en_cnt_1, clock => clock_asm, reset_c => reset_DP , Qs => counted_1);
	tc_1 <= counted_1(9) AND counted_1(8) AND counted_1(7) AND counted_1(6) AND counted_1(5) AND counted_1(4) AND counted_1(3) AND counted_1(2) AND counted_1(1) AND counted_1(0); 
	-- quando il contatore 1 raggiunge "1111111111" allora tc_1 = '1'.
	count2 : count_1 PORT MAP ( enb => en_cnt_2, clock => clock_asm, reset_c => reset_DP , Qs => counted_2);
	tc_2 <= counted_2(9) AND counted_2(8) AND counted_2(7) AND counted_2(6) AND counted_2(5) AND counted_2(4) AND counted_2(3) AND counted_2(2) AND counted_2(1) AND counted_2(0); 
	-- quando il contatore 2 raggiunge "1111111111" allora tc_2 = '1'.
	
	reset_final_flag_counter <= ( reset_DP OR reset_flag_counter); 
	-- il reset del contatore di flag avviene sia all'inizio dell'algoritmo che quando si incontra una media sottosoglia
	
	counter_flag : flag_counter PORT MAP ( enb => en_cnt_flag, clock => clock_asm, reset_c => reset_final_flag_counter, Qs => cnt_flag);
	irr_alarm <= cnt_flag(3) AND NOT(cnt_flag(2)) AND cnt_flag(1) AND NOT(cnt_flag(0)); -- "1010".
	
	address_a <= counted_1;
	MEM_A : register_file PORT MAP ( data_in => data_ext, address => address_a, cs => cs_a, wr_n => wr_a_n, rd => rd_a,
												clock => clock_asm, data_out => data_out_a);
	
	data_in_b <= STD_LOGIC_VECTOR(mux4_out);
	
	MEM_B : register_file PORT MAP ( data_in => data_in_b, address => address_b, cs => cs_b, wr_n => wr_b_n, rd => rd_b,
												clock => clock_asm, data_out => data_out_MEMB);
												
												
	reg1_in <= SIGNED(data_out_a);
	
	-- 4 registri posti in sequenza.
	reg1 : regn_8bit PORT MAP ( R => reg1_in, Clock => clock_asm, Reset => reset_DP, enable => en_reg1, Q => reg1_out);
	reg2 : regn_8bit PORT MAP ( R => reg1_out, Clock => clock_asm, Reset => reset_DP, enable => en_reg2, Q => reg2_out);
	reg3 : regn_8bit PORT MAP ( R => reg2_out, Clock => clock_asm, Reset => reset_DP, enable => en_reg3, Q => reg3_out);
	reg4 : regn_8bit PORT MAP ( R => reg3_out, Clock => clock_asm, Reset => reset_DP, enable => en_reg4, Q => reg4_out);
	
	-- ricostruzione dati per intero e registrazione.
	reg40_in <= reg1_out & reg2_out;
	reg20_in <= reg3_out & reg4_out;
	
	reg40 : regn_16bit PORT MAP ( R => reg40_in, Clock => clock_asm, Reset => reset_DP, enable => en_reg40, Q => data_40);
	reg20 : regn_16bit PORT MAP ( R => reg20_in, Clock => clock_asm, Reset => reset_DP, enable => en_reg20, Q => data_20);
	
	-- registri di soglia, valor medio e valore massimo.
	regThr : regn_16bit PORT MAP ( R => threshold, Clock => clock_asm, Reset => reset_asm, enable => en_thr, Q => regThr_out);
	regAvr : regn_16bit PORT MAP ( R => regAvr_in, Clock => clock_asm, Reset => reset_DP, enable => en_average, Q => regAvr_out);
	regHigh : regn_16bit PORT MAP ( R => mux5_out, Clock => clock_asm, Reset => reset_DP, enable => en_high, Q => regHigh_out);
	
	-- tutti i mux necessari.
	mpx0 : multiplexer2to1_10bit PORT MAP ( x => counted_1, y => counted_2, s => mux_sel_0, m => address_b);
	
	mpx1 : multiplexer2to1_16bit PORT MAP ( x => data_40, y => regAvr_out, s => mux_sel_1, m => mux1_out);
	mpx2 : multiplexer2to1_16bit PORT MAP ( x => data_20, y => regThr_out, s => mux_sel_2, m => mux2_out);
	
	mpx3 : multiplexer2to1_16bit PORT MAP ( x => regHigh_out, y => regAvr_out, s => mux_sel_3, m => mux3_out);
	
	zero_mux4 <= "00000000";  -- il dato che viene inserito in MEM_B per inizializzarla
	lsb_mux4 <= mux3_out(7 DOWNTO 0);
	msb_mux4 <= mux3_out(15 DOWNTO 8);
	mpx4 : multiplexer4to1_8bit PORT MAP ( u => zero_mux4, v => lsb_mux4, w => msb_mux4, x => "UUUUUUUU", selettore => mux_sel_4, f => mux4_out); 
	-- permette il passaggio di un byte alla volta in memoria B.
	
	mpx5 : multiplexer2to1_16bit PORT MAP ( x => data_20, y => data_40, s => mux_sel_5, m => mux5_out); 
	-- permette il passaggio di uno dei due valori, affinchè venga registrato in memoria B il valore massimo.
	
	in_left_add <= mux1_out(15) & mux1_out; -- estensione di segno
	
	G1 : FOR i IN 0 TO 15 GENERATE 
	
   xor_gate_out(i) <= sub_add_n XOR STD_LOGIC(mux2_out(i));
   
   END GENERATE;
	
	in_right_add <= xor_gate_out(15) & xor_gate_out; -- estensione di segno
	
	adder : ripple_carry_adder PORT MAP ( x_in => in_left_add, y_in => in_right_add, c_in => sub_add_n, c_out => carry_out, s_out => out_add);
	
	msb_result <= out_add(16); -- msb del risultato usato come status flag per la fase di transizione degli stati.
	
	regAvr_in <= out_add(16 DOWNTO 1); -- shifting logico.


END behavior;