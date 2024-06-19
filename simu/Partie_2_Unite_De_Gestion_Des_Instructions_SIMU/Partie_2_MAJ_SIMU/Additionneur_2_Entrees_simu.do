# Creatation de la lirairie de travail
vlib work

# Compilation
vcom -93 ../../../src/Partie_2_Unite_De_Gestion_Des_Instructions_SRC/Additionneur_2_Entrees.vhdl
vcom -93 Additionneur_2_Entrees_TEST_BENCH.vhdl

# Simulation
vsim test_bench_Additionneur_2_Entrees_entity

# Visualisation
view signals
add wave *

#run -all Tres dangeure avec le While 1 de l'Horloge Attention
run 60 ns
wave zoom full