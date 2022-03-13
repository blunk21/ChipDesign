vsim -t ns -novopt -lib work work.tb_dflop
view *
do dflop_wave.do
run 3000 ns
