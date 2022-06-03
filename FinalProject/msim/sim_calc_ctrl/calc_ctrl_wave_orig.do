onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate  /calc_ctrl_tb/clk_i
add wave -noupdate  /calc_ctrl_tb/reset_i
add wave -noupdate  /calc_ctrl_tb/swsync_i
add wave -noupdate  /calc_ctrl_tb/pbsync_i
add wave -noupdate  /calc_ctrl_tb/finished_i
add wave -noupdate  /calc_ctrl_tb/result_i
add wave -noupdate /calc_ctrl_tb/sign_i
add wave -noupdate /calc_ctrl_tb/overflow_i
add wave -noupdate  /calc_ctrl_tb/error_i
add wave -noupdate /calc_ctrl_tb/op1_o
add wave -noupdate /calc_ctrl_tb/op2_o
add wave -noupdate /calc_ctrl_tb/optype_o
add wave -noupdate /calc_ctrl_tb/start_o
add wave -noupdate /calc_ctrl_tb/dig0_o
add wave -noupdate /calc_ctrl_tb/dig1_o
add wave -noupdate /calc_ctrl_tb/dig2_o
add wave -noupdate /calc_ctrl_tb/dig3_o
add wave -noupdate /calc_ctrl_tb/led_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4281250 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 218
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {21 ms}
