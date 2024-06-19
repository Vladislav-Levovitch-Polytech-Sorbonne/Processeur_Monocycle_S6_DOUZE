# Creation de la lirairie de travail
vlib work

# Compilation de UAL_Banc_de_Registre dans le doute 
vcom -93 ../../src/Horloge.vhdl
vcom -93 ../../src/Partie_2_Unite_De_Gestion_Des_Instructions_SRC/Additionneur_2_Entrees.vhdl
vcom -93 ../../src/Partie_2_Unite_De_Gestion_Des_Instructions_SRC/Bacule_D_Simple_PC.vhdl
vcom -93 ../../src/Partie_2_Unite_De_Gestion_Des_Instructions_SRC/Extension_de_Signe.vhdl
vcom -93 ../../src/Partie_2_Unite_De_Gestion_Des_Instructions_SRC/Memoire_Instruction_By_DOUZE.vhdl
vcom -93 ../../src/Partie_2_Unite_De_Gestion_Des_Instructions_SRC/Mux_2_to_1_N_Bits.vhdl

vcom -93 ../../src/Partie_2_Unite_De_Gestion_Des_Instructions_SRC/Unite_de_Gestion_Des_Instructions.vhdl
vcom -93 Unite_de_Gestion_Des_Instructions_TEST_BENCH.vhdl

# Simulation
vsim TEST_BENCH_Unite_de_Gestion_Des_Instructions_entity

# Visualisation
view signals
add wave *

#run -all Tres dangeure avec le While 1 de l'Horloge Attention
run 150 ns
wave zoom full