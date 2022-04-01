library ieee;
use ieee.std_logic_1164.all;

entity tb_running_led is
end entity tb_running_led;


architecture sim of tb_running_led is

component running_led
	port (

		led_o : out std_logic_vector(7 downto 0);
		en_i : in std_logic;
		clk : in std_logic;
		start_i : in std_logic;
		reset : in std_logic;
		fw_bwd_i : in std_logic
		
	);
end component;

signal 	led_o : std_logic_vector(7 downto 0);
signal 	en_i :  std_logic;
signal 	clk :  std_logic;
signal 	start_i :  std_logic;
signal 	reset :  std_logic;
signal 	fw_bwd_i :  std_logic;

begin

	instance_running_led : running_led
	port map (
		led_o => 		led_o,
		en_i => 		en_i,
		clk => 			clk,
		start_i => 		start_i,
		reset => 		reset,
		fw_bwd_i => 	fw_bwd_i
	);

	process_clock : process
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process process_clock;
	
end architecture sim;