vsim -t ns -novopt -lib work work.tb_fulladder_sim_cfg  
view *
do fulladder_wave.do
run 3000 ns
