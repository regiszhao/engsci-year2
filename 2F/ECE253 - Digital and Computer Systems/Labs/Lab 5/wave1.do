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
force {Clock} 0
force {Enable} 0
force {Clear_b} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {Clock} 1
force {Enable} 0
force {Clear_b} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {Clock} 0
force {Enable} 0
force {Clear_b} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {Clock} 1
force {Enable} 0
force {Clear_b} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {Clock} 0
force {Enable} 0
force {Clear_b} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {Clock} 1
force {Enable} 0
force {Clear_b} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {Clock} 0
force {Enable} 0
force {Clear_b} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {Clock} 1
force {Enable} 0
force {Clear_b} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {Clock} 0
force {Enable} 0
force {Clear_b} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {Clock} 1
force {Enable} 0
force {Clear_b} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {Clock} 0
force {Enable} 0
force {Clear_b} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {Clock} 1
force {Enable} 0
force {Clear_b} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {Clock} 0
force {Enable} 0
force {Clear_b} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {Clock} 1
force {Enable} 0
force {Clear_b} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {Clock} 0
force {Enable} 0
force {Clear_b} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {Clock} 1
force {Enable} 0
force {Clear_b} 0
#run simulation for a few ns
run 10ns