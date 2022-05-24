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
force {ClockIn} 0
force {Reset} 1
force {Speed} 00
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Reset} 0
force {Speed} 00
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Reset} 0
force {Speed} 00
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Reset} 0
force {Speed} 00
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Reset} 0
force {Speed} 00
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Reset} 0
force {Speed} 00
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Reset} 0
force {Speed} 00
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Reset} 0
force {Speed} 00
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Reset} 0
force {Speed} 00
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Reset} 0
force {Speed} 00
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Reset} 0
force {Speed} 00
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Reset} 0
force {Speed} 00
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Reset} 0
force {Speed} 00
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Reset} 0
force {Speed} 00
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Reset} 0
force {Speed} 00
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Reset} 0
force {Speed} 00
#run simulation for a few ns
run 10ns