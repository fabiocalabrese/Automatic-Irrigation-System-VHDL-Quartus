LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- Dichiarazione delle porte di ingresso e di uscita del ripple carry adder/subtractor ( 4 bit ).

ENTITY ripple_carry_sub IS
   
	GENERIC ( n: INTEGER := 16 );
   PORT (  x_in: IN SIGNED(n-1 DOWNTO 0);
           y_in : IN SIGNED(n-1 DOWNTO 0);
			  SUB : IN STD_LOGIC;              -- Tale ingresso non è altro che il carry in del primo full adder, se SUB = '1'
			  cout : OUT STD_LOGIC; 
			  s_out : OUT SIGNED(n DOWNTO 0)  -- si effettua la sottrazione, altrimenti si effettua la somma.
			 );                                
			 
END ripple_carry_sub;

-- Architettura del ripple carry. 
ARCHITECTURE behavior OF ripple_carry_sub IS 

-- richiamo il componente "fulladder".
 COMPONENT fulladder 
   
	PORT(a, b, cin: IN STD_LOGIC; 
    f, cout: OUT STD_LOGIC);
	 
 END COMPONENT;
 
 -- Dichiarazione dei segnali.
 
 SIGNAL cout_intermedi : STD_LOGIC_VECTOR(n-1 DOWNTO 0);          -- carry in uscita di ciascun full adder
 SIGNAL y_sub_std : STD_LOGIC_VECTOR(n-1 DOWNTO 0); -- segnale di supporto per operazioni logiche.
 SIGNAL y_sub, x_sub : SIGNED(n DOWNTO 0);               -- segnale finale di y, in ingresso di ciascun full adder.
 
 BEGIN
 
 -- operazione logiche : svolgono il complemento  1 di y ( se SUB = '1') , a tale segnale si aggiunge il carry in = SUB, così da ottenere il complemento 2.
 G1 : FOR i IN 0 TO n-1 GENERATE 
   y_sub_std(i) <= SUB XOR STD_LOGIC(y_in(i));
      END GENERATE;
 
 y_sub <= y_sub_std(n-1) & SIGNED(y_sub_std); -- estensione di segno
 x_sub <= x_in(n-1) & SIGNED(x_in);           -- estensione di segno
 
 fu_primo: fulladder PORT MAP( a => x_sub(0), b => y_sub(0), cin => SUB, f => s_out(0), cout => cout_intermedi(0));
       
 G2 : FOR i IN 1 TO n-1 GENERATE
      
		fu: fulladder PORT MAP( a => x_sub(i), b => y_sub(i), cin => cout_intermedi(i-1), f => s_out(i), cout => cout_intermedi(i));
       
		 END GENERATE;
 
 fu_final: fulladder PORT MAP( a => x_sub(n), b => y_sub(n), cin => cout_intermedi(n-1), f => s_out(n), cout => cout);
       
 END ARCHITECTURE;
 