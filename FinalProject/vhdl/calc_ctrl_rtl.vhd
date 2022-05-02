--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Calculator
--------------------------------------------------------------------------------
-- File        : calc_ctrl_rtl.vhd
-- Author      : Gergely Bereczki <sa21x001@technikum-wien.at>
-- Company     : FH Tecnikum Wien
-- Created     : Sun May  1 12:55:27 2022
-- Last update : Mon May  2 10:46:06 2022
-- Platform    : Digilent Basys3 FPGA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: This is the RTL architecture of the calculator control unit. 
-- This part consists of a statemachine for the user interface, as well as a 
-- 7 segment decoder that is being connected to the IO control unit for displaying. 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- 									TODOS 
-- [ ] implement led states
-- [-] decoder for 7 segment
-- [ ] implement state changes
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- 							Questions 
-- 1. Decoding is not too hardcoded? - move the decoder out of the statemachine in a "central position"
-- 2. How do you know if buttonl is pressed what are the bit orders? - it's up to me completely to map the btns
-- 3. How are decimal points handled?
--------------------------------------------------------------------------------



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
	alias bcd_res0 : std_logic_vector(3 downto 0) is result_i(7 downto 4);
	alias bcd_res0 : std_logic_vector(3 downto 0) is result_i(11 downto 8);
	alias bcd_res0 : std_logic_vector(3 downto 0) is result_i(15 downto 12);


