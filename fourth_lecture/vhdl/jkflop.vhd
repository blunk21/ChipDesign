--------------------------------------------------------------------------------
-- Title       : A very good descriptive title
-- Project     : JK Flip Flop
--------------------------------------------------------------------------------
-- File        : jkflop.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Mon Mar  7 11:29:14 2022
-- Last update : Mon Mar  7 12:07:47 2022
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2022 User Company Name
-------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------
-- Revisions:  Revisions and documentation are controlled by
-- the revision control system (RCS).  The RCS should be consulted
-- on revision history.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity jkflop is
	port (
		j_in	: in	std_logic;
		k_in	: in	std_logic;
		rst 	: in	std_logic;
		clk 	: in 	std_logic;
		q_out	: out	std_logic
	);
end entity jkflop;

architecture rtl of jkflop is

signal current_outp : std_logic;

begin

	jk_ff : process
	begin
		if rst = '1' then
			current_outp <= '0';
		elsif (clk'event and clk = '1') then
			if j_in = '0' and k_in = '0' then
				current_outp <= current_outp;
			elsif j_in = '1' and k_in = '0' then
				current_outp <= '1';
			elsif j_in = '0' and k_in = '1' then
				current_outp <= '0';
			elsif j_in = '1' and k_in = '1' then
				current_outp <= not(current_outp);
			else
				current_outp <= 'Z';
			end if ;
			q_out <= current_outp;
		end if ;
	end process jk_ff;
	
end architecture rtl;

