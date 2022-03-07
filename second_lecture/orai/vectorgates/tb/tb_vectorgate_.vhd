library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_vectorgate is end tb_vectorgate;

architecture sim of tb_vectorgate is


	component vectorgate
		port(
			a_i : in std_logic_vector(31 downto 0);
			b_i : in std_logic_vector(31 downto 0);
			c_i : in std_logic;
			d_i : in std_logic;
			e_o : out std_logic;
			d_o : out std_logic_vector(31 downto 0));
	end component; 

	signal 	a_i :  std_logic_vector(31 downto 0);
	signal 	b_i :  std_logic_vector(31 downto 0);
	signal  c_i :  std_logic;
	signal  d_i:   std_logic;
	signal 	e_o:   std_logic;
	signal 	d_o :  std_logic_vector(31 downto 0);

begin
	i_vgate : vectorgate
	port map(
		a_i => a_i,
		b_i => b_i,
		c_i => c_i,
		d_i => d_i,
		e_o => e_o,
		d_o => d_o);

	run : process
	 begin
		a_i <= "00000000000000000000000000000000";
		b_i <= to_stdlogicvector(B"0000_0000_0000_0000_0000_0000_0000_0000");
		c_i <= '0';
		d_i <= '0';
		wait for 100 ns;
		a_i <= to_stdlogicvector(X"00_00_00_01");
 		b_i <= (others =>'0');
		c_i <= '1';
		d_i <= '0';
		wait for 100 ns;
		a_i <= (others =>'0');
		b_i <= to_stdlogicvector(X"00_00_00_FF");
		c_i <= '0';
		d_i <= '1';
		wait for 100 ns;
 		a_i <= to_stdlogicvector(X"FF_FF_FF_FF");
		b_i <= to_stdlogicvector(X"00_FF_00_FF");
		c_i <= '1';
		d_i <= '1';
		wait for 100 ns;
	end process run;
end sim;
