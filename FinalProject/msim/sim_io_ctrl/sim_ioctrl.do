vsim -t ns -novopt -lib work work.io_ctrl_tb
view *
do ioctrl_wave.do
run 10 ms
