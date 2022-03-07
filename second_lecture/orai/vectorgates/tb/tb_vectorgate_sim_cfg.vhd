library IEEE;
use IEEE.std_logic_1164.all;

configuration tb_vectorgate_sim_cfg of tb_vectorgate is
  for sim
    for i_vectorgate :vectorgate 
      use configuration work.vectorgate_struc_cfg;
    end for;
  end for;
end tb_vectorgate_sim_cfg;
