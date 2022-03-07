library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity tb_decoder is end tb_decoder;

architecture sim of tb_decoder is

	component decoder
		port(
			sel_i:		in std_logic_vector(3 downto 0);
			data0_i:	in std_logic_vector(7 downto 0);
			data1_i:	in std_logic_vector(7 downto 0);
			out_o:		out std_logic_vector(7 downto 0));
	end component;
	
	signal sel_i:	std_logic_vector(3 downto 0);
	signal data0_i:	std_logic_vector(7 downto 0);
	signal data1_i:	std_logic_vector(7 downto 0);
	signal out_o:	std_logic_vector(7 downto 0);

begin
	decoder1 : decoder
	port map(
			sel_i => sel_i,
			data0_i => data0_i,
			data1_i => data1_i,
			out_o => out_o);
	run : process
	begin
		data0_i <= to_stdlogicvector(X"F0");
	       	data1_i <= to_stdlogicvector(X"0F");	
		sel_i <= "0000";
		wait for 100 ns;
	        sel_i <= "0001";	
	        wait for 100 ns;
	        sel_i <= "1111"; 	
		wait for 100 ns;
	        sel_i <= "0010";	
		wait for 100 ns;
		sel_i <= "0100";
		wait for 100 ns;
		sel_i <= "1100";
		wait for 100 ns;
		sel_i <= "0110";
		wait for 100 ns;
	end process run;
end sim;
