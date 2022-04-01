library ieee;
use ieee.std_logic_1164.all;

entity shift_reg is
	port (
		d_i:	in 	std_logic_vector(3 downto 0);
		en_i:	in 	std_logic;
		sh_i:	in 	std_logic;
		clk:	in 	std_logic;
		rst:	in 	std_logic;
		q_o:	out 	std_logic_vector(3 downto 0)
	);
end entity shift_reg;

architecture rtl of shift_reg is
	
	signal shift_op : std_logic_vector(3 downto 0) ;

begin
	q_o <= shift_op;
	
	proc_shift_reg : process( clk,rst )
	begin
		if rst = '1' then
		shift_op <= "0000";
		elsif clk'event and clk = '1' then
		 	if en_i = '1' then
		 		if sh_i = '1' then
		 			shift_op(3 downto 1) <= shift_op(2 downto 0);
		 			shift_op(0) <= '0';
	 			else
	 				shift_op <= d_i;
				end if;
			end if;
		end if;
	end process ; -- proc_shift_reg
	
end architecture rtl;