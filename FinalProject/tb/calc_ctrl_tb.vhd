--------------------------------------------------------------------------------
-- Title       : <Calculator control testbench>
-- Project     : Calculator
--------------------------------------------------------------------------------
-- File        : calc_ctrl_tb.vhd
-- Author      : Gergely Bereczki <sa21x001@technikum-wien.at>
-- Company     : FH Tecnikum Wien
-- Created     : Mon May  9 09:03:22 2022
-- Last update : Mon May  9 19:15:19 2022
-- Platform    : Digilent Basys3 FPGA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: Testbench for testing the functionalities of the 
-- calculator control block.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity calc_ctrl_tb is

end entity calc_ctrl_tb;

-----------------------------------------------------------

architecture testbench of calc_ctrl_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal clk_i      : std_logic := '0';
	signal reset_i    : std_logic := '0';
	signal swsync_i   : std_logic_vector(15 downto 0) := (others => '0');
	signal pbsync_i   : std_logic_vector(3 downto 0):= (others => '0');
	signal finished_i : std_logic:= '0';
	signal result_i   : std_logic_vector(15 downto 0):= (others => '0');
	signal sign_i     : std_logic:= '0';
	signal overflow_i : std_logic:= '0';
	signal error_i    : std_logic:= '0';
	signal op1_o      : std_logic_vector(11 downto 0) := (others => '0');
	signal op2_o      : std_logic_vector(11 downto 0):= (others => '0');
	signal optype_o   : std_logic_vector(3 downto 0):= (others => '0');
	signal start_o    : std_logic := '0';
	signal dig0_o     : std_logic_vector(7 downto 0):= (others => '0');
	signal dig1_o     : std_logic_vector(7 downto 0):= (others => '0');
	signal dig2_o     : std_logic_vector(7 downto 0):= (others => '0');
	signal dig3_o     : std_logic_vector(7 downto 0):= (others => '0');
	signal led_o      : std_logic_vector(15 downto 0):= (others => '0');

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
		PROCESS_SIM : process
		begin
			--------------------------------------------------------------------
			-- swsync_i   <= (others => '0');
			--	pbsync_i   <= (others => '0');
			--	finished_i   <= '0';
			--	result_i   <= (others => '0');
			--	sign_i   <= '0';
			--	overflow_i   <= '0';
			--	error_i   <= '0'; 
			--	op1_o   <= (others => '0');
			--	op2_o    <= (others => '0');
			--	optype_o   <= (others => '0');
			--	start_o   <= '0';
			--	dig0_o   <= (others => '0');
			--	dig1_o   <= (others => '0');
			--	dig2_o   <= (others => '0');
			--	dig3_o    <= (others => '0');
			--	led_o    <= (others => '0');
			--------------------------------------------------------------------
			

			-------------------------------------------------------------------- STATE OP1
		  wait for 210 ns;
		  swsync_i <= x"1001"; --op1 = 1
		  wait for 30 ns;
		  swsync_i <=  x"1010"; --op1 = 16
		  pbsync_i <= "0001";--bad btn
		  wait for 30 ns;
		  pbsync_i <= "1000";--btnl pressed
		  wait for 30 ns;
		  pbsync_i <= "0000";--btnl released
		  ---------------------------------------------------------------------- STATE OP2
		  swsync_i <= x"1000";
		  wait for 30 ns;
		  swsync_i <= x"1010";--op2 also 16
		  wait for 30 ns;
		  pbsync_i <= "1000";
		  wait for 30 ns;
		  pbsync_i <= "0000";
		  wait for 50 ns;
		  ---------------------------------------------------------------------- STATE TYPE
		  swsync_i <= x"1011";
		  wait for 30 ns;
		  swsync_i <= x"0123";
		  pbsync_i <= "1000";
		  wait for 30 ns;
		  pbsync_i <= "0000";
		  wait for 100 ns;
		  ---------------------------------------------------------------------- STATE CALC
		  result_i <= x"0020";
		  finished_i <= '1';
		  wait for 100 ns;
		  ---------------------------------------------------------------------- STATE RESULT
		  sign_i <= '1';
		  wait for 60 ns;
		  --sign_i <= '0';
		  overflow_i <= '1';
		  wait for 60 ns;
		  error_i <= '1';
		  wait for 60 ns;
		  pbsync_i <= "1000";
		  pbsync_i <= "0000";

		end process PROCESS_SIM;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.calc_ctrl
		port map (
			clk_i      => clk_i,
			reset_i    => reset_i,
			swsync_i   => swsync_i,
			pbsync_i   => pbsync_i,
			finished_i => finished_i,
			result_i   => result_i,
			sign_i     => sign_i,
			overflow_i => overflow_i,
			error_i    => error_i,
			op1_o      => op1_o,
			op2_o      => op2_o,
			optype_o   => optype_o,
			start_o    => start_o,
			dig0_o     => dig0_o,
			dig1_o     => dig1_o,
			dig2_o     => dig2_o,
			dig3_o     => dig3_o,
			led_o      => led_o
		);

end architecture testbench;