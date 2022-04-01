library ieee;
use ieee.std_logic_1164.all;

entity running_led is
	port (
		led_o : out std_logic_vector(7 downto 0);
		en_i : in std_logic;
		clk : in std_logic;
		start_i : in std_logic;
		reset : in std_logic;
		fw_bwd_i : in std_logic
	);
end running_led;

architecture rtl of running_led is

	type state is (STATE_IDLE,STATE_FLASH,STATE_SHL,STATE_SHR);
	signal current_state : state;
	signal tmp_q : std_logic_vector(7 downto 0);

begin
	process_running_led : process( clk,reset )
	begin
		if reset = '1' then
			tmp_q <= x"00";
			current_state <= STATE_IDLE;
		elsif 	clk'event and clk = '1' then
			case current_state is

				when STATE_IDLE =>
					tmp_q <= x"00";
					if start_i = '1' then
						if en_i= '1' then
							if fw_bwd_i = '1' then
								tmp_q <= x"01";
								current_state <= STATE_SHL;
							else
								tmp_q <= x"80";
								current_state <= STATE_SHR;
							end if;
						else
							if fw_bwd_i = '1' then
								tmp_q <= x"FF";
								current_state <= STATE_FLASH;
							else
								current_state <= STATE_IDLE;
							end if;
						end if;
					else
						current_state <= STATE_IDLE;
					end if;
				when STATE_SHL =>
					if tmp_q = x"00" then
						current_state <= STATE_IDLE;
					else
						current_state <= STATE_SHL;
					end if;
					tmp_q(7 downto 1) <= tmp_q(6 downto 0);
					tmp_q(0) <= '0';
				when STATE_SHR =>
					if tmp_q = x"00" then
						current_state <= STATE_IDLE;
					else
						current_state <= STATE_SHR;
					end if;
					tmp_q(6 downto 0) <= tmp_q(7 downto 1);
					tmp_q(7) <= '0';
				when STATE_FLASH =>
					current_state <= STATE_IDLE;
					tmp_q <= x"00";
				when others =>
					current_state <= STATE_IDLE;
				end case;
			end if;		
	end process ; -- process_running_led
	led_o <= tmp_q;
end architecture rtl;