onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/reset_i
add wave -noupdate /top_tb/ss_o
add wave -noupdate /top_tb/ss_sel_o
add wave -noupdate /top_tb/pb_i
add wave -noupdate /top_tb/sw_i
add wave -noupdate /top_tb/led_o
add wave -noupdate /top_tb/DUT/start
add wave -noupdate /top_tb/DUT/finished
add wave -noupdate /top_tb/DUT/signn
add wave -noupdate /top_tb/DUT/overflow
add wave -noupdate /top_tb/DUT/err
add wave -noupdate /top_tb/DUT/result
add wave -noupdate /top_tb/DUT/op1
add wave -noupdate /top_tb/DUT/op2
add wave -noupdate /top_tb/DUT/optype
add wave -noupdate /top_tb/DUT/pbsync
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3738806 ns} 0}
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
