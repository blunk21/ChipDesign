library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;



entity adder is
	port(
		data0_i	:	in 		std_logic_vector(7 downto 0);
		data1_i	:	in 		std_logic_vector(7 downto 0);
		carry_o	:	out		std_logic;
		sum_o	:	out		std_logic_vector(7 downto 0)
		);
end entity adder;

architecture rtl of adder is

begin
	addition : process (data0_i,data1_i)
		variable var1	: std_logic_vector(8 downto 0);
		variable tmp	: std_logic_vector(8 downto 0);
	begin
		var1(8) := '0';
		var1(7 downto 0) := data0_i;
		tmp := unsigned(var1) + unsigned(data1_i);
		sum_o <= tmp(7 downto 0);
		carry_o <= tmp(8);
	end process addition;
end architecture rtl;