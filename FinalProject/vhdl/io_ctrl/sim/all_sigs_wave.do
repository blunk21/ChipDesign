onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /io_ctrl_tb/clk
add wave -noupdate /io_ctrl_tb/reset_i
add wave -noupdate -expand -group Display /io_ctrl_tb/dig0_i
add wave -noupdate -expand -group Display /io_ctrl_tb/dig1_i
add wave -noupdate -expand -group Display /io_ctrl_tb/dig2_i
add wave -noupdate -expand -group Display /io_ctrl_tb/dig3_i
add wave -noupdate -expand -group Display /io_ctrl_tb/ss_o
add wave -noupdate -expand -group Display /io_ctrl_tb/ss_sel_o
add wave -noupdate -expand -group Display /io_ctrl_tb/DUT/s_ss_sel
add wave -noupdate -expand -group Display /io_ctrl_tb/DUT/s_ss
add wave -noupdate -group LEDs /io_ctrl_tb/led_i
add wave -noupdate -group LEDs /io_ctrl_tb/led_o
add wave -noupdate -group Debouncing /io_ctrl_tb/sw_i
add wave -noupdate -group Debouncing /io_ctrl_tb/pb_i
add wave -noupdate -group Debouncing -radix hexadecimal /io_ctrl_tb/DUT/s_switch_sync
add wave -noupdate -group Debouncing -radix hexadecimal /io_ctrl_tb/DUT/s_btn_sync
add wave -noupdate -group Debouncing /io_ctrl_tb/swsync_o
add wave -noupdate -group Debouncing /io_ctrl_tb/pbsync_o
add wave -noupdate -group Debouncing -radix hexadecimal /io_ctrl_tb/DUT/btn_tmp
add wave -noupdate -group Debouncing -radix hexadecimal /io_ctrl_tb/DUT/sw_tmp
add wave -noupdate /io_ctrl_tb/DUT/s_setfreq_cntr
add wave -noupdate /io_ctrl_tb/DUT/s_enable_refresh
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
