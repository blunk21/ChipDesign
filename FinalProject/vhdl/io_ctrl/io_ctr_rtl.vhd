--------------------------------------------------------------------------------
-- Title       : Architecture of IO control
-- Project     : Calculator
--------------------------------------------------------------------------------
-- File        : io_ctrl_rtl.vhd
-- Author      : Gergely Bereczki <sa21x001@technikum-wien.at>
-- Company     : FH Technikum Wien
-- Created     : Mon Apr  4 10:52:33 2022
-- Last update : Sun Apr 17 23:17:04 2022
-- Platform    : Digilent Basys3 FPGA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Description: IO control unit manages the pusbuttons and switches of the platform this project
-- is being developed for.
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 								Changelog
--
-- *****************************************************************************
-- 
-- version:			comment:
-- -------- 		--------
-- 0.0.0 			creating skeleton
-- 0.0.1 			
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

architecture rtl of io_ctrl is
	constant C_EN_COUNTVAL : std_logic_vector(16 downto 0) := x"186A0"; 



	signal s_setfreq_cntr : std_logic_vector(15 downto 0);
	signal s_enable_refresh : std_logic;
	signal s_switch_sync : std_logic_vector(15 downto 0);
	signal s_btn_sync : std_logic_vector(3 downto 0);
	signal s_ss_sel : std_logic_vector(3 downto 0);
	signal s_ss : std_logic_vector(7 downto 0);

begin

	p_refresh_display : process (reset_i, clk)
	----------------------------------------------------------------------------
	-- 1 kHz clock
	----------------------------------------------------------------------------
	
	begin
	  if (reset_i = '1') then
	    s_setfreq_cntr <= '0';
	    s_enable_refresh <= (others => '0');

	  elsif (rising_edge(clk)) then
	  	if (s_setfreq_cntr >= C_EN_COUNTVAL) then
	  		s_setfreq_cntr <= (others => '0');
		else
	  		s_setfreq_cntr <= s_setfreq_cntr + '1';

	  end if;
	end process p_refresh_display;

	s_enable_refresh <= '1' when s_setfreq_cntr=C_EN_COUNTVAL else '0';

	----------------------------------------------------------------------------


	----------------------------------------------------------------------------
	-- Debounce
	----------------------------------------------------------------------------
	
	p_debounce : process (reset_i, clk)
	begin
	  if (reset_i = '1') then
	    s_switch_sync <= x"0000";
	    s_btn_sync <= 0x"00";

	  elsif (rising_edge(clk)) then
		if (s_enable_refresh) then
			s_switch_sync <= sw_i;
			s_btn_sync <= pb_i;
		else 
			s_switch_sync <= x"0000";
	    	s_btn_sync <= 0x"00";	
			
		end if;
	  end if;
	end process p_debounce;

	----------------------------------------------------------------------------
	-- Control display
	----------------------------------------------------------------------------
	

	p_control_display : process (reset, clk)
	begin
	  if (reset = '1') then
	    
	  elsif (rising_edge(clk)) then
	
	  end if;
	end process p_control_display;




end rtl;



