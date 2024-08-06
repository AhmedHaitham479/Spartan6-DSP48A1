vlib work
vlog DSPR.v DSPR_tb.v
vsim -voptargs=+acc DSP48A1_tb
add wave -position insertpoint\
sim:/DSP48A1_tb/A\
sim:/DSP48A1_tb/B\
sim:/DSP48A1_tb/D\
sim:/DSP48A1_tb/OPMODE\
sim:/DSP48A1_tb/BCIN\
sim:/DSP48A1_tb/C\
sim:/DSP48A1_tb/PCIN\
sim:/DSP48A1_tb/CARRYIN\
sim:/DSP48A1_tb/CLK\
sim:/DSP48A1_tb/CEA\
sim:/DSP48A1_tb/RSTA\
sim:/DSP48A1_tb/PCOUT\
sim:/DSP48A1_tb/P\
sim:/DSP48A1_tb/BCOUT\
sim:/DSP48A1_tb/M\
sim:/DSP48A1_tb/CARRYOUT\
sim:/DSP48A1_tb/CARRYOUTF
run -all
#quit -sim