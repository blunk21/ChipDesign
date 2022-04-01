vsim -t ns -novopt -lib work work.tb_adder
view *
do adder_wave.do
run 100000 ns
