# Creation de la lirairie de travail
vlib work

# Compilation
vcom -93 ../../../src/Partie_1_Unite_De_Traitement_SRC/Mux_2_to_1_N_Bits.vhdl
vcom -93 Multiplexeur_TEST_BENCH.vhdl

# Simulation
vsim test_bench_multiplexeur_entity

# Visualisation
view signals
add wave *

run -all 
wave zoom full