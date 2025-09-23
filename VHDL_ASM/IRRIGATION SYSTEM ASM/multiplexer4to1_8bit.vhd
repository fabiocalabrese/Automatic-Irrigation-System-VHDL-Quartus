LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
-- creazione di multiplexer4to1 a 8 bit a partire da entity.

ENTITY multiplexer4to1_8bit IS

       
		 PORT(u, v, w, x: IN SIGNED(7 DOWNTO 0);                   -- ingressi del mu4to1.
							selettore: IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- selettore, costituito da 2 bit.
				         f: OUT SIGNED(7 DOWNTO 0)              -- uscita del mu4to1.
							);                

							
END 	multiplexer4to1_8bit;


-- definizione dell'architettura.

ARCHITECTURE behavior OF multiplexer4to1_8bit IS

-- richiamo il componente multiplexer2to1 a 8 bit. 

     COMPONENT multiplexer2to1_8bit
			   
		GENERIC( n : INTEGER := 8);
	      PORT (x: IN SIGNED(n-1 DOWNTO 0); 
			y: IN SIGNED(n-1 DOWNTO 0); 
			s: IN STD_LOGIC;                       
			m: OUT SIGNED(n-1 DOWNTO 0));

    END COMPONENT;
				

-- definisco il segnale.

    
   SIGNAL output_1, output_0: SIGNED( 7 DOWNTO 0 ) ; -- segnale di uscita di ciascun multiplexer2to1.
   
	
	BEGIN
	
	 mu1: multiplexer2to1_8bit port map ( x=> u, y=> v, s=> selettore(0), m=> output_1); 
	 mu2: multiplexer2to1_8bit port map ( x=> w, y=> x, s=> selettore(0), m=> output_0);
	 mu3: multiplexer2to1_8bit port map ( x=> output_1, y=> output_0, s=> selettore(1), m=> f);

 END ARCHITECTURE;
