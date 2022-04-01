onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_shift_reg/sh_i
add wave -noupdate -format Logic /tb_shift_reg/d_i
add wave -noupdate -format Logic /tb_shift_reg/clk
add wave -noupdate -format Logic /tb_shift_reg/en_i
add wave -noupdate -format Logic /tb_shift_reg/rst
add wave -noupdate -format Logic /tb_shift_reg/q_o

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
