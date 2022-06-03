--------------------------------------------------------------------------------
-- Title       : Testbench Toplevel
-- Project     : Calculator
--------------------------------------------------------------------------------
-- File        : top_tb.vhd
-- Author      : Gergely Bereczki <sa21x001@technikum-wien.at>
-- Company     : FH Tecnikum Wien
-- Created     : Mon May 30 16:20:39 2022
-- Last update : Tue May 31 18:09:28 2022
-- Platform    : Digilent Basys3 FPGA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: Testbench for the top level implementation
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity top_tb is

end entity top_tb;

-----------------------------------------------------------

architecture testbench of top_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal clk_i    : std_logic;
	signal reset_i  : std_logic;
	signal ss_o     : std_logic_vector(7 downto 0);
	signal ss_sel_o : std_logic_vector(3 downto 0);
	signal pb_i     : std_logic_vector(3 downto 0);
	signal sw_i     : std_logic_vector(15 downto 0);
	signal led_o    : std_logic_vector(15 downto 0);

	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- NS

begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
		clk_i <= '1';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
		clk_i <= '0';
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
	p_testing : process
	begin
		wait for 210 ns;
		pb_i <= (others => '0');
		sw_i <= (others => '0');
		wait for 100 ns;
		sw_i <= x"0001";
		pb_i <= "1000";
		wait for 3 ms;
		pb_i <= "0000";
		wait for 3 ms;
		sw_i <= x"0002";
		pb_i <= "1000";
		wait for 3 ms;
		pb_i <= "0000";
		sw_i <= x"0000";
		wait for 100 ns;
		pb_i <= "1000";
		wait for 3 ms;
		pb_i <= "0000";
		wait for 3 ms;
		pb_i <= "1000";
		wait for 3 ms;
		pb_i <= "0000";
		wait;
		

		
		
	end process;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.top
		port map (
			clk_i    => clk_i,
			reset_i  => reset_i,
			ss_o     => ss_o,
			ss_sel_o => ss_sel_o,
			pb_i     => pb_i,
			sw_i     => sw_i,
			led_o    => led_o
		);

end architecture testbench;