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
force {a} 0000
force {b} 0000
force {c_in} 0
#run simulation for a few ns
run 10ns

#second test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {a} 0000
force {b} 0001
force {c_in} 0
run 10ns

#second test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {a} 0001
force {b} 0001
force {c_in} 0
run 10ns

#second test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {a} 0001
force {b} 0001
force {c_in} 1
run 10ns

#second test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {a} 0011
force {b} 0011
force {c_in} 0
run 10ns

#second test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {a} 1001
force {b} 0110
force {c_in} 0
run 10ns

#second test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {a} 1111
force {b} 1111
force {c_in} 0
run 10ns

#second test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {a} 1111
force {b} 1111
force {c_in} 1
run 10ns