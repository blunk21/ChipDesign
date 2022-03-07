library IEEE;
use IEEE.std_logic_1164.all;

architecture rtl of xorgate is
begin
	xor_o <= a_i xor b_i;
end rtl;
