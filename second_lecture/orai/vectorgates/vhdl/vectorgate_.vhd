library IEEE;
use IEEE.std_logic_1164.all;

entity vectorgate is
	port ( a_i :	in std_logic_vector(31 downto 0);
		b_i:	in std_logic_vector(31 downto 0);
		c_i:	in std_logic;
		d_i:	in std_logic;
		e_o:	out std_logic;
		d_o:	out std_logic_vector(31 downto 0));
end vectorgate;

