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

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 22.1std.2 Build 922 07/20/2023 SC Lite Edition"

-- DATE "05/04/2024 12:19:18"

-- 
-- Device: Altera 5CGXFC7C7F23C8 Package FBGA484
-- 

-- 
-- This VHDL file should be used for Questa Intel FPGA (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	count_1 IS
    PORT (
	enb : IN std_logic;
	clock : IN std_logic;
	reset_c : IN std_logic;
	Qs : OUT std_logic_vector(9 DOWNTO 0)
	);
END count_1;

-- Design Ports Information
-- Qs[0]	=>  Location: PIN_L18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Qs[1]	=>  Location: PIN_L17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Qs[2]	=>  Location: PIN_K21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Qs[3]	=>  Location: PIN_M21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Qs[4]	=>  Location: PIN_K22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Qs[5]	=>  Location: PIN_N20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Qs[6]	=>  Location: PIN_N16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Qs[7]	=>  Location: PIN_K17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Qs[8]	=>  Location: PIN_M18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Qs[9]	=>  Location: PIN_M20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- enb	=>  Location: PIN_L19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clock	=>  Location: PIN_M16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset_c	=>  Location: PIN_N21,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF count_1 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_enb : std_logic;
SIGNAL ww_clock : std_logic;
SIGNAL ww_reset_c : std_logic;
SIGNAL ww_Qs : std_logic_vector(9 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \clock~input_o\ : std_logic;
SIGNAL \clock~inputCLKENA0_outclk\ : std_logic;
SIGNAL \enb~input_o\ : std_logic;
SIGNAL \tf1|Q~0_combout\ : std_logic;
SIGNAL \reset_c~input_o\ : std_logic;
SIGNAL \tf1|Q~q\ : std_logic;
SIGNAL \G:1:tf|Q~0_combout\ : std_logic;
SIGNAL \G:1:tf|Q~q\ : std_logic;
SIGNAL \G:2:tf|Q~0_combout\ : std_logic;
SIGNAL \G:2:tf|Q~q\ : std_logic;
SIGNAL \G:3:tf|Q~0_combout\ : std_logic;
SIGNAL \G:3:tf|Q~q\ : std_logic;
SIGNAL \G:4:tf|Q~0_combout\ : std_logic;
SIGNAL \G:4:tf|Q~q\ : std_logic;
SIGNAL \G:5:tf|Q~0_combout\ : std_logic;
SIGNAL \G:5:tf|Q~q\ : std_logic;
SIGNAL \G:6:tf|Q~0_combout\ : std_logic;
SIGNAL \G:6:tf|Q~q\ : std_logic;
SIGNAL \G:7:tf|Q~0_combout\ : std_logic;
SIGNAL \G:7:tf|Q~q\ : std_logic;
SIGNAL \G:8:tf|Q~0_combout\ : std_logic;
SIGNAL \G:8:tf|Q~q\ : std_logic;
SIGNAL \tf_last|Q~0_combout\ : std_logic;
SIGNAL \tf_last|Q~q\ : std_logic;
SIGNAL and_link : std_logic_vector(8 DOWNTO 0);
SIGNAL \ALT_INV_enb~input_o\ : std_logic;
SIGNAL \ALT_INV_reset_c~input_o\ : std_logic;
SIGNAL ALT_INV_and_link : std_logic_vector(4 DOWNTO 4);
SIGNAL \tf_last|ALT_INV_Q~q\ : std_logic;
SIGNAL \G:8:tf|ALT_INV_Q~q\ : std_logic;
SIGNAL \G:7:tf|ALT_INV_Q~q\ : std_logic;
SIGNAL \G:6:tf|ALT_INV_Q~q\ : std_logic;
SIGNAL \G:5:tf|ALT_INV_Q~q\ : std_logic;
SIGNAL \G:4:tf|ALT_INV_Q~q\ : std_logic;
SIGNAL \G:3:tf|ALT_INV_Q~q\ : std_logic;
SIGNAL \G:2:tf|ALT_INV_Q~q\ : std_logic;
SIGNAL \G:1:tf|ALT_INV_Q~q\ : std_logic;
SIGNAL \tf1|ALT_INV_Q~q\ : std_logic;

BEGIN

ww_enb <= enb;
ww_clock <= clock;
ww_reset_c <= reset_c;
Qs <= ww_Qs;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_enb~input_o\ <= NOT \enb~input_o\;
\ALT_INV_reset_c~input_o\ <= NOT \reset_c~input_o\;
ALT_INV_and_link(4) <= NOT and_link(4);
\tf_last|ALT_INV_Q~q\ <= NOT \tf_last|Q~q\;
\G:8:tf|ALT_INV_Q~q\ <= NOT \G:8:tf|Q~q\;
\G:7:tf|ALT_INV_Q~q\ <= NOT \G:7:tf|Q~q\;
\G:6:tf|ALT_INV_Q~q\ <= NOT \G:6:tf|Q~q\;
\G:5:tf|ALT_INV_Q~q\ <= NOT \G:5:tf|Q~q\;
\G:4:tf|ALT_INV_Q~q\ <= NOT \G:4:tf|Q~q\;
\G:3:tf|ALT_INV_Q~q\ <= NOT \G:3:tf|Q~q\;
\G:2:tf|ALT_INV_Q~q\ <= NOT \G:2:tf|Q~q\;
\G:1:tf|ALT_INV_Q~q\ <= NOT \G:1:tf|Q~q\;
\tf1|ALT_INV_Q~q\ <= NOT \tf1|Q~q\;

-- Location: IOOBUF_X89_Y38_N22
\Qs[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \tf1|Q~q\,
	devoe => ww_devoe,
	o => ww_Qs(0));

-- Location: IOOBUF_X89_Y37_N22
\Qs[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \G:1:tf|Q~q\,
	devoe => ww_devoe,
	o => ww_Qs(1));

-- Location: IOOBUF_X89_Y38_N39
\Qs[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \G:2:tf|Q~q\,
	devoe => ww_devoe,
	o => ww_Qs(2));

-- Location: IOOBUF_X89_Y37_N56
\Qs[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \G:3:tf|Q~q\,
	devoe => ww_devoe,
	o => ww_Qs(3));

-- Location: IOOBUF_X89_Y38_N56
\Qs[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \G:4:tf|Q~q\,
	devoe => ww_devoe,
	o => ww_Qs(4));

-- Location: IOOBUF_X89_Y35_N79
\Qs[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \G:5:tf|Q~q\,
	devoe => ww_devoe,
	o => ww_Qs(5));

-- Location: IOOBUF_X89_Y35_N45
\Qs[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \G:6:tf|Q~q\,
	devoe => ww_devoe,
	o => ww_Qs(6));

-- Location: IOOBUF_X89_Y37_N5
\Qs[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \G:7:tf|Q~q\,
	devoe => ww_devoe,
	o => ww_Qs(7));

-- Location: IOOBUF_X89_Y36_N22
\Qs[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \G:8:tf|Q~q\,
	devoe => ww_devoe,
	o => ww_Qs(8));

-- Location: IOOBUF_X89_Y37_N39
\Qs[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \tf_last|Q~q\,
	devoe => ww_devoe,
	o => ww_Qs(9));

-- Location: IOIBUF_X89_Y35_N61
\clock~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clock,
	o => \clock~input_o\);

-- Location: CLKCTRL_G10
\clock~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \clock~input_o\,
	outclk => \clock~inputCLKENA0_outclk\);

