library ieee;
use ieee.std_logic_1164.all;


entity tb_dflop is
	
end entity tb_dflop;

architecture sim of tb_dflop is

component dflop is
	port (
		clk: in std_logic;
		rst: in std_logic;
		d_inp: in std_logic;
		q_out: out std_logic
	);
end component dflop;


signal clk	:	std_logic;
signal rst	:	std_logic;
signal d_inp :	std_logic;
signal q_out : std_logic;

begin

	inst_dflop : dflop
	port map (
		clk => clk,
		rst => rst,
		d_inp => d_inp,
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
		wait for 130 ns;
		rst <= '0';
		wait;
	end process reset_sig;

p_stim : process
begin
	d_inp<='0';
	wait for 300 ns;
	d_inp<='1';
	wait for 420 ns;
	d_inp<='0';
	wait for 420 ns;
	d_inp<='1';
	wait for 420 ns;	
end process p_stim;


end architecture sim;

