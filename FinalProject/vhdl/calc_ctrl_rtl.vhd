--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Calculator
--------------------------------------------------------------------------------
-- File        : calc_ctrl_rtl.vhd
-- Author      : Gergely Bereczki <sa21x001@technikum-wien.at>
-- Company     : FH Tecnikum Wien
-- Created     : Sun May  1 12:55:27 2022
-- Last update : Sun May  1 13:12:22 2022
-- Platform    : Digilent Basys3 FPGA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: This is the RTL architecture of the calculator control unit. 
-- This part consists of a statemachine for the user interface, as well as a 
-- 7 segment decoder that is being connected to the IO control unit for displaying. 
--------------------------------------------------------------------------------

architecture rtl of calc_ctrl is

	type state is (STATE_OP1,STATE_OP2,STATE_TYPE,STATE_CALCULATE,STATE_DISPLAY);
	signal current_state : state;
begin

	p_interface_fsm : process (reset_i, clk_i)
	begin
	  if (reset_i = '1') then
	    
	  elsif (rising_edge(clk_i)) then
	
	  end if;
	end process p_interface_fsm;
	
end architecture rtl;