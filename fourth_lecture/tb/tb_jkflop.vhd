library ieee;
use ieee.std_logic_1164.all;


entity tb_jkflop is
	
end entity tb_jkflop;

architecture sim of tb_jkflop is

component jkflop is
	port (
		clk: in std_logic;
		rst: in std_logic;
		j_in: in std_logic;
		k_in: in std_logic;
		q_out: out std_logic
	);
end component jkflop;


signal clk	:	std_logic;
signal rst	:	std_logic;
signal j_in :	std_logic;
signal k_in :   std_logic;
signal q_out :  std_logic;

begin

	inst_jkflop : jkflop
	port map (
		clk => clk,
		rst => rst,
		j_in => j_in,
		k_in => k_in,
		q_out => q_out
	);

	clock : process
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process ; -- clock

	reset_sig : process
	begin
		rst <= '1';
		wait for 50 ns;
		rst <= '0';
		wait;
	end process reset_sig;

p_stim : process
begin
	j_in<='1';
	k_in<='0';
	wait for 200 ns;
	j_in <='0';
	k_in<='0';
	wait for 200 ns;
	j_in <= '0';
	k_in<='1';
	wait for 200 ns;
	j_in <= '1';
	k_in<='1';
	wait for 200 ns;	
end process p_stim;


end architecture sim;

