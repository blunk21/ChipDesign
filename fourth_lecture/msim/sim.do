vsim -t ns -novopt -lib work work.tb_jkflop
view *
do jkflop_wave.do
run 3000 ns
