--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Calculator
--------------------------------------------------------------------------------
-- File        : calc_ctrl_rtl.vhd
-- Author      : Gergely Bereczki <sa21x001@technikum-wien.at>
-- Company     : FH Tecnikum Wien
-- Created     : Sun May  1 12:55:27 2022
-- Last update : Mon May  9 18:43:37 2022
-- Platform    : Digilent Basys3 FPGA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: This is the RTL architecture of the calculator control unit. 
-- This part consists of a statemachine for the user interface, as well as a 
-- 7 segment decoder that is being connected to the IO control unit for displaying. 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- 									TODOS 
-- [-] implement led states
-- [-] decoder for 7 segment
-- [-] implement state changes
-- [ ] if there is time, rework the 7seg decoder, so it's not hardcoded
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- 							Questions 
-- 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- 								Important Notes
-- 								
-- BTNL needs to be connected to pb_sync(3).(MSB)
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

architecture rtl of calc_ctrl is

	type state is (STATE_OP1,STATE_OP2,STATE_TYPE,STATE_CALCULATE,STATE_RESULT);
	signal s_dig0 : std_logic_vector(7 downto 0);
	signal s_dig1 : std_logic_vector(7 downto 0);
	signal s_dig2 : std_logic_vector(7 downto 0);
	signal s_dig3 : std_logic_vector(7 downto 0);
	signal s_leds : std_logic_vector(15 downto 0);
	signal current_state : state;

	alias bcd_dig0 : std_logic_vector(3 downto 0) is swsync_i(3 downto 0);
	alias bcd_dig1 : std_logic_vector(3 downto 0) is swsync_i(7 downto 4);
	alias bcd_dig2 : std_logic_vector(3 downto 0) is swsync_i(11 downto 8);
	alias bcd_type : std_logic_vector(3 downto 0) is swsync_i(15 downto 12);

	alias bcd_res0 : std_logic_vector(3 downto 0) is result_i(3 downto 0);
	alias bcd_res1 : std_logic_vector(3 downto 0) is result_i(7 downto 4);
	alias bcd_res2 : std_logic_vector(3 downto 0) is result_i(11 downto 8);
	alias bcd_res3 : std_logic_vector(3 downto 0) is result_i(15 downto 12);


begin


	led_o <= x"8000" when current_state = STATE_RESULT else x"0000"; 	

	p_interface_fsm : process (reset_i, clk_i)
	variable btnl : std_logic_vector(3 downto 0) := "1000";
	begin
	  if (reset_i = '1') then
	    current_state <= STATE_OP1;
	  elsif (rising_edge(clk_i)) then
		case (current_state) is
			when STATE_OP1 =>
				op1_o  <= swsync_i(11 downto 0);
				if(rising_edge(pbsync_i(3))) then
					current_state  <=  STATE_OP2;
				end if;

			when STATE_OP2  =>
			op2_o  <=  swsync_i(11 downto 0);
				if(rising_edge(pbsync_i(3))) then
					current_state  <=  STATE_TYPE;
				end if;
			when STATE_TYPE  =>
				optype_o <= swsync_i(15 downto 12);
				if(rising_edge(pbsync_i(3))) then
					current_state  <=  STATE_CALCULATE;
					start_o <= '1';
				end if;
			when STATE_CALCULATE => 
				start_o <= '0';
				if(finished_i = '1') then
					current_state <= STATE_RESULT;
				end if;
			when STATE_RESULT => 
				if(rising_edge(pbsync_i(3))) then
					current_state  <=  STATE_OP1;
				end if;
				
			when others =>
				null;
		end case;
	  end if;
	end process p_interface_fsm;


	dig0_o <= s_dig0;
	dig1_o <= s_dig1;
	dig2_o <= s_dig2;
	dig3_o <= s_dig3;
	p_decode_bcd : process (current_state,swsync_i)
	begin
		case (current_state) is
			when STATE_OP1 =>
				s_dig3  <= "00110000"; -- 1
				case (TO_INTEGER(unsigned(bcd_dig0))) is
					when 0 =>
						s_dig0 <= "01111110";
					when 1 =>
						s_dig0 <= "00110000";
					when 2 =>
						s_dig0 <= "01101101";
					when 3 =>
						s_dig0 <= "01111001"; 
					when 4 =>
						s_dig0 <= "00110011";
					when 5 =>
						s_dig0 <= "01011011";
					when 6 =>
						s_dig0 <= "01011111";
					when 7 =>
						s_dig0 <= "01110000"; 
					when 8 =>
						s_dig0 <= "01111111";
					when 9 =>
						s_dig0 <= "01111011";
					when 10 =>
						s_dig0 <= "01110111"; 
					when 11 =>
						s_dig0 <= "00011111";
					when 12 =>
						s_dig0 <= "01001110"; 
					when 13 =>
						s_dig0 <= "00111101"; 
					when 14 =>
						s_dig0 <= "01001111";   
					when 15 =>
						s_dig0 <= "01000111"; 
					when others =>
						null;
				end case;
				case (TO_INTEGER(UNSIGNED(bcd_dig1))) is
					when 0 =>
						s_dig1 <= "01111110";
					when 1 =>
						s_dig1 <= "00110000";
					when 2 =>
						s_dig1 <= "01101101";
					when 3 =>
						s_dig1 <= "01111001"; 
					when 4 =>
						s_dig1 <= "00110011";
					when 5 =>
						s_dig1 <= "01011011";
					when 6 =>
						s_dig1 <= "01011111";
					when 7 =>
						s_dig1 <= "01110000"; 
					when 8 =>
						s_dig1 <= "01111111";
					when 9 =>
						s_dig1 <= "01111011";
					when 10 =>
						s_dig1 <= "01110111"; 
					when 11 =>
						s_dig1 <= "00011111";
					when 12 =>
						s_dig1 <= "01001110"; 
					when 13 =>
						s_dig1 <= "00111101"; 
					when 14 =>
						s_dig1 <= "01001111";   
					when 15 =>
						s_dig1 <= "01000111"; 
					when others =>
						null;
				end case;
				case (TO_INTEGER(UNSIGNED(bcd_dig2))) is
					when 0 =>
						s_dig2 <= "01111110";
					when 1 =>
						s_dig2 <= "00110000";
					when 2 =>
						s_dig2 <= "01101101";
					when 3 =>
						s_dig2 <= "01111001"; 
					when 4 =>
						s_dig2 <= "00110011";
					when 5 =>
						s_dig2 <= "01011011";
					when 6 =>
						s_dig2 <= "01011111";
					when 7 =>
						s_dig2 <= "01110000"; 
					when 8 =>
						s_dig2 <= "01111111";
					when 9 =>
						s_dig2 <= "01111011";
					when 10 =>
						s_dig2 <= "01110111"; 
					when 11 =>
						s_dig2 <= "00011111";
					when 12 =>
						s_dig2 <= "01001110"; 
					when 13 =>
						s_dig2 <= "00111101"; 
					when 14 =>
						s_dig2 <= "01001111";   
					when 15 =>
						s_dig2 <= "01000111"; 
					when others =>
						null;
				end case;

			when STATE_OP2 => 
				s_dig3  <= "01101101"; -- 1
				case (TO_INTEGER(UNSIGNED(bcd_dig0))) is
					when 0 =>
						s_dig0 <= "01111110";
					when 1 =>
						s_dig0 <= "00110000";
					when 2 =>
						s_dig0 <= "01101101";
					when 3 =>
						s_dig0 <= "01111001"; 
					when 4 =>
						s_dig0 <= "00110011";
					when 5 =>
						s_dig0 <= "01011011";
					when 6 =>
						s_dig0 <= "01011111";
					when 7 =>
						s_dig0 <= "01110000"; 
					when 8 =>
						s_dig0 <= "01111111";
					when 9 =>
						s_dig0 <= "01111011";
					when 10 =>
						s_dig0 <= "01110111"; 
					when 11 =>
						s_dig0 <= "00011111";
					when 12 =>
						s_dig0 <= "01001110"; 
					when 13 =>
						s_dig0 <= "00111101"; 
					when 14 =>
						s_dig0 <= "01001111";   
					when 15 =>
						s_dig0 <= "01000111"; 
					when others =>
						null;
				end case;
				case (TO_INTEGER(UNSIGNED(bcd_dig1))) is
					when 0 =>
						s_dig1 <= "01111110";
					when 1 =>
						s_dig1 <= "00110000";
					when 2 =>
						s_dig1 <= "01101101";
					when 3 =>
						s_dig1 <= "01111001"; 
					when 4 =>
						s_dig1 <= "00110011";
					when 5 =>
						s_dig1 <= "01011011";
					when 6 =>
						s_dig1 <= "01011111";
					when 7 =>
						s_dig1 <= "01110000"; 
					when 8 =>
						s_dig1 <= "01111111";
					when 9 =>
						s_dig1 <= "01111011";
					when 10 =>
						s_dig1 <= "01110111"; 
					when 11 =>
						s_dig1 <= "00011111";
					when 12 =>
						s_dig1 <= "01001110"; 
					when 13 =>
						s_dig1 <= "00111101"; 
					when 14 =>
						s_dig1 <= "01001111";   
					when 15 =>
						s_dig1 <= "01000111"; 
					when others =>
						null;
				end case;
				case (TO_INTEGER(UNSIGNED(bcd_dig2))) is
					when 0 =>
						s_dig2 <= "01111110";
					when 1 =>
						s_dig2 <= "00110000";
					when 2 =>
						s_dig2 <= "01101101";
					when 3 =>
						s_dig2 <= "01111001"; 
					when 4 =>
						s_dig2 <= "00110011";
					when 5 =>
						s_dig2 <= "01011011";
					when 6 =>
						s_dig2 <= "01011111";
					when 7 =>
						s_dig2 <= "01110000"; 
					when 8 =>
						s_dig2 <= "01111111";
					when 9 =>
						s_dig2 <= "01111011";
					when 10 =>
						s_dig2 <= "01110111"; 
					when 11 =>
						s_dig2 <= "00011111";
					when 12 =>
						s_dig2 <= "01001110"; 
					when 13 =>
						s_dig2 <= "00111101"; 
					when 14 =>
						s_dig2 <= "01001111";   
					when 15 =>
						s_dig2 <= "01000111"; 
					when others =>
						null;
				end case;
			when STATE_TYPE  => 
				s_dig3 <= "00011101"; -- 'o'
				case (TO_INTEGER(UNSIGNED(bcd_type))) is
					when 0 =>
						s_dig2 <= "01110111";
						s_dig1 <= "00111101";
						s_dig0 <= "00111101";
					when 1 =>
						s_dig2 <= "00111101";
						s_dig1 <= "00110000";
						s_dig0 <= "00011100";
					when 2 =>
						s_dig2 <= "00010101";
						s_dig1 <= "00011101";
						s_dig0 <= "00001111";
					when 3 =>
						s_dig2 <= "00110111";
						s_dig1 <= "00011101";
						s_dig0 <= "00000101";
					when others => 
						null;
					end case;
			when STATE_RESULT => 
				if (error_i = '0') and (overflow_i = '0') and (sign_i = '0') then
					case (TO_INTEGER(UNSIGNED(bcd_res0))) is
					when 0 =>
						s_dig0 <= "01111110";
					when 1 =>
						s_dig0 <= "00110000";
					when 2 =>
						s_dig0 <= "01101101";
					when 3 =>
						s_dig0 <= "01111001"; 
					when 4 =>
						s_dig0 <= "00110011";
					when 5 =>
						s_dig0 <= "01011011";
					when 6 =>
						s_dig0 <= "01011111";
					when 7 =>
						s_dig0 <= "01110000"; 
					when 8 =>
						s_dig0 <= "01111111";
					when 9 =>
						s_dig0 <= "01111011";
					when 10 =>
						s_dig0 <= "01110111"; 
					when 11 =>
						s_dig0 <= "00011111";
					when 12 =>
						s_dig0 <= "01001110"; 
					when 13 =>
						s_dig0 <= "00111101"; 
					when 14 =>
						s_dig0 <= "01001111";   
					when 15 =>
						s_dig0 <= "01000111"; 
					when others =>
						null;
				end case;
				case (TO_INTEGER(UNSIGNED(bcd_res1))) is
					when 0 =>
						s_dig1 <= "01111110";
					when 1 =>
						s_dig1 <= "00110000";
					when 2 =>
						s_dig1 <= "01101101";
					when 3 =>
						s_dig1 <= "01111001"; 
					when 4 =>
						s_dig1 <= "00110011";
					when 5 =>
						s_dig1 <= "01011011";
					when 6 =>
						s_dig1 <= "01011111";
					when 7 =>
						s_dig1 <= "01110000"; 
					when 8 =>
						s_dig1 <= "01111111";
					when 9 =>
						s_dig1 <= "01111011";
					when 10 =>
						s_dig1 <= "01110111"; 
					when 11 =>
						s_dig1 <= "00011111";
					when 12 =>
						s_dig1 <= "01001110"; 
					when 13 =>
						s_dig1 <= "00111101"; 
					when 14 =>
						s_dig1 <= "01001111";   
					when 15 =>
						s_dig1 <= "01000111"; 
					when others =>
						null;
				end case;
				case (TO_INTEGER(UNSIGNED(bcd_res2))) is
					when 0 =>
						s_dig2 <= "01111110";
					when 1 =>
						s_dig2 <= "00110000";
					when 2 =>
						s_dig2 <= "01101101";
					when 3 =>
						s_dig2 <= "01111001"; 
					when 4 =>
						s_dig2 <= "00110011";
					when 5 =>
						s_dig2 <= "01011011";
					when 6 =>
						s_dig2 <= "01011111";
					when 7 =>
						s_dig2 <= "01110000"; 
					when 8 =>
						s_dig2 <= "01111111";
					when 9 =>
						s_dig2 <= "01111011";
					when 10 =>
						s_dig2 <= "01110111"; 
					when 11 =>
						s_dig2 <= "00011111";
					when 12 =>
						s_dig2 <= "01001110"; 
					when 13 =>
						s_dig2 <= "00111101"; 
					when 14 =>
						s_dig2 <= "01001111";   
					when 15 =>
						s_dig2 <= "01000111"; 
					when others =>
						null;
				end case;
				case (TO_INTEGER(UNSIGNED(bcd_res3))) is
					when 0 =>
						s_dig3 <= "01111110";
					when 1 =>
						s_dig3 <= "00110000";
					when 2 =>
						s_dig3 <= "01101101";
					when 3 =>
						s_dig3 <= "01111001"; 
					when 4 =>
						s_dig3 <= "00110011";
					when 5 =>
						s_dig3 <= "01011011";
					when 6 =>
						s_dig3 <= "01011111";
					when 7 =>
						s_dig3 <= "01110000"; 
					when 8 =>
						s_dig3 <= "01111111";
					when 9 =>
						s_dig3 <= "01111011";
					when 10 =>
						s_dig3 <= "01110111"; 
					when 11 =>
						s_dig3 <= "00011111";
					when 12 =>
						s_dig3 <= "01001110"; 
					when 13 =>
						s_dig3 <= "00111101"; 
					when 14 =>
						s_dig3 <= "01001111";   
					when 15 =>
						s_dig3 <= "01000111"; 
					when others =>
						null;
				end case;
				elsif (error_i = '0') and (overflow_i = '0') and (sign_i = '1') then
					s_dig3 <= "00000001"; -- '-'
					case (TO_INTEGER(UNSIGNED(bcd_res0))) is
					when 0 =>
						s_dig0 <= "01111110";
					when 1 =>
						s_dig0 <= "00110000";
					when 2 =>
						s_dig0 <= "01101101";
					when 3 =>
						s_dig0 <= "01111001"; 
					when 4 =>
						s_dig0 <= "00110011";
					when 5 =>
						s_dig0 <= "01011011";
					when 6 =>
						s_dig0 <= "01011111";
					when 7 =>
						s_dig0 <= "01110000"; 
					when 8 =>
						s_dig0 <= "01111111";
					when 9 =>
						s_dig0 <= "01111011";
					when 10 =>
						s_dig0 <= "01110111"; 
					when 11 =>
						s_dig0 <= "00011111";
					when 12 =>
						s_dig0 <= "01001110"; 
					when 13 =>
						s_dig0 <= "00111101"; 
					when 14 =>
						s_dig0 <= "01001111";   
					when 15 =>
						s_dig0 <= "01000111"; 
					when others =>
						null;
				end case;
				case (TO_INTEGER(UNSIGNED(bcd_res1))) is
					when 0 =>
						s_dig1 <= "01111110";
					when 1 =>
						s_dig1 <= "00110000";
					when 2 =>
						s_dig1 <= "01101101";
					when 3 =>
						s_dig1 <= "01111001"; 
					when 4 =>
						s_dig1 <= "00110011";
					when 5 =>
						s_dig1 <= "01011011";
					when 6 =>
						s_dig1 <= "01011111";
					when 7 =>
						s_dig1 <= "01110000"; 
					when 8 =>
						s_dig1 <= "01111111";
					when 9 =>
						s_dig1 <= "01111011";
					when 10 =>
						s_dig1 <= "01110111"; 
					when 11 =>
						s_dig1 <= "00011111";
					when 12 =>
						s_dig1 <= "01001110"; 
					when 13 =>
						s_dig1 <= "00111101"; 
					when 14 =>
						s_dig1 <= "01001111";   
					when 15 =>
						s_dig1 <= "01000111"; 
					when others =>
						null;
				end case;
				case (TO_INTEGER(UNSIGNED(bcd_res2))) is
					when 0 =>
						s_dig2 <= "01111110";
					when 1 =>
						s_dig2 <= "00110000";
					when 2 =>
						s_dig2 <= "01101101";
					when 3 =>
						s_dig2 <= "01111001"; 
					when 4 =>
						s_dig2 <= "00110011";
					when 5 =>
						s_dig2 <= "01011011";
					when 6 =>
						s_dig2 <= "01011111";
					when 7 =>
						s_dig2 <= "01110000"; 
					when 8 =>
						s_dig2 <= "01111111";
					when 9 =>
						s_dig2 <= "01111011";
					when 10 =>
						s_dig2 <= "01110111"; 
					when 11 =>
						s_dig2 <= "00011111";
					when 12 =>
						s_dig2 <= "01001110"; 
					when 13 =>
						s_dig2 <= "00111101"; 
					when 14 =>
						s_dig2 <= "01001111";   
					when 15 =>
						s_dig2 <= "01000111"; 
					when others =>
						null;
				end case;
				elsif (error_i = '0') and (overflow_i = '1')  then
					s_dig0 <= "00011101";
					s_dig1 <= "00011101";
					s_dig2 <= "00011101";
					s_dig3 <= "00011101";
				elsif (error_i = '1') then
					s_dig0 <= "00000101";
					s_dig1 <= "00000101";
					s_dig2 <= "01001111";
					s_dig3 <= "00000000";
				end if;
			when STATE_CALCULATE => 
				s_dig0 <= "00000000";
				s_dig1 <= "00000000";
				s_dig2 <= "00000000";
				s_dig3 <= "00000000";
			when others =>
				null;
		end case;
	end process p_decode_bcd;
	
end architecture rtl;