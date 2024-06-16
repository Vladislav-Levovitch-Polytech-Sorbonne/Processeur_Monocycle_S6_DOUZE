vlib work

vcom -93 ../../../src/Partie_1_Unite_De_Traitement_SRC/UAL_Unite_Arithmetique_et_Logique.vhdl
vcom -93 UAL_Unite_Arithmetique_et_Logique_TEST_BENCH_Version_Boucles.vhdl

vsim test_bench_UAL_Unite_Arithmetique_et_Logique_entity

view signals
add wave *


run -all
wave zoom full