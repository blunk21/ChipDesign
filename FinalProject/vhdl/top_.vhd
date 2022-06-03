--------------------------------------------------------------------------------
-- Title       : Top level entity
-- Project     : Calculator
--------------------------------------------------------------------------------
-- File        : top_.vhd
-- Author      : Gergely Bereczki <sa21x001@technikum-wien.at>
-- Company     : FH Tecnikum Wien
-- Created     : Mon May 30 15:00:40 2022
-- Last update : Mon May 30 16:15:36 2022
-- Platform    : Digilent Basys3 FPGA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: Describes the entitiy of the top level
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
	port (
			clk_i : in std_logic;
			reset_i : in std_logic;
			ss_o : out std_logic_vector(7 downto 0);
			ss_sel_o : out std_logic_vector(3 downto 0);
			pb_i : in std_logic_vector(3 downto 0);
			sw_i : in std_logic_vector(15 downto 0);
			led_o : out std_logic_vector(15 downto 0)


		);
end entity top;
