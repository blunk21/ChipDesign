--------------------------------------------------------------------------------
-- Title       : Calculator control
-- Project     : Calculator
--------------------------------------------------------------------------------
-- File        : calc_ctrl_.vhd
-- Author      : Gergely Bereczki <sa21x001@technikum-wien.at>
-- Company     : FH Tecnikum Wien
-- Created     : Sun May  1 12:16:38 2022
-- Last update : Sun May  1 13:12:21 2022
-- Platform    : Digilent Basys3 FPGA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: This is the vhdl description for the calculator control module entity 
-- which is for providing the neccessary operands for the ALU while also keeping it 
-- in sync wit the IO control unit.
--------------------------------------------------------------------------------

entity calc_ctrl is
	port (
		clk_i : in std_logic;
		reset_i : in std_logic;

		swsync_i : in std_logic_vector(15 downto 0);
		pbsync_i : in std_logic_vector(3 downto 0);
		finished_i : in std_logic;
		result_i : in std_logic_vector(15 downto 0);
		sign_i : in std_logic;
		overflow_i : in std_logic;
		error_i : in std_logic;
		
		op1_o : out std_logic_vector(11 downto 0);
		op2_o : out std_logic_vector(11 downto 0);
		optype_o : out std_logic_vector(3 downto 0);
		start_o : out std_logic;
		dig0_o : out std_logic_vector(7 downto 0);
		dig1_o : out std_logic_vector(7 downto 0);
		dig2_o : out std_logic_vector(7 downto 0);
		dig3_o : out std_logic_vector(7 downto 0);
		led_o : out std_logic_vector(15 downto 0)
				);

end calc_ctrl;