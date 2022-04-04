onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_running_led/led_o
add wave -noupdate -format Logic /tb_running_led/en_i
add wave -noupdate -format Logic /tb_running_led/clk
add wave -noupdate -format Logic /tb_running_led/start_i
add wave -noupdate -format Logic /tb_running_led/reset
add wave -noupdate -format Logic /tb_running_led/fw_bwd_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
