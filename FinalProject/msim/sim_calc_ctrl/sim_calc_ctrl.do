vsim -t ns -novopt -lib work work.calc_ctrl_tb
view *
do calc_ctrl_wave.do
run 2000 ns
