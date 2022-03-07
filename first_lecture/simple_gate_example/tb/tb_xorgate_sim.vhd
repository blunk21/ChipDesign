library IEEE;
use IEEE.std_logic_1164.all;

architecture sim of tb_xorgate is
	component xorgate
	port (	a_i : in std_logic;
		b_i : in std_logic;
		xor_o : out std_logic);
end component;


signal a_i : std_logic;
signal b_i : std_logic;
signal xor_o : std_logic;

begin

	i_xorgate : xorgate
	port map
	  	(a_i => a_i,
  	   	b_i => b_i,
	      	xor_o => xor_o);

	p_test : process
	begin
	a_i <= '0';
	b_i <= '0';
	wait for 200 ns;

	a_i <= '1';
	b_i <= '0';
	wait for 200 ns;

	a_i <= '1';
	b_i <= '1';
	wait for 200 ns;
	
	a_i <= '0';
	b_i <= '1';
	wait for 200 ns;
	
	end process;
end sim;	
