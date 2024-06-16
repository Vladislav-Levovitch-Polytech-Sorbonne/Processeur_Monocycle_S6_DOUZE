library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.ALL;

entity test_bench_Banc_de_Registre_entity is
    
end test_bench_Banc_de_Registre_entity;

architecture test_bench_Banc_de_Registre_architecture of test_bench_Banc_de_Registre_entity is
	
	-- Entrees
	signal SIGNAL_Test_Bench_Clk_BR : std_logic := '0'; -- A remplacer
    signal SIGNAL_Test_Bench_Rst_BR : std_logic := '0';
    signal SIGNAL_Test_Bench_WE_BR  : std_logic := '0';

    signal SIGNAL_Test_Bench_Ra_BR, SIGNAL_Test_Bench_Rb_BR, SIGNAL_Test_Bench_Rw_BR : std_logic_vector(3 downto 0) := "0000";
    signal SIGNAL_Test_Bench_W_BR : std_logic_vector(31 downto 0) := x"0000_0000";

	-- Sorties
    signal SIGNAL_Test_Bench_A_BR, SIGNAL_Test_Bench_B_BR : std_logic_vector(31 downto 0) := x"0000_0000";

begin 
	uut_Banc_de_Registre : entity work.Banc_de_Registre_entity
        port map 
		(
			Clk_BR => SIGNAL_Test_Bench_Clk_BR,
        	Rst_BR => SIGNAL_Test_Bench_Rst_BR,
        	WE_BR  => SIGNAL_Test_Bench_WE_BR,

        	Ra_BR => SIGNAL_Test_Bench_Ra_BR,
			Rb_BR => SIGNAL_Test_Bench_Rb_BR,
			Rw_BR => SIGNAL_Test_Bench_Rw_BR,
        	W_BR  => SIGNAL_Test_Bench_W_BR,

        	A_BR => SIGNAL_Test_Bench_A_BR,
			B_BR => SIGNAL_Test_Bench_B_BR
        );
-- Instatiation de l horloge avec l aide de ChatGPT pour trouver ou la mettre
	-- Instanciation du module d'horloge 
	uut_clock_generator : entity work.Tic_Tac_entity
        port map (
            THE_Clk => SIGNAL_Test_Bench_Clk_BR
        );

Test_bench_Banc_de_Registre : process 
	
    begin		

		-- TEST Ecriture 

		wait for 1 ns; -- Protection d entree en non assignation
		--Test Add somme sans drapeau
		SIGNAL_Test_Bench_WE_BR <= '1';
		--SIGNAL_Test_Bench_B_UAL <= x"0000_010A";
		wait for 1 ns; -- Protection des asserts

        --assert (SIGNAL_Test_Bench_S_UAL = x"0000_013A") report "Test ADD normal : Erreur resutat" severity error;
		--assert (SIGNAL_Test_Bench_Z_UAL = '0') report "Test ADD normal : Z_UAL incorrect" severity error;
		wait for 3 ns;

		-- TEST Lecture 
	
	-- Test Lecture Simple

	-- Test Lecture Reset

	-- Test Lecture Enable sans ecriture

		wait;
    end process Test_bench_Banc_de_Registre;   
end test_bench_Banc_de_Registre_architecture;