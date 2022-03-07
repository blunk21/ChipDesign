library IEEE;
use IEEE.std_logic_1164.all;

entity decoder is
	port(
		sel_i:	in std_logic_vector(3 downto 0);
		data0_i: in std_logic_vector(7 downto 0);
		data1_i: in std_logic_vector(7 downto 0);
		out_o:	out std_logic_vector(7 downto 0));
end decoder;