-- Location: IOIBUF_X89_Y38_N4
\enb~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_enb,
	o => \enb~input_o\);

-- Location: LABCELL_X88_Y37_N57
\tf1|Q~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \tf1|Q~0_combout\ = !\enb~input_o\ $ (!\tf1|Q~q\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010110101010010101011010101001010101101010100101010110101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_enb~input_o\,
	datad => \tf1|ALT_INV_Q~q\,
	combout => \tf1|Q~0_combout\);

-- Location: IOIBUF_X89_Y35_N95
\reset_c~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset_c,
	o => \reset_c~input_o\);

-- Location: FF_X88_Y37_N59
\tf1|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \tf1|Q~0_combout\,
	clrn => \ALT_INV_reset_c~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tf1|Q~q\);

-- Location: LABCELL_X88_Y37_N48
\G:1:tf|Q~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \G:1:tf|Q~0_combout\ = ( \G:1:tf|Q~q\ & ( \tf1|Q~q\ & ( !\enb~input_o\ ) ) ) # ( !\G:1:tf|Q~q\ & ( \tf1|Q~q\ & ( \enb~input_o\ ) ) ) # ( \G:1:tf|Q~q\ & ( !\tf1|Q~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100110011001100111100110011001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_enb~input_o\,
	datae => \G:1:tf|ALT_INV_Q~q\,
	dataf => \tf1|ALT_INV_Q~q\,
	combout => \G:1:tf|Q~0_combout\);

-- Location: FF_X88_Y37_N50
\G:1:tf|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \G:1:tf|Q~0_combout\,
	clrn => \ALT_INV_reset_c~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \G:1:tf|Q~q\);

-- Location: LABCELL_X88_Y37_N27
\G:2:tf|Q~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \G:2:tf|Q~0_combout\ = ( \G:2:tf|Q~q\ & ( \G:1:tf|Q~q\ & ( (!\enb~input_o\) # (!\tf1|Q~q\) ) ) ) # ( !\G:2:tf|Q~q\ & ( \G:1:tf|Q~q\ & ( (\enb~input_o\ & \tf1|Q~q\) ) ) ) # ( \G:2:tf|Q~q\ & ( !\G:1:tf|Q~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000011000000111111110011111100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_enb~input_o\,
	datac => \tf1|ALT_INV_Q~q\,
	datae => \G:2:tf|ALT_INV_Q~q\,
	dataf => \G:1:tf|ALT_INV_Q~q\,
	combout => \G:2:tf|Q~0_combout\);

-- Location: FF_X88_Y37_N29
\G:2:tf|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \G:2:tf|Q~0_combout\,
	clrn => \ALT_INV_reset_c~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \G:2:tf|Q~q\);

-- Location: LABCELL_X88_Y37_N54
\G:3:tf|Q~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \G:3:tf|Q~0_combout\ = ( \G:2:tf|Q~q\ & ( !\G:3:tf|Q~q\ $ (((!\enb~input_o\) # ((!\tf1|Q~q\) # (!\G:1:tf|Q~q\)))) ) ) # ( !\G:2:tf|Q~q\ & ( \G:3:tf|Q~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100000001111111100000000111111110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_enb~input_o\,
	datab => \tf1|ALT_INV_Q~q\,
	datac => \G:1:tf|ALT_INV_Q~q\,
	datad => \G:3:tf|ALT_INV_Q~q\,
	dataf => \G:2:tf|ALT_INV_Q~q\,
	combout => \G:3:tf|Q~0_combout\);

-- Location: FF_X88_Y37_N56
\G:3:tf|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \G:3:tf|Q~0_combout\,
	clrn => \ALT_INV_reset_c~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \G:3:tf|Q~q\);

-- Location: LABCELL_X88_Y37_N36
\G:4:tf|Q~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \G:4:tf|Q~0_combout\ = ( \G:4:tf|Q~q\ & ( \G:3:tf|Q~q\ & ( (!\G:1:tf|Q~q\) # ((!\enb~input_o\) # ((!\G:2:tf|Q~q\) # (!\tf1|Q~q\))) ) ) ) # ( !\G:4:tf|Q~q\ & ( \G:3:tf|Q~q\ & ( (\G:1:tf|Q~q\ & (\enb~input_o\ & (\G:2:tf|Q~q\ & \tf1|Q~q\))) ) ) ) # ( 
-- \G:4:tf|Q~q\ & ( !\G:3:tf|Q~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000011111111111111110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \G:1:tf|ALT_INV_Q~q\,
	datab => \ALT_INV_enb~input_o\,
	datac => \G:2:tf|ALT_INV_Q~q\,
	datad => \tf1|ALT_INV_Q~q\,
	datae => \G:4:tf|ALT_INV_Q~q\,
	dataf => \G:3:tf|ALT_INV_Q~q\,
	combout => \G:4:tf|Q~0_combout\);

-- Location: FF_X88_Y37_N38
\G:4:tf|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \G:4:tf|Q~0_combout\,
	clrn => \ALT_INV_reset_c~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \G:4:tf|Q~q\);

-- Location: LABCELL_X88_Y37_N12
\and_link[4]\ : cyclonev_lcell_comb
-- Equation(s):
-- and_link(4) = ( \G:4:tf|Q~q\ & ( \G:1:tf|Q~q\ & ( (\G:2:tf|Q~q\ & (\enb~input_o\ & (\G:3:tf|Q~q\ & \tf1|Q~q\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \G:2:tf|ALT_INV_Q~q\,
	datab => \ALT_INV_enb~input_o\,
	datac => \G:3:tf|ALT_INV_Q~q\,
	datad => \tf1|ALT_INV_Q~q\,
	datae => \G:4:tf|ALT_INV_Q~q\,
	dataf => \G:1:tf|ALT_INV_Q~q\,
	combout => and_link(4));

-- Location: LABCELL_X88_Y37_N3
\G:5:tf|Q~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \G:5:tf|Q~0_combout\ = ( !\G:5:tf|Q~q\ & ( and_link(4) ) ) # ( \G:5:tf|Q~q\ & ( !and_link(4) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111111111111111111110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \G:5:tf|ALT_INV_Q~q\,
	dataf => ALT_INV_and_link(4),
	combout => \G:5:tf|Q~0_combout\);

-- Location: FF_X88_Y37_N5
\G:5:tf|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \G:5:tf|Q~0_combout\,
	clrn => \ALT_INV_reset_c~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \G:5:tf|Q~q\);

-- Location: LABCELL_X88_Y37_N42
\G:6:tf|Q~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \G:6:tf|Q~0_combout\ = ( \G:6:tf|Q~q\ & ( and_link(4) & ( !\G:5:tf|Q~q\ ) ) ) # ( !\G:6:tf|Q~q\ & ( and_link(4) & ( \G:5:tf|Q~q\ ) ) ) # ( \G:6:tf|Q~q\ & ( !and_link(4) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100001111000011111111000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \G:5:tf|ALT_INV_Q~q\,
	datae => \G:6:tf|ALT_INV_Q~q\,
	dataf => ALT_INV_and_link(4),
	combout => \G:6:tf|Q~0_combout\);

-- Location: FF_X88_Y37_N44
\G:6:tf|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \G:6:tf|Q~0_combout\,
	clrn => \ALT_INV_reset_c~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \G:6:tf|Q~q\);

-- Location: LABCELL_X88_Y37_N33
\G:7:tf|Q~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \G:7:tf|Q~0_combout\ = ( \G:7:tf|Q~q\ & ( and_link(4) & ( (!\G:6:tf|Q~q\) # (!\G:5:tf|Q~q\) ) ) ) # ( !\G:7:tf|Q~q\ & ( and_link(4) & ( (\G:6:tf|Q~q\ & \G:5:tf|Q~q\) ) ) ) # ( \G:7:tf|Q~q\ & ( !and_link(4) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000011111111111111110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \G:6:tf|ALT_INV_Q~q\,
	datad => \G:5:tf|ALT_INV_Q~q\,
	datae => \G:7:tf|ALT_INV_Q~q\,
	dataf => ALT_INV_and_link(4),
	combout => \G:7:tf|Q~0_combout\);

-- Location: FF_X88_Y37_N35
\G:7:tf|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \G:7:tf|Q~0_combout\,
	clrn => \ALT_INV_reset_c~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \G:7:tf|Q~q\);

-- Location: LABCELL_X88_Y37_N6
\G:8:tf|Q~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \G:8:tf|Q~0_combout\ = ( \G:8:tf|Q~q\ & ( and_link(4) & ( (!\G:7:tf|Q~q\) # ((!\G:5:tf|Q~q\) # (!\G:6:tf|Q~q\)) ) ) ) # ( !\G:8:tf|Q~q\ & ( and_link(4) & ( (\G:7:tf|Q~q\ & (\G:5:tf|Q~q\ & \G:6:tf|Q~q\)) ) ) ) # ( \G:8:tf|Q~q\ & ( !and_link(4) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000001011111111111111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \G:7:tf|ALT_INV_Q~q\,
	datac => \G:5:tf|ALT_INV_Q~q\,
	datad => \G:6:tf|ALT_INV_Q~q\,
	datae => \G:8:tf|ALT_INV_Q~q\,
	dataf => ALT_INV_and_link(4),
	combout => \G:8:tf|Q~0_combout\);

-- Location: FF_X88_Y37_N8
\G:8:tf|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \G:8:tf|Q~0_combout\,
	clrn => \ALT_INV_reset_c~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \G:8:tf|Q~q\);

-- Location: LABCELL_X88_Y37_N18
\tf_last|Q~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \tf_last|Q~0_combout\ = ( \tf_last|Q~q\ & ( and_link(4) & ( (!\G:5:tf|Q~q\) # ((!\G:6:tf|Q~q\) # ((!\G:7:tf|Q~q\) # (!\G:8:tf|Q~q\))) ) ) ) # ( !\tf_last|Q~q\ & ( and_link(4) & ( (\G:5:tf|Q~q\ & (\G:6:tf|Q~q\ & (\G:7:tf|Q~q\ & \G:8:tf|Q~q\))) ) ) ) # ( 
-- \tf_last|Q~q\ & ( !and_link(4) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000011111111111111110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \G:5:tf|ALT_INV_Q~q\,
	datab => \G:6:tf|ALT_INV_Q~q\,
	datac => \G:7:tf|ALT_INV_Q~q\,
	datad => \G:8:tf|ALT_INV_Q~q\,
	datae => \tf_last|ALT_INV_Q~q\,
	dataf => ALT_INV_and_link(4),
	combout => \tf_last|Q~0_combout\);

-- Location: FF_X88_Y37_N19
\tf_last|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \tf_last|Q~0_combout\,
	clrn => \ALT_INV_reset_c~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tf_last|Q~q\);

-- Location: MLABCELL_X84_Y30_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


