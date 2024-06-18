# Creation de la lirairie de travail
vlib work

# Compilation
vcom -93 ../../../src/Horloge.vhdl
vcom -93 ../../../src/Partie_1_Unite_De_Traitement_SRC/Memoire_de_donnees.vhdl
vcom -93 Memory_TEST_BENCH.vhdl

# Simulation
vsim test_bench_Memory_entity

# Visualisation
view signals
add wave *

#run -all Tres dangeure avec le While 1 de l'Horloge Attention
run 2 us
wave zoom full