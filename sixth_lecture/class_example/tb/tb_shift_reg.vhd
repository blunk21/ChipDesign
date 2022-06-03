library ieee;
use ieee.std_logic_1164.all;

entity tb_shift_reg is
end entity tb_shift_reg;

architecture sim of tb_shift_reg is


	component shift_reg is
		port (
			d_i:	in 	std_logic_vector(3 downto 0);
			en_i:	in 	std_logic;
			sh_i:	in 	std_logic;
			clk:	in 	std_logic;
			rst:	in 	std_logic;
			q_o:	out std_logic_vector(3 downto 0)
		);
	end component shift_reg;

signal		d_i:	 	std_logic_vector(3 downto 0);
signal		en_i:	 	std_logic;
signal		sh_i:	 	std_logic;
signal		clk:	 	std_logic;
signal		rst:		std_logic;
signal		q_o:	 	std_logic_vector(3 downto 0);

begin

	inst_shift_reg : shift_reg
	port map (
		d_i		=> d_i,
		en_i	=> en_i,
		sh_i	=> sh_i,
		clk		=> clk,
		rst		=> rst,
		q_o		=> q_o
	);

	-- clock
	proc_clock : process
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process ; -- proc_clock
	
	-- reset
	proc_reset : process
	begin
		rst <= '1';
		wait for 100 ns;
		rst <= '0';
		wait;
		
	end process ; -- proc_reset

	proc_sim : process
	begin
		d_i <= "0000";
		en_i <= '0';
		sh_i <= '0';
		wait for 200 ns; --wait until rst is finished
		d_i <= "1111";
		en_i <= '1';
		wait for 200 ns;
		en_i <= '0';
		sh_i <= '1';
		wait for 200 ns;
		en_i <= '1';
		sh_i <='1';
		wait for 400 ns;
		
	end process ; -- proc_sim

end architecture sim;