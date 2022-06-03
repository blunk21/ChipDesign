--------------------------------------------------------------------------------
-- Title       : ALU RTL
-- Project     : Calculator
--------------------------------------------------------------------------------
-- File        : alu_rtl.vhd
-- Author      : Gergely Bereczki <sa21x001@technikum-wien.at>
-- Company     : FH Tecnikum Wien
-- Created     : Sun May 15 10:18:58 2022
-- Last update : Mon May 30 14:35:41 2022
-- Platform    : Digilent Basys3 FPGA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: This vhdl file describes the behaviour of the ALU 
-- part of the calculator.
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 									Questions 
-- 
------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;


architecture rtl of alu is

	

	signal s_op1 : std_logic_vector(15 downto 0) := (others  => '0');
	signal s_op2 : std_logic_vector(15 downto 0) := (others  => '0');

	----------------------------------------------------------------------------
	signal s_add_finished : std_logic;
	signal s_add_result : std_logic_vector(15 downto 0);
	signal s_add_error : std_logic;
	signal s_add_overflow : std_logic;
	signal s_add_sign : std_logic;
	signal s_add_enable: std_logic;
	----------------------------------------------------------------------------
	signal s_div_finished : std_logic;
	signal s_div_result : std_logic_vector(15 downto 0);
	signal s_div_error : std_logic;
	signal s_div_overflow : std_logic;
	signal s_div_sign : std_logic;
	signal s_div_op1 : std_logic_vector(15 downto 0);
	----------------------------------------------------------------------------
	signal s_not_finished : std_logic;
	signal s_not_result : std_logic_vector(15 downto 0);
	signal s_not_error : std_logic;
	signal s_not_overflow : std_logic;
	signal s_not_sign : std_logic;
	----------------------------------------------------------------------------
	signal s_eor_finished : std_logic;
	signal s_eor_result : std_logic_vector(15 downto 0);
	signal s_eor_error : std_logic;
	signal s_eor_overflow : std_logic;
	signal s_eor_sign : std_logic;

	--signal enable_op : std_logic;
	


begin
	s_op1(11 downto 0) <= op1_i;
	s_op2(11 downto 0) <= op2_i;


	p_add : process (reset_i, clk_i)
	begin

		if (reset_i = '1') then
		  	s_add_result <= x"0000";
		  	s_add_sign <= '0';
		  	s_add_error <= '0';
		  	s_add_finished <= '0';
		  	s_add_overflow <= '0';
	  	elsif (rising_edge(clk_i)) then
	  		if(start_i = '1') then
	  			if(s_add_finished = '0') then
		  			s_add_result <= s_op1 + s_op2;
			  		s_add_overflow <= '0';
			  		s_add_sign <= '0';
			  		s_add_error <= '0';
			  		s_add_finished <= '1';
		  		else
		  			null;
		  		end if;
	  		else
	  			s_add_sign <= '0';
		  		s_add_error <= '0';
		  		s_add_finished <= '0';
		  		s_add_overflow <= '0';
	  		end if;
  		else
  			null;	
		end if;
	end process p_add;

	p_not : process (reset_i, clk_i)
	begin
	  	if (reset_i = '1') then
		    s_not_result <= x"0000";
		  	s_not_sign <= '0';
		  	s_not_error <= '0';
		  	s_not_finished <= '0';
		  	s_not_overflow <= '0';
		elsif (rising_edge(clk_i)) then
			if(start_i = '1') then
				if(s_not_finished = '0') then
					s_not_result <= not(s_op1);
					s_not_sign <= '0';
			  		s_not_error <= '0';
			  		s_not_overflow <= '0';
			  		s_not_finished <= '1';
		  		else
		  			null;
		  		end if;
	  		else
	  			s_not_sign <= '0';
		  		s_not_error <= '0';
		  		s_not_finished <= '0';
		  		s_not_overflow <= '0';
			end if;
	  end if;
	end process p_not;

	p_eor : process (reset_i, clk_i)
	begin
	  if (reset_i = '1') then
	    	s_eor_result <= x"0000";
		  	s_eor_sign <= '0';
		  	s_eor_error <= '0';
		  	s_eor_finished <= '0';
		  	s_eor_overflow <= '0';
	  elsif (rising_edge(clk_i)) then
	  	if(start_i = '1') then 
	  		if(s_eor_finished = '0') then
		  		s_eor_result <= s_op1 xor s_op2;
		  		s_eor_sign <= '0';
			  	s_eor_error <= '0';
			  	s_eor_finished <= '1';
			  	s_eor_overflow <= '0';
		  	else
		  		null;
		  	end if;
  		else
  			s_eor_sign <= '0';
	  		s_eor_error <= '0';
	  		s_eor_finished <= '0';
	  		s_eor_overflow <= '0';
		end if;
		else
		null;

	  end if;
	end process p_eor;

	p_div : process (reset_i, clk_i)
	variable tmp : std_logic_vector(31 downto 0);
	begin
	  if (reset_i = '1') then
	  		s_div_result <= (others => '0');
		  	s_div_sign <= '0';
		  	s_div_error <= '0';
		  	s_div_finished <= '0';
		  	s_div_overflow <= '0';
	  elsif (rising_edge(clk_i)) then
			if(start_i = '1') then
				if(s_div_finished = '0') then
					tmp := std_logic_vector(unsigned(s_div_result)*unsigned(s_op2));
					s_div_op1 <= s_div_op1 - tmp(15 downto 0);
					if(s_div_op1>=s_op2) then
						s_div_result <= s_div_result + 1;
					else
						s_div_finished <= '1';
					end if;
				else
					null;
				end if;
			else
	  			s_div_sign <= '0';
		  		s_div_error <= '0';
		  		s_div_finished <= '0';
		  		s_div_overflow <= '0';
			end if;
	  end if;
	end process p_div;

	p_mux_results : process (clk_i,reset_i)
	begin
		if(reset_i='1') then
			result_o <= (others => '0');
			finished_o <= '0';
			sign_o <= '0';
			overflow_o <= '0';
			error_o <= '0';
		elsif(rising_edge(clk_i)) then
			if(s_add_finished = '1' and s_not_finished = '1' and s_div_finished = '1' and s_eor_finished = '1' and start_i = '1') then
			case(optype_i) is
			when "0000"  => --add 
				result_o <= s_add_result;
				sign_o <= s_add_sign;
				overflow_o <= s_add_overflow;
				error_o <= s_add_error;
				
			when "0001" => --negate 
				result_o <= s_not_result;
				sign_o <= s_not_sign;
				overflow_o <= s_not_overflow;
				error_o <= s_not_error;
				
			when "0010" => --divide 
				result_o <= s_div_result;
				sign_o <= s_div_sign;
				overflow_o <= s_div_overflow;
				error_o <= s_div_error;
				
			when "0011" => 
				result_o <= s_eor_result;
				sign_o <= s_eor_sign;
				overflow_o <= s_eor_overflow;
				error_o <= s_eor_error;
			when others => 
				null;
			end case;
			finished_o <= '1';
			--s_add_finished <= '0';
			--s_not_finished <= '0';
			--s_div_finished <= '0';
			--s_eor_finished <= '0';
		else
			finished_o <= '0';
			result_o <= (others => '0');
		end if;

	end if;
	end process p_mux_results;

end architecture;
