onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -format Logic /io_ctrl_tb/clk
add wave -noupdate -format Logic /io_ctrl_tb/reset_i
add wave -noupdate -format Logic /io_ctrl_tb/dig0_i
add wave -noupdate -format Logic /io_ctrl_tb/dig1_i
add wave -noupdate -format Logic /io_ctrl_tb/dig2_i
add wave -noupdate -format Logic /io_ctrl_tb/dig3_i
add wave -noupdate -format Logic /io_ctrl_tb/led_i
add wave -noupdate -format Logic /io_ctrl_tb/led_o
add wave -noupdate -format Logic /io_ctrl_tb/sw_i
add wave -noupdate -format Logic /io_ctrl_tb/pb_i
add wave -noupdate -format Logic /io_ctrl_tb/ss_o 
add wave -noupdate -format Logic /io_ctrl_tb/ss_sel_o
add wave -noupdate -format Logic /io_ctrl_tb/swsync_o
add wave -noupdate -format Logic /io_ctrl_tb/pbsync_o



TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left


