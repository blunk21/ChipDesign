library  ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tb_adder is
	
end entity tb_adder;


architecture sim of tb_adder is

component adder is
	port (
		data0_i	: 	in 	std_logic_vector(7 downto 0);
		data1_i	: 	in 	std_logic_vector(7 downto 0);
		sum_o	: 	out 	std_logic_vector(7 downto 0);
		carry_o	: 	out 	std_logic
	);
end component adder;


signal data0_i	: std_logic_vector(7 downto 0);
signal data1_i	: std_logic_vector(7 downto 0);
signal sum_o	: std_logic_vector(7 downto 0);
signal carry_o	: std_logic;

begin

	adder_i : adder
	port map (
		data0_i => data0_i,
		data1_i => data1_i,
		sum_o => sum_o,
		carry_o => carry_o
	);


	run : process
		variable var_result : std_logic_vector(8 downto 0);
	begin
		for i in 0 to 255 loop
			data0_i <= conv_std_logic_vector(i,8);
			for j in 0 to 255 loop
				data1_i <= conv_std_logic_vector(j,8);
				wait for 100 ns;
				var_result(8) := carry_o;
				var_result(7 downto 0) := sum_o;
				assert unsigned(var_result) = conv_unsigned(i+j, 9)
				report "ERROR in addition!!" severity error;
			end loop;	--j
		end loop;		-- i
		assert false report "END OF SIMULATION" severity error;
	end process run;
end architecture sim;