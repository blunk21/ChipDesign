onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /alu_tb/clk_i
add wave -noupdate /alu_tb/reset_i
add wave -noupdate /alu_tb/op1_i
add wave -noupdate /alu_tb/op2_i
add wave -noupdate /alu_tb/optype_i
add wave -noupdate /alu_tb/start_i
add wave -noupdate /alu_tb/finished_o
add wave -noupdate /alu_tb/result_o
add wave -noupdate /alu_tb/sign_o
add wave -noupdate /alu_tb/overflow_o
add wave -noupdate /alu_tb/error_o
add wave -noupdate -group Add /alu_tb/DUT/s_add_finished
add wave -noupdate -group Add /alu_tb/DUT/s_add_result
add wave -noupdate -group Add /alu_tb/DUT/s_add_error
add wave -noupdate -group Add /alu_tb/DUT/s_add_overflow
add wave -noupdate -group Add /alu_tb/DUT/s_add_sign
add wave -noupdate -group Div /alu_tb/DUT/s_div_finished
add wave -noupdate -group Div /alu_tb/DUT/s_div_result
add wave -noupdate -group Div /alu_tb/DUT/s_div_error
add wave -noupdate -group Div /alu_tb/DUT/s_div_overflow
add wave -noupdate -group Div /alu_tb/DUT/s_div_sign
add wave -noupdate -group Not /alu_tb/DUT/s_not_finished
add wave -noupdate -group Not /alu_tb/DUT/s_not_result
add wave -noupdate -group Not /alu_tb/DUT/s_not_error
add wave -noupdate -group Not /alu_tb/DUT/s_not_overflow
add wave -noupdate -group Not /alu_tb/DUT/s_not_sign
add wave -noupdate -group EOR /alu_tb/DUT/s_eor_finished
add wave -noupdate -group EOR /alu_tb/DUT/s_eor_result
add wave -noupdate -group EOR /alu_tb/DUT/s_eor_error
add wave -noupdate -group EOR /alu_tb/DUT/s_eor_overflow
add wave -noupdate -group EOR /alu_tb/DUT/s_eor_sign
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {622 ns} 0}
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
WaveRestoreZoom {0 ns} {607 ns}
