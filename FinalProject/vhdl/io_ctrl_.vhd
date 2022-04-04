--------------------------------------------------------------------------------
-- Title       : Entitiy of IO control
-- Project     : Calculator
--------------------------------------------------------------------------------
-- File        : io_ctrl_.vhd
-- Author      : Gergely Bereczki <sa21x001@technikum-wien.at>
-- Company     : FH Technikum Wien
-- Created     : Mon Apr  4 10:26:33 2022
-- Last update : Mon Apr  4 10:53:36 2022
-- Platform    : Digilent Basys3 FPGA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Description: IO control unit manages the pusbuttons and switches of the platform this project
-- is being developed for.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity io_ctrl is
	port (
		clock : in std_logic;
		reset_i: in std_logic;
		dig0_i : in std_logic_vector(7 downto 0);
		dig1_i : in std_logic_vector(7 downto 0);
		dig2_i : in std_logic_vector(7 downto 0);
		dig3_i : in std_logic_vector(7 downto 0);
		led_i : in std_logic_vector(15 downto 0);
		sw_i : in std_logic_vector(15 downto 0);
		pb_i : in std_logic_vector(3 downto 0);
		ss_o : out std_logic_vector(7 downto 0);
		ss_sel_o : out std_logic_vector(3 downto 0);
		swsync_o : out std_logic_vector(15 downto 0);
		pbsync_o : out std_logic_vector(3 downto 0)

	) ;
end io_ctrl;


