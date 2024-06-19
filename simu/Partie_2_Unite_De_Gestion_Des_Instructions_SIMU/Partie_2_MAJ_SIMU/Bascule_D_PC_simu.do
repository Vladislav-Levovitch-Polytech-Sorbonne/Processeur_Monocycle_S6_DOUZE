# Creatation de la lirairie de travail
vlib work

# Compilation
vcom -93 ../../../src/Horloge.vhdl
vcom -93 ../../../src/Partie_2_Unite_De_Gestion_Des_Instructions_SRC/Bacule_D_Simple_PC.vhdl
vcom -93 Bascule_D_PC_TEST_BENCH.vhdl

# Simulation
vsim test_bench_Bascule_D_Simple_PC_entity

# Visualisation
view signals
add wave *

#run -all Tres dangeure avec le While 1 de l'Horloge Attention
run 1 us
wave zoom full