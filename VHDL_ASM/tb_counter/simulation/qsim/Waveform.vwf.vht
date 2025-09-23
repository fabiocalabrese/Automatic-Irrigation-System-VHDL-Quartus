-- Copyright (C) 2023  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "05/04/2024 12:19:17"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          count_1
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY count_1_vhd_vec_tst IS
END count_1_vhd_vec_tst;
ARCHITECTURE count_1_arch OF count_1_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clock : STD_LOGIC;
SIGNAL enb : STD_LOGIC;
SIGNAL Qs : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL reset_c : STD_LOGIC;
COMPONENT count_1
	PORT (
	clock : IN STD_LOGIC;
	enb : IN STD_LOGIC;
	Qs : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
	reset_c : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : count_1
	PORT MAP (
-- list connections between master ports and signals
	clock => clock,
	enb => enb,
	Qs => Qs,
	reset_c => reset_c
	);

-- clock
t_prcs_clock: PROCESS
BEGIN
LOOP
	clock <= '0';
	WAIT FOR 5000 ps;
	clock <= '1';
	WAIT FOR 5000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_clock;

-- enb
t_prcs_enb: PROCESS
BEGIN
	enb <= '0';
	WAIT FOR 80000 ps;
	enb <= '1';
WAIT;
END PROCESS t_prcs_enb;

-- reset_c
t_prcs_reset_c: PROCESS
BEGIN
	reset_c <= '0';
	WAIT FOR 160000 ps;
	reset_c <= '1';
	WAIT FOR 150000 ps;
	reset_c <= '0';
WAIT;
END PROCESS t_prcs_reset_c;
END count_1_arch;
