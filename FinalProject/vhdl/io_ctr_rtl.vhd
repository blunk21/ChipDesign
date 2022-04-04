--------------------------------------------------------------------------------
-- Title       : Architecture of IO control
-- Project     : Calculator
--------------------------------------------------------------------------------
-- File        : io_ctrl_rtl.vhd
-- Author      : Gergely Bereczki <sa21x001@technikum-wien.at>
-- Company     : FH Technikum Wien
-- Created     : Mon Apr  4 10:52:33 2022
-- Last update : Mon Apr  4 10:56:18 2022
-- Platform    : Digilent Basys3 FPGA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Description: IO control unit manages the pusbuttons and switches of the platform this project
-- is being developed for.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

architecture rtl of io_ctrl is
	constant C_ENCOUNTVAL : std_logic_vector(16 downto 0) := "11000011010100000"; 

	signal clock : std_logic;

begin

end rtl;

