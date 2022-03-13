onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_jkflop/j_in
add wave -noupdate -format Logic /tb_jkflop/k_in
add wave -noupdate -format Logic /tb_jkflop/rst
add wave -noupdate -format Logic /tb_jkflop/clk
add wave -noupdate -format Logic /tb_jkflop/q_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
