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
force {clock} 1
force {reset} 0
force {ParallelLoadn} 0
force {RotateRight} 0
force {ASRight} 0
force {Data_IN} 01011101
#run simulation for one ns
run 1ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {clock} 0
force {reset} 0
force {ParallelLoadn} 1
force {RotateRight} 1
force {ASRight} 1
force {Data_IN} 00000000
#run simulation for one ns
run 1ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {clock} 1
force {reset} 0
force {ParallelLoadn} 1
force {RotateRight} 1
force {ASRight} 1
force {Data_IN} 00000000
#run simulation for one ns
run 1ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {clock} 0
force {reset} 0
force {ParallelLoadn} 1
force {RotateRight} 1
force {ASRight} 1
force {Data_IN} 00000000
#run simulation for one ns
run 1ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {clock} 1
force {reset} 0
force {ParallelLoadn} 1
force {RotateRight} 1
force {ASRight} 1
force {Data_IN} 00000000
#run simulation for one ns
run 1ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {clock} 0
force {reset} 0
force {ParallelLoadn} 1
force {RotateRight} 1
force {ASRight} 1
force {Data_IN} 00000000
#run simulation for one ns
run 1ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {clock} 1
force {reset} 0
force {ParallelLoadn} 0
force {RotateRight} 1
force {ASRight} 1
force {Data_IN} 11111101
#run simulation for one ns
run 1ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {clock} 0
force {reset} 0
force {ParallelLoadn} 1
force {RotateRight} 1
force {ASRight} 1
force {Data_IN} 00000000
#run simulation for one ns
run 1ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {clock} 1
force {reset} 0
force {ParallelLoadn} 1
force {RotateRight} 1
force {ASRight} 1
force {Data_IN} 00000000
#run simulation for one ns
run 1ns