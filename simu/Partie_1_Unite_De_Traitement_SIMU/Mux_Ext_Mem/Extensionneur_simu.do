# Creation de la lirairie de travail
vlib work

# Compilation
vcom -93 ../../../src/Partie_1_Unite_De_Traitement_SRC/Extension_de_Signe.vhdl
vcom -93 Extensionneur_TEST_BENCH.vhdl

# Simulation
vsim test_bench_Extensionneur_entity

# Visualisation
view signals
add wave *

run -all 
wave zoom full