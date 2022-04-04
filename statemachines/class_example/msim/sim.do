vsim -t ns -novopt -lib work work.tb_running_led
view *
do running_led_wave.do
run 20000 ns
