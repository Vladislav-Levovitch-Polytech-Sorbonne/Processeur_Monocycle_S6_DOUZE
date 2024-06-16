vlib work

vcom -93 ../../../src/Partie_1_Unite_De_Traitement_SRC/Banc_de_Registre.vhdl
vcom -93 Banc_de_Registre_TEST_BENCH.vhdl

vsim test_bench_Banc_de_Registre_entity

view signals
add wave *


run -all
wave zoom full