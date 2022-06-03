vsim -t ns -novopt -lib work work.top_tb
view *
do top_wave.do
run 20 ms
