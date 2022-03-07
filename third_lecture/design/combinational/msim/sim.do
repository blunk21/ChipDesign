vsim -t ns -novopt -lib work work.tb_decoder
view *
do decoder_wave.do
run 3000 ns
