vsim -t ns -novopt -lib work work.tb_xorgate_sim_cfg  
do fulladder_wave.do
view *
run 3000 ns
