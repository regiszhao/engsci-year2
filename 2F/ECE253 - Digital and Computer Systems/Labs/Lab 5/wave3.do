# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part3.v

#load simulation using mux as the top level simulation module
vsim part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Resetn} 1
force {Start} 1
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Resetn} 0
force {Start} 1
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 0
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {ClockIn} 1
force {Resetn} 0
force {Start} 0
force {Letter} 110
#run simulation for a few ns
run 10ns