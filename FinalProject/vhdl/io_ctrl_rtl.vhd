--------------------------------------------------------------------------------
-- Title       : Architecture of IO control
-- Project     : Calculator
--------------------------------------------------------------------------------
-- File        : io_ctrl_rtl.vhd
-- Author      : Gergely Bereczki <sa21x001@technikum-wien.at>
-- Company     : FH Technikum Wien
-- Created     : Mon Apr  4 10:52:33 2022
-- Last update : Mon Apr 25 10:58:25 2022
-- Platform    : Digilent Basys3 FPGA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Description: IO control unit manages the pusbuttons and switches of the platform this project
-- is being developed for.
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------			
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

architecture rtl of io_ctrl is
	constant C_EN_COUNTVAL : std_logic_vector(19 downto 0) := x"186A0";



	signal s_setfreq_cntr   : std_logic_vector(19 downto 0) := (others => '0');
	signal s_enable_refresh : std_logic                     := '0';
	signal s_switch_sync    : std_logic_vector(15 downto 0) := (others => '0');
	signal s_btn_sync       : std_logic_vector(3 downto 0)  := (others => '0');
	signal s_ss_sel         : std_logic_vector(3 downto 0)  := (others => '0');
	signal s_ss             : std_logic_vector(7 downto 0)  := (others => '0');
	signal btn_tmp          : std_logic_vector(3 downto 0)  := (others => '0');
	signal sw_tmp           : std_logic_vector(15 downto 0) := (others => '0');



begin

	p_refresh_display : process (reset_i, clk)
		----------------------------------------------------------------------------
		-- 1 kHz clock
		----------------------------------------------------------------------------

	begin
		if (reset_i = '1') then
			s_setfreq_cntr <= x"00000";
			--s_enable_refresh <= '0';

		elsif (rising_edge(clk)) then
			if (s_setfreq_cntr >= C_EN_COUNTVAL) then
				s_setfreq_cntr <= x"00000";
			else
				s_setfreq_cntr <= s_setfreq_cntr + x"00001";
			end if;
		end if;
	end process p_refresh_display;

	s_enable_refresh <= '1' when  s_setfreq_cntr = C_EN_COUNTVAL else '0';

	----------------------------------------------------------------------------


	----------------------------------------------------------------------------
	-- Debounce
	----------------------------------------------------------------------------

	p_debounce : process (reset_i, clk)

	begin
		if (reset_i = '1') then
			s_switch_sync <= x"0000";
			s_btn_sync    <= x"0";
			btn_tmp       <= x"0";
			sw_tmp        <= x"0000";
			

		elsif (rising_edge(clk)) then
			if (s_enable_refresh='1') then
				--------------------------------------------------------------------------------
				if(btn_tmp = pb_i) then --pushbutton debounce
					s_btn_sync <= pb_i;
				else
					s_btn_sync <= x"0";
					btn_tmp <= pb_i;
				end if;
				--------------------------------------------------------------------------------
				if (sw_tmp = sw_i) then --switch debounce
					s_switch_sync <= sw_i;
				else
					s_switch_sync <= x"0000";
					sw_tmp  <= sw_i;
				end if;
			else
				null;
			end if;
		--------------------------------------------------------------------------------		
		else
			null;
		end if;

	end process p_debounce;


	swsync_o <= s_switch_sync;
	pbsync_o <= s_btn_sync;

	----------------------------------------------------------------------------
	-- Control display
	----------------------------------------------------------------------------


	p_control_display : process (reset_i, clk)
	variable digit_counter: std_logic_vector(1 downto 0);
	begin
		if (reset_i = '1') then
			s_ss_sel <= "1111";
			s_ss     <= x"00";
			digit_counter:="00";
		elsif (rising_edge(clk)) then
			if (s_enable_refresh='1') then
				case (digit_counter) is
					when "00" =>
						s_ss_sel <= "1110";
						s_ss     <= dig0_i;
					when "01" =>
						s_ss_sel <= "1101";
						s_ss     <= dig1_i;
					when "10" =>
						s_ss_sel <= "1011";
						s_ss     <= dig2_i;
					when "11" =>
						s_ss_sel <= "0111";
						s_ss     <= dig3_i;
					when others =>
						s_ss_sel <= "1111";
						s_ss <= x"00";

				end case;
				digit_counter := digit_counter + 1;
			else
				null;
			end if;
		end if;
	end process p_control_display;
	ss_o     <= s_ss;
	ss_sel_o <= s_ss_sel;

	--------------------------------------------------------------------------------
	-- LEDs
	--------------------------------------------------------------------------------

	led_o <= led_i;

end rtl;



