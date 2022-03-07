library IEEE;
use IEEE.std_logic_1164.all;

architecture rtl of decoder is

	signal sens: std_logic_vector(3 downto 0);

begin
	sens <= sel_i;
	decode : process (sens)
	begin
		case sens is
			when "0000" => out_o <= data1_i;
			when "0001" => out_o <= data0_i(7) & data1_i(7) & "000000";
			when "1111" => out_o <= "1111" & data0_i(3 downto 0);
			when "0010" => out_o <= not data0_i;
			when "0100" => out_o <= data0_i;
			when others => out_o <= "ZZZZZZZZ";
		end case;
	end process decode;
end rtl;	
