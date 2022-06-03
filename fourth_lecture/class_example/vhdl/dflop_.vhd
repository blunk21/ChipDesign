library IEEE;
use IEEE.std_logic_1164.all;

entity dflop is
	port (
		d_inp : in  std_logic;
		rst   : in  std_logic;
		clk   : in  std_logic;
		q_out : out std_logic
	);
end entity dflop;




architecture rtl of dflop is

begin
	dflipflop : process (rst, clk)
	begin
		if (rst = '1') then
			q_out <= '0';

		elsif (clk'event and clk = '1') then
			q_out <= d_inp;
		end if;
	end process dflipflop;

end architecture rtl;


