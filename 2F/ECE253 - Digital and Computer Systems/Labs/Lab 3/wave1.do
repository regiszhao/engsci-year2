# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part1.v

#load simulation using mux as the top level simulation module
vsim part1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {MuxSelect} 000
force {Input} 0000000
#run simulation for one ns
run 1ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {MuxSelect} 001
force {Input} 0000000
#run simulation for one ns
run 1ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {MuxSelect} 010
force {Input} 0000000
#run simulation for one ns
run 1ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {MuxSelect} 011
force {Input} 0000000
#run simulation for one ns
run 1ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {MuxSelect} 100
force {Input} 0000000
#run simulation for one ns
run 1ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {MuxSelect} 101
force {Input} 0000000
#run simulation for one ns
run 1ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {MuxSelect} 110
force {Input} 0000000
#run simulation for one ns
run 1ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {MuxSelect} 111
force {Input} 0000000
#run simulation for one ns
run 1ns