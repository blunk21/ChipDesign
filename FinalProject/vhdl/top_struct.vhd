--------------------------------------------------------------------------------
-- Title       : Top level architecture
-- Project     : Calculator
--------------------------------------------------------------------------------
-- File        : top_struct.vhd
-- Author      : Gergely Bereczki <sa21x001@technikum-wien.at>
-- Company     : FH Tecnikum Wien
-- Created     : Mon May 30 15:05:00 2022
-- Last update : Tue May 31 18:01:37 2022
-- Platform    : Digilent Basys3 FPGA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: Describes the behaviour of the top level architecture. 
-- This level is in connection with the actual IO ports of the target device.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


architecture struct of top is

	component io_ctrl is
		port (
			clk      : in  std_logic;
			reset_i  : in  std_logic;
			dig0_i   : in  std_logic_vector(7 downto 0);
			dig1_i   : in  std_logic_vector(7 downto 0);
			dig2_i   : in  std_logic_vector(7 downto 0);
			dig3_i   : in  std_logic_vector(7 downto 0);
			led_i    : in  std_logic_vector(15 downto 0);
			led_o    : out std_logic_vector(15 downto 0);
			sw_i     : in  std_logic_vector(15 downto 0);
			pb_i     : in  std_logic_vector(3 downto 0);
			ss_o     : out std_logic_vector(7 downto 0);
			ss_sel_o : out std_logic_vector(3 downto 0);
			swsync_o : out std_logic_vector(15 downto 0);
			pbsync_o : out std_logic_vector(3 downto 0)
		);
	end component io_ctrl;

	component calc_ctrl is
		port (
			clk_i      : in  std_logic;
			reset_i    : in  std_logic;
			swsync_i   : in  std_logic_vector(15 downto 0);
			pbsync_i   : in  std_logic_vector(3 downto 0);
			finished_i : in  std_logic;
			result_i   : in  std_logic_vector(15 downto 0);
			sign_i     : in  std_logic;
			overflow_i : in  std_logic;
			error_i    : in  std_logic;
			op1_o      : out std_logic_vector(11 downto 0);
			op2_o      : out std_logic_vector(11 downto 0);
			optype_o   : out std_logic_vector(3 downto 0);
			start_o    : out std_logic;
			dig0_o     : out std_logic_vector(7 downto 0);
			dig1_o     : out std_logic_vector(7 downto 0);
			dig2_o     : out std_logic_vector(7 downto 0);
			dig3_o     : out std_logic_vector(7 downto 0);
			led_o      : out std_logic_vector(15 downto 0)
		);
	end component calc_ctrl;

	component alu is
		port (
			clk_i      : in  std_logic;
			reset_i    : in  std_logic;
			op1_i      : in  std_logic_vector(11 downto 0);
			op2_i      : in  std_logic_vector(11 downto 0);
			optype_i   : in  std_logic_vector(3 downto 0);
			start_i    : in  std_logic;
			finished_o : out std_logic;
			result_o   : out std_logic_vector(15 downto 0);
			sign_o     : out std_logic;
			overflow_o : out std_logic;
			error_o    : out std_logic
		);
	end component alu;

	signal swsync : std_logic_vector(15 downto 0);
	signal pbsync : std_logic_vector(3 downto 0);
	--signal sw : std_logic_vector(15 downto 0);
	--signal pb : std_logic_vector(3 downto 0);
	signal led : std_logic_vector(15 downto 0);
	--signal ss : std_logic_vector(7 downto 0);
	--signal ss_sel : std_logic_vector(3 downto 0);
	signal dig0 : std_logic_vector(7 downto 0);
	signal dig1 : std_logic_vector(7 downto 0);
	signal dig2 : std_logic_vector(7 downto 0);
	signal dig3 : std_logic_vector(7 downto 0);
	signal start: std_logic;
	signal finished: std_logic;
	signal signn : std_logic;
	signal overflow: std_logic;
	signal err : std_logic;
	signal result : std_logic_vector(15 downto 0);
	signal op1 : std_logic_vector(11 downto 0);
	signal op2 : std_logic_vector(11 downto 0);
	signal optype: std_logic_vector(3 downto 0);				

begin

	io_ctrl_1 : entity work.io_ctrl
		port map (
			clk_i      => clk_i,
			reset_i  => reset_i,
			dig0_i   => dig0,
			dig1_i   => dig1,
			dig2_i   => dig2,
			dig3_i   => dig3,
			led_i    => led,
			led_o    => led,
			sw_i     => sw_i,
			pb_i     => pb_i,
			ss_o     => ss_o,
			ss_sel_o => ss_sel_o,
			swsync_o => swsync,
			pbsync_o => pbsync
		);

	calc_ctrl_1 : entity work.calc_ctrl
		port map (
			clk_i      => clk_i,
			reset_i    => reset_i,
			swsync_i   => swsync,
			pbsync_i   => pbsync,
			finished_i => finished,
			result_i   => result,
			sign_i     => signn,
			overflow_i => overflow,
			error_i    => err,
			op1_o      => op1,
			op2_o      => op2,
			optype_o   => optype,
			start_o    => start,
			dig0_o     => dig0,
			dig1_o     => dig1,
			dig2_o     => dig2,
			dig3_o     => dig3,
			led_o      => led
		);	

	alu_1 : entity work.alu
		port map (
			clk_i      => clk_i,
			reset_i    => reset_i,
			op1_i      => op1,
			op2_i      => op2,
			optype_i   => optype,
			start_i    => start,
			finished_o => finished,
			result_o   => result,
			sign_o     => signn,
			overflow_o => overflow,
			error_o    => err
		);				
end struct;

