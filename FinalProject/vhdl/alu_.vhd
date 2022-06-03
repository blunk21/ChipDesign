--------------------------------------------------------------------------------
-- Title       : ALU
-- Project     : Calculator
--------------------------------------------------------------------------------
-- File        : alu_.vhd
-- Author      : Gergely Bereczki <sa21x001@technikum-wien.at>
-- Company     : FH Tecnikum Wien
-- Created     : Sun May 15 10:18:25 2022
-- Last update : Sun May 15 10:22:58 2022
-- Platform    : Digilent Basys3 FPGA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: Declaration of the ALU entity.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	port (
		clk_i : in std_logic;
		reset_i : in std_logic;
		op1_i : in std_logic_vector(11 downto 0);
		op2_i : in std_logic_vector(11 downto 0);
		optype_i: in std_logic_vector(3 downto 0);
		start_i : in std_logic;

		finished_o : out std_logic;
		result_o : out std_logic_vector(15 downto 0);
		sign_o : out std_logic;
		overflow_o : out std_logic;
		error_o : out std_logic
	);
end alu;
