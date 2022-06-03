vsim -t ns -novopt -lib work work.alu_tb
view *
do alu_wave.do
run 2000 ns
