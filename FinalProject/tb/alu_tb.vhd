--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Calculator
--------------------------------------------------------------------------------
-- File        : alu_tb.vhd
-- Author      : Gergely Bereczki <sa21x001@technikum-wien.at>
-- Company     : FH Tecnikum Wien
-- Created     : Sun May 15 11:46:06 2022
-- Last update : Mon May 30 14:31:54 2022
-- Platform    : Digilent Basys3 FPGA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity alu_tb is

end entity alu_tb;

-----------------------------------------------------------

architecture testbench of alu_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal clk_i      : std_logic;
	signal reset_i    : std_logic;
	signal op1_i      : std_logic_vector(11 downto 0) := (others => '0');
	signal op2_i      : std_logic_vector(11 downto 0):= (others => '0');
	signal optype_i   : std_logic_vector(3 downto 0):= (others => '0');
	signal start_i    : std_logic := '0';
	signal finished_o : std_logic;
	signal result_o   : std_logic_vector(15 downto 0) := (others => '0');
	signal sign_o     : std_logic;
	signal overflow_o : std_logic;
	signal error_o    : std_logic;

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
		reset_i <= '1', '0' after 20.0*C_CLK_PERIOD * (1 SEC);
		wait;
	end process RESET_GEN;

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------
	
	p_testing : process
	begin
		wait for 220 ns;
		

		
		op1_i <= x"005";
		op2_i <= x"001";
		wait for 30 ns;
		
		optype_i <= "0001";
		wait for 20 ns;
		
		start_i<= '1';

		
		while(finished_o < '1') loop
			wait for 1 ns;
		end loop;
		start_i  <= '0';

		optype_i <= "0000";
		wait for 20 ns;
		start_i <= '1';

		while(finished_o < '1') loop
			wait for 1 ns;
		end loop;
		start_i  <= '0';


	end process p_testing;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.alu
		port map (
			clk_i      => clk_i,
			reset_i    => reset_i,
			op1_i      => op1_i,
			op2_i      => op2_i,
			optype_i   => optype_i,
			start_i    => start_i,
			finished_o => finished_o,
			result_o   => result_o,
			sign_o     => sign_o,
			overflow_o => overflow_o,
			error_o    => error_o
		);

end architecture testbench;