vlib work

vcom -93 ../../../src/Partie_1_Unite_De_Traitement_SRC/Banc_de_Registre.vhdl
vcom -93 Banc_de_Registre_TEST_BENCH.vhdl

vsim test_bench_UAL_Unite_Arithmetique_et_Logique_entity

view signals
add wave *


run -all
wave zoom full