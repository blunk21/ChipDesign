vsim -t ns -lib work work.tb_vectorgate
view *
do vectorgate_wave.do
run 3000 ns
