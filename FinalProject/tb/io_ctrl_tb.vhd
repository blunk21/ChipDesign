--------------------------------------------------------------------------------
-- Title       : IO Control testbench
-- Project     : Calculator
--------------------------------------------------------------------------------
-- File        : io_ctrl_tb.vhd
-- Author      : Gergely Bereczki <user.email@user.company.com>
-- Company     : FH Technikum Wie
-- Created     : Mon Apr 18 10:29:44 2022
-- Last update : Mon Apr 25 10:58:59 2022
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Description: Testbench for the IO control unit of the calculator
--------------------------------------------------------------------------------
-- Revisions:  Revisions and documentation are controlled by
-- the revision control system (RCS).  The RCS should be consulted
-- on revision history.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use IEEE.std_logic_unsigned.all;


-----------------------------------------------------------

entity io_ctrl_tb is

end entity io_ctrl_tb;

-----------------------------------------------------------

architecture testbench of io_ctrl_tb is

	


	-- Testbench DUT generics
	signal cntr_signal :std_logic_vector(19 downto 0);
	signal slow_clock : std_logic;
	-- Testbench DUT ports
	signal clk      : std_logic;
	signal reset_i  : std_logic;
	signal dig0_i   : std_logic_vector(7 downto 0);
	signal dig1_i   : std_logic_vector(7 downto 0);
	signal dig2_i   : std_logic_vector(7 downto 0);
	signal dig3_i   : std_logic_vector(7 downto 0);
	signal led_i    : std_logic_vector(15 downto 0);
	signal led_o    : std_logic_vector(15 downto 0);
	signal sw_i     : std_logic_vector(15 downto 0);
	signal pb_i     : std_logic_vector(3 downto 0);
	signal ss_o     : std_logic_vector(7 downto 0);
	signal ss_sel_o : std_logic_vector(3 downto 0);
	signal swsync_o : std_logic_vector(15 downto 0);
	signal pbsync_o : std_logic_vector(3 downto 0);


	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- NS

begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
		clk <= '1';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
		clk <= '0';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
	end process CLK_GEN;

	RESET_GEN : process
	begin
		reset_i <= '1',
			'0' after 20.0*C_CLK_PERIOD * (1 SEC);
		wait;
	end process RESET_GEN;

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------
	process_sim : process
	begin

		wait for 300 ns; --wait for reset
		sw_i <= (others => '0');
		pb_i <= (others => '0');
		led_i <= (others => '0');
		dig0_i <= x"01";
		dig1_i <= x"02";
		dig2_i <= x"03";
		dig3_i <= x"04";
		wait for 2 ms;
		sw_i <= x"0083";
		pb_i <= x"1";
		wait for 2 ms;
		sw_i <= x"0000";
		pb_I <= x"0";
		led_i <= x"FFFF";
		wait for 2 ms;
		sw_i <= x"0082";
		pb_I <= x"2";
		wait for 400 us;
		sw_i <= x"0000";
		pb_I <= x"0";
		led_i <= x"0000";
		wait for 2 ms;
		dig0_i <= x"02";
		dig1_i <= x"03";
		dig2_i <= x"04";
		dig3_i <= x"05";
		wait for 2 ms;

	end process;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.io_ctrl
		port map (
			clk      => clk,
			reset_i  => reset_i,
			dig0_i   => dig0_i,
			dig1_i   => dig1_i,
			dig2_i   => dig2_i,
			dig3_i   => dig3_i,
			led_i    => led_i,
			led_o    => led_o,
			sw_i     => sw_i,
			pb_i     => pb_i,
			ss_o     => ss_o,
			ss_sel_o => ss_sel_o,
			swsync_o => swsync_o,
			pbsync_o => pbsync_o
		);

end architecture testbench;
