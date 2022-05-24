# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part2.v

#load simulation using mux as the top level simulation module
vsim part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {Clock} 0
force {Reset_b} 1
force {Data} 0011
force {Function} 101
#run simulation for one ns
run 1ns
# ALUout: xxxxxxxx

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {Clock} 1
force {Reset_b} 1
force {Data} 0011
force {Function} 101
#run simulation for one ns
run 1ns
# ALUout: 00000000

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {Clock} 0
force {Reset_b} 1
force {Data} 1111
force {Function} 110
#run simulation for one ns
run 1ns
# ALUout: 00000000

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {Clock} 1
force {Reset_b} 1
force {Data} 1011
force {Function} 111
#run simulation for one ns
run 1ns
# ALUout: 00000000

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {Clock} 0
force {Reset_b} 1
force {Data} 0001
force {Function} 011
#run simulation for one ns
run 1ns
# ALUout: 00000000

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {Clock} 1
force {Reset_b} 1
force {Data} 0001
force {Function} 011
#run simulation for one ns
run 1ns
# ALUout: 00000000

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {Clock} 0
force {Reset_b} 1
force {Data} 0001
force {Function} 011
#run simulation for one ns
run 1ns
# ALUout: 00000000

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {Clock} 1
force {Reset_b} 1
force {Data} 0001
force {Function} 011
#run simulation for one ns
run 1ns
# ALUout: 00000000