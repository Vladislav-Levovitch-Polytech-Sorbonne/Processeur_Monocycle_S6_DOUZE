# Creation de la lirairie de travail
vlib work

# Compilation
vcom -93 ../../../src/Horloge.vhdl
vcom -93 ../../../src/Partie_1_Unite_De_Traitement_SRC/UAL_Unite_Arithmetique_et_Logique.vhdl
vcom -93 ../../../src/Partie_1_Unite_De_Traitement_SRC/Banc_de_Registre_Valeur_Initialisee.vhdl
vcom -93 ../../../src/Partie_1_Unite_De_Traitement_SRC/UAL_Banc_de_Registre.vhdl
vcom -93 UAL_Banc_de_Registre_TEST_BENCH.vhdl

# Simulation
vsim test_bench_UAL_Banc_de_Registre_entity

# Visualisation
view signals
add wave *

#run -all Tres dangeure avec le While 1 de l'Horloge Attention
run 2 us
wave zoom full