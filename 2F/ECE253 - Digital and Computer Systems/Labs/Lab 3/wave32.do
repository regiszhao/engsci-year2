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
force {A} 0000
force {B} 0000
force {Function} 010
#run simulation for a few ns
run 10ns

#second test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {A} 0001
force {B} 0011
force {Function} 010
#run simulation for a few ns
run 10ns

#second test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {A} 1111
force {B} 0111
force {Function} 010
#run simulation for a few ns
run 10ns

#second test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {A} 1101
force {B} 1010
force {Function} 010
#run simulation for a few ns
run 10ns

#second test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {A} 0110
force {B} 1001
force {Function} 010
#run simulation for a few ns
run 10ns