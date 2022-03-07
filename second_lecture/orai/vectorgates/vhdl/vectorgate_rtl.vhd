architecture rtl of vectorgate is
	signal u_word: std_logic_vector(31 downto 16);
	signal l_word: std_logic_vector(15 downto 0);
begin
	u_word <= a_i(31 downto 16) and b_i(31 downto 16);
	l_word <= a_i(15 downto 0) or b_i(15 downto 0);
	e_o    <= c_i xor d_i;	
	d_o <= u_word & l_word;

end rtl;
