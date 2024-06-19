# Creation de la lirairie de travail
vlib work

# Compilation de UAL_Banc_de_Registre dans le doute 
vcom -93 ../../src/Horloge.vhdl
vcom -93 ../../src/Partie_1_Unite_De_Traitement_SRC/UAL_Unite_Arithmetique_et_Logique.vhdl
vcom -93 ../../src/Partie_1_Unite_De_Traitement_SRC/Banc_de_Registre_Valeur_Initialisee.vhdl
vcom -93 ../../src/Partie_1_Unite_De_Traitement_SRC/UAL_Banc_de_Registre.vhdl
vcom -93 ../../src/Partie_1_Unite_De_Traitement_SRC/Mux_2_to_1_N_Bits.vhdl
vcom -93 ../../src/Partie_1_Unite_De_Traitement_SRC/Extension_de_Signe.vhdl
vcom -93 ../../src/Partie_1_Unite_De_Traitement_SRC/Memoire_de_donnees.vhdl
vcom -93 Unite_de_Traitement_TEST_BENCH.vhdl

# Simulation
vsim test_bench_Unite_de_Traitement_entity

# Visualisation
view signals
add wave *

#run -all Tres dangeure avec le While 1 de l'Horloge Attention
run 100 ns
wave zoom full