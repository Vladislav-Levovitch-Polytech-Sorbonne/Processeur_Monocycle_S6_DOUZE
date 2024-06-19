library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity test_bench_Additionneur_2_Entrees_entity is
end test_bench_Additionneur_2_Entrees_entity;

architecture test_bench_Additionneur_2_Entrees_architecture of test_bench_Additionneur_2_Entrees_entity is

-- Signals
	-- Entree
	signal SIGNAL_Test_Bench_Add_E_A, SIGNAL_Test_Bench_Add_E_B  : std_logic_vector(31 downto 0) := (others => '0');

	-- Sortie
	signal SIGNAL_Test_Bench_Add_S_A, SIGNAL_Test_Bench_Add_S_B  : std_logic_vector(31 downto 0) := (others => '0');

-- Content
begin

Bascule_D_Simple_PC : entity work.Additionneur_2_Entrees_entity
	port map 
	(
		Add_E_A => SIGNAL_Test_Bench_Add_E_A,
		Add_E_B => SIGNAL_Test_Bench_Add_E_B,
		Add_S_A => SIGNAL_Test_Bench_Add_S_A,
		Add_S_B => SIGNAL_Test_Bench_Add_S_B
	);

process
begin
	-- Initialisation
	SIGNAL_Test_Bench_Add_E_A <= x"0000_0000";
	SIGNAL_Test_Bench_Add_E_B <= x"0000_0000"; 
	wait for 1 ns;	
	
	-- Test nouvel offset et MAJ
	SIGNAL_Test_Bench_Add_E_B <= x"0000_0004"; 
	wait for 12 ns;

	-- Test a la suite
	SIGNAL_Test_Bench_Add_E_B <= x"0000_0005";
	wait for 12 ns;

	-- Test grande valeurs pour verifier le modulo 64 rabaissant tous les bits suivant a 0
	SIGNAL_Test_Bench_Add_E_B <= x"0000_FA0A"; 
	wait for 12 ns;

	wait;

end process;
end test_bench_Additionneur_2_Entrees_architecture;