begin

	p_interface_fsm : process (reset_i, clk_i)
	variable btnl : std_logic_vector(3 downto 0) := "1000";
	begin
	  if (reset_i = '1') then
	    current_state <= STATE_OP1;
	  elsif (rising_edge(clk_i)) then
		case (current_state) is
			when STATE_OP1 =>
				
			when others =>
				null;
		end case;
	  end if;
	end process p_interface_fsm;

	p_decode_bcd : process (current_state,swsync_i)
	begin
		case (current_state) is
			when STATE_OP1 =>
				s_dig3  <= "0110000"; -- 1
				case (bcd_dig0) is
					when 0 =>
						s_dig0 <= "1111110";
					when 1 =>
						s_dig0 <= "0110000";
					when 2 =>
						s_dig0 <= "1101101";
					when 3 =>
						s_dig0 <= "1111001"; 
					when 4 =>
						s_dig0 <= "0110011";
					when 5 =>
						s_dig0 <= "1011011";
					when 6 =>
						s_dig0 <= "1011111";
					when 7 =>
						s_dig0 <= "1110000"; 
					when 8 =>
						s_dig0 <= "1111111";
					when 9 =>
						s_dig0 <= "1111011";
					when 10 =>
						s_dig0 <= "1110111"; 
					when 11 =>
						s_dig0 <= "0011111";
					when 12 =>
						s_dig0 <= "1001110"; 
					when 13 =>
						s_dig0 <= "0111101"; 
					when 14 =>
						s_dig0 <= "1001111";   
					when 15 =>
						s_dig0 <= "1000111"; 
					when others =>
						null;
				end case;
				case (bcd_dig1) is
					when 0 =>
						s_dig1 <= "1111110";
					when 1 =>
						s_dig1 <= "0110000";
					when 2 =>
						s_dig1 <= "1101101";
					when 3 =>
						s_dig1 <= "1111001"; 
					when 4 =>
						s_dig1 <= "0110011";
					when 5 =>
						s_dig1 <= "1011011";
					when 6 =>
						s_dig1 <= "1011111";
					when 7 =>
						s_dig1 <= "1110000"; 
					when 8 =>
						s_dig1 <= "1111111";
					when 9 =>
						s_dig1 <= "1111011";
					when 10 =>
						s_dig1 <= "1110111"; 
					when 11 =>
						s_dig1 <= "0011111";
					when 12 =>
						s_dig1 <= "1001110"; 
					when 13 =>
						s_dig1 <= "0111101"; 
					when 14 =>
						s_dig1 <= "1001111";   
					when 15 =>
						s_dig1 <= "1000111"; 
					when others =>
						null;
				end case;
				case (bcd_dig2) is
					when 0 =>
						s_dig2 <= "1111110";
					when 1 =>
						s_dig2 <= "0110000";
					when 2 =>
						s_dig2 <= "1101101";
					when 3 =>
						s_dig2 <= "1111001"; 
					when 4 =>
						s_dig2 <= "0110011";
					when 5 =>
						s_dig2 <= "1011011";
					when 6 =>
						s_dig2 <= "1011111";
					when 7 =>
						s_dig2 <= "1110000"; 
					when 8 =>
						s_dig2 <= "1111111";
					when 9 =>
						s_dig2 <= "1111011";
					when 10 =>
						s_dig2 <= "1110111"; 
					when 11 =>
						s_dig2 <= "0011111";
					when 12 =>
						s_dig2 <= "1001110"; 
					when 13 =>
						s_dig2 <= "0111101"; 
					when 14 =>
						s_dig2 <= "1001111";   
					when 15 =>
						s_dig2 <= "1000111"; 
					when others =>
						null;
				end case;

			when STATE_OP2 => 
				s_dig3  <= "1101101"; -- 1
				case (bcd_dig0) is
					when 0 =>
						s_dig0 <= "1111110";
					when 1 =>
						s_dig0 <= "0110000";
					when 2 =>
						s_dig0 <= "1101101";
					when 3 =>
						s_dig0 <= "1111001"; 
					when 4 =>
						s_dig0 <= "0110011";
					when 5 =>
						s_dig0 <= "1011011";
					when 6 =>
						s_dig0 <= "1011111";
					when 7 =>
						s_dig0 <= "1110000"; 
					when 8 =>
						s_dig0 <= "1111111";
					when 9 =>
						s_dig0 <= "1111011";
					when 10 =>
						s_dig0 <= "1110111"; 
					when 11 =>
						s_dig0 <= "0011111";
					when 12 =>
						s_dig0 <= "1001110"; 
					when 13 =>
						s_dig0 <= "0111101"; 
					when 14 =>
						s_dig0 <= "1001111";   
					when 15 =>
						s_dig0 <= "1000111"; 
					when others =>
						null;
				end case;
				case (bcd_dig1) is
					when 0 =>
						s_dig1 <= "1111110";
					when 1 =>
						s_dig1 <= "0110000";
					when 2 =>
						s_dig1 <= "1101101";
					when 3 =>
						s_dig1 <= "1111001"; 
					when 4 =>
						s_dig1 <= "0110011";
					when 5 =>
						s_dig1 <= "1011011";
					when 6 =>
						s_dig1 <= "1011111";
					when 7 =>
						s_dig1 <= "1110000"; 
					when 8 =>
						s_dig1 <= "1111111";
					when 9 =>
						s_dig1 <= "1111011";
					when 10 =>
						s_dig1 <= "1110111"; 
					when 11 =>
						s_dig1 <= "0011111";
					when 12 =>
						s_dig1 <= "1001110"; 
					when 13 =>
						s_dig1 <= "0111101"; 
					when 14 =>
						s_dig1 <= "1001111";   
					when 15 =>
						s_dig1 <= "1000111"; 
					when others =>
						null;
				end case;
				case (bcd_dig2) is
					when 0 =>
						s_dig2 <= "1111110";
					when 1 =>
						s_dig2 <= "0110000";
					when 2 =>
						s_dig2 <= "1101101";
					when 3 =>
						s_dig2 <= "1111001"; 
					when 4 =>
						s_dig2 <= "0110011";
					when 5 =>
						s_dig2 <= "1011011";
					when 6 =>
						s_dig2 <= "1011111";
					when 7 =>
						s_dig2 <= "1110000"; 
					when 8 =>
						s_dig2 <= "1111111";
					when 9 =>
						s_dig2 <= "1111011";
					when 10 =>
						s_dig2 <= "1110111"; 
					when 11 =>
						s_dig2 <= "0011111";
					when 12 =>
						s_dig2 <= "1001110"; 
					when 13 =>
						s_dig2 <= "0111101"; 
					when 14 =>
						s_dig2 <= "1001111";   
					when 15 =>
						s_dig2 <= "1000111"; 
					when others =>
						null;
				end case;
			when STATE_TYPE  => 
				s_dig3 <= "0011101"; -- 'o'
				case (bcd_type) is
					when 0 =>
						s_dig2 <= "1110111";
						s_dig1 <= "0111101";
						s_dig0 <= "0111101";
					when 1 =>
						s_dig2 <= "0111101";
						s_dig1 <= "0110000";
						s_dig0 <= "0011100";
					when 2 =>
						s_dig2 <= "0010101";
						s_dig1 <= "0011101";
						s_dig0 <= "0001111";
					when 3 =>
						s_dig2 <= "0110111";
						s_dig1 <= "0011101";
						s_dig0 <= "0000101";
					when others => 
						null;
					end case;
			when STATE_RESULT => 
				if (error_i = '0') and (owerflow_i = '0') and (sign_i = '0') then
					case (bcd_res0) is
					when 0 =>
						s_dig0 <= "1111110";
					when 1 =>
						s_dig0 <= "0110000";
					when 2 =>
						s_dig0 <= "1101101";
					when 3 =>
						s_dig0 <= "1111001"; 
					when 4 =>
						s_dig0 <= "0110011";
					when 5 =>
						s_dig0 <= "1011011";
					when 6 =>
						s_dig0 <= "1011111";
					when 7 =>
						s_dig0 <= "1110000"; 
					when 8 =>
						s_dig0 <= "1111111";
					when 9 =>
						s_dig0 <= "1111011";
					when 10 =>
						s_dig0 <= "1110111"; 
					when 11 =>
						s_dig0 <= "0011111";
					when 12 =>
						s_dig0 <= "1001110"; 
					when 13 =>
						s_dig0 <= "0111101"; 
					when 14 =>
						s_dig0 <= "1001111";   
					when 15 =>
						s_dig0 <= "1000111"; 
					when others =>
						null;
				end case;
				case (bcd_res1) is
					when 0 =>
						s_dig1 <= "1111110";
					when 1 =>
						s_dig1 <= "0110000";
					when 2 =>
						s_dig1 <= "1101101";
					when 3 =>
						s_dig1 <= "1111001"; 
					when 4 =>
						s_dig1 <= "0110011";
					when 5 =>
						s_dig1 <= "1011011";
					when 6 =>
						s_dig1 <= "1011111";
					when 7 =>
						s_dig1 <= "1110000"; 
					when 8 =>
						s_dig1 <= "1111111";
					when 9 =>
						s_dig1 <= "1111011";
					when 10 =>
						s_dig1 <= "1110111"; 
					when 11 =>
						s_dig1 <= "0011111";
					when 12 =>
						s_dig1 <= "1001110"; 
					when 13 =>
						s_dig1 <= "0111101"; 
					when 14 =>
						s_dig1 <= "1001111";   
					when 15 =>
						s_dig1 <= "1000111"; 
					when others =>
						null;
				end case;
				case (bcd_res2) is
					when 0 =>
						s_dig2 <= "1111110";
					when 1 =>
						s_dig2 <= "0110000";
					when 2 =>
						s_dig2 <= "1101101";
					when 3 =>
						s_dig2 <= "1111001"; 
					when 4 =>
						s_dig2 <= "0110011";
					when 5 =>
						s_dig2 <= "1011011";
					when 6 =>
						s_dig2 <= "1011111";
					when 7 =>
						s_dig2 <= "1110000"; 
					when 8 =>
						s_dig2 <= "1111111";
					when 9 =>
						s_dig2 <= "1111011";
					when 10 =>
						s_dig2 <= "1110111"; 
					when 11 =>
						s_dig2 <= "0011111";
					when 12 =>
						s_dig2 <= "1001110"; 
					when 13 =>
						s_dig2 <= "0111101"; 
					when 14 =>
						s_dig2 <= "1001111";   
					when 15 =>
						s_dig2 <= "1000111"; 
					when others =>
						null;
				end case;
				case (bcd_res3) is
					when 0 =>
						s_dig3 <= "1111110";
					when 1 =>
						s_dig3 <= "0110000";
					when 2 =>
						s_dig3 <= "1101101";
					when 3 =>
						s_dig3 <= "1111001"; 
					when 4 =>
						s_dig3 <= "0110011";
					when 5 =>
						s_dig3 <= "1011011";
					when 6 =>
						s_dig3 <= "1011111";
					when 7 =>
						s_dig3 <= "1110000"; 
					when 8 =>
						s_dig3 <= "1111111";
					when 9 =>
						s_dig3 <= "1111011";
					when 10 =>
						s_dig3 <= "1110111"; 
					when 11 =>
						s_dig3 <= "0011111";
					when 12 =>
						s_dig3 <= "1001110"; 
					when 13 =>
						s_dig3 <= "0111101"; 
					when 14 =>
						s_dig3 <= "1001111";   
					when 15 =>
						s_dig3 <= "1000111"; 
					when others =>
						null;
				end case;
				elsif (error_i = '0') and (owerflow_i = '0') and (sign_i = '1') then
					s_dig3 <= "0000001"; -- '-'
					case (bcd_res0) is
					when 0 =>
						s_dig0 <= "1111110";
					when 1 =>
						s_dig0 <= "0110000";
					when 2 =>
						s_dig0 <= "1101101";
					when 3 =>
						s_dig0 <= "1111001"; 
					when 4 =>
						s_dig0 <= "0110011";
					when 5 =>
						s_dig0 <= "1011011";
					when 6 =>
						s_dig0 <= "1011111";
					when 7 =>
						s_dig0 <= "1110000"; 
					when 8 =>
						s_dig0 <= "1111111";
					when 9 =>
						s_dig0 <= "1111011";
					when 10 =>
						s_dig0 <= "1110111"; 
					when 11 =>
						s_dig0 <= "0011111";
					when 12 =>
						s_dig0 <= "1001110"; 
					when 13 =>
						s_dig0 <= "0111101"; 
					when 14 =>
						s_dig0 <= "1001111";   
					when 15 =>
						s_dig0 <= "1000111"; 
					when others =>
						null;
				end case;
				case (bcd_res1) is
					when 0 =>
						s_dig1 <= "1111110";
					when 1 =>
						s_dig1 <= "0110000";
					when 2 =>
						s_dig1 <= "1101101";
					when 3 =>
						s_dig1 <= "1111001"; 
					when 4 =>
						s_dig1 <= "0110011";
					when 5 =>
						s_dig1 <= "1011011";
					when 6 =>
						s_dig1 <= "1011111";
					when 7 =>
						s_dig1 <= "1110000"; 
					when 8 =>
						s_dig1 <= "1111111";
					when 9 =>
						s_dig1 <= "1111011";
					when 10 =>
						s_dig1 <= "1110111"; 
					when 11 =>
						s_dig1 <= "0011111";
					when 12 =>
						s_dig1 <= "1001110"; 
					when 13 =>
						s_dig1 <= "0111101"; 
					when 14 =>
						s_dig1 <= "1001111";   
					when 15 =>
						s_dig1 <= "1000111"; 
					when others =>
						null;
				end case;
				case (bcd_res2) is
					when 0 =>
						s_dig2 <= "1111110";
					when 1 =>
						s_dig2 <= "0110000";
					when 2 =>
						s_dig2 <= "1101101";
					when 3 =>
						s_dig2 <= "1111001"; 
					when 4 =>
						s_dig2 <= "0110011";
					when 5 =>
						s_dig2 <= "1011011";
					when 6 =>
						s_dig2 <= "1011111";
					when 7 =>
						s_dig2 <= "1110000"; 
					when 8 =>
						s_dig2 <= "1111111";
					when 9 =>
						s_dig2 <= "1111011";
					when 10 =>
						s_dig2 <= "1110111"; 
					when 11 =>
						s_dig2 <= "0011111";
					when 12 =>
						s_dig2 <= "1001110"; 
					when 13 =>
						s_dig2 <= "0111101"; 
					when 14 =>
						s_dig2 <= "1001111";   
					when 15 =>
						s_dig2 <= "1000111"; 
					when others =>
						null;
				end case;
				elsif (error_i = '0') and (owerflow_i = '1')  then
					s_dig0 <= "0011101";
					s_dig1 <= "0011101";
					s_dig2 <= "0011101";
					s_dig3 <= "0011101";
				elsif (error_i = '1') then
					s_dig0 <= "0000101";
					s_dig1 <= "0000101";
					s_dig2 <= "1001111";
					s_dig3 <= "0000000";
				end if;
			when others =>
				null;
		end case;
	end process p_decode_bcd;
	
end architecture rtl;