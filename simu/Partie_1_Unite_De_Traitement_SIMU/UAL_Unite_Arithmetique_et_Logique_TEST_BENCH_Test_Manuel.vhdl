library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.ALL;

entity test_bench_UAL_Unite_Arithmetique_et_Logique_entity is
    
end test_bench_UAL_Unite_Arithmetique_et_Logique_entity;

architecture test_bench_UAL_architecture of test_bench_UAL_Unite_Arithmetique_et_Logique_entity is
	
	-- Entrees
	signal SIGNAL_Test_Bench_OP_UAL  : std_logic_vector(2 downto 0) := "000"; -- Signal de commande sur 3 bits
    signal SIGNAL_Test_Bench_A_UAL,SIGNAL_Test_Bench_B_UAL : std_logic_vector(31 downto 0) := (others => '0');
	
    -- Sorties
	signal SIGNAL_Test_Bench_S_UAL   : std_logic_vector(31 downto 0) := x"0000_0000";
    signal SIGNAL_Test_Bench_N_UAL,SIGNAL_Test_Bench_Z_UAL, SIGNAL_Test_Bench_C_UAL,SIGNAL_Test_Bench_V_UAL : std_logic :='0'; -- Drapeaux

begin 
	uut_UAL : entity work.UAL_Unite_Arithmetique_et_Logique_entity
        port map 
		(
            OP_UAL=> SIGNAL_Test_Bench_OP_UAL,
            A_UAL => SIGNAL_Test_Bench_A_UAL,
            B_UAL => SIGNAL_Test_Bench_B_UAL,
            S_UAL => SIGNAL_Test_Bench_S_UAL,
            N_UAL => SIGNAL_Test_Bench_N_UAL,
            Z_UAL => SIGNAL_Test_Bench_Z_UAL,
            C_UAL => SIGNAL_Test_Bench_C_UAL,
            V_UAL => SIGNAL_Test_Bench_V_UAL
        );

Test_bench_UAL : process 
	
    begin		
		wait for 1 ns; -- Protection d entree en non assignation
		--Test Add somme sans drapeau
		SIGNAL_Test_Bench_OP_UAL <= "000";
		SIGNAL_Test_Bench_A_UAL <= x"0000_0030";
		SIGNAL_Test_Bench_B_UAL <= x"0000_010A";
		wait for 1 ns; -- Protection des asserts

        assert (SIGNAL_Test_Bench_S_UAL = x"0000_013A") report "Test ADD normal : Erreur resutat" severity error;
		assert (SIGNAL_Test_Bench_Z_UAL = '0') report "Test ADD normal : Z_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_N_UAL = '0') report "Test ADD normal : N_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_C_UAL = '0') report "Test ADD normal : C_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_V_UAL = '0') report "Test ADD normal : V_UAL incorrect" severity error;
		wait for 10 ns;

		--Test Add somme null drapeau ( a zero )
		SIGNAL_Test_Bench_OP_UAL <= "000";
		SIGNAL_Test_Bench_A_UAL <= x"0000_0030";  -- Nombre positif
		SIGNAL_Test_Bench_B_UAL <= x"FFFF_FFD0";  -- Negatif ( complement a 2 )
        wait for 1 ns; -- Protection des asserts

        assert (SIGNAL_Test_Bench_S_UAL = x"0000_0000") report "Test ADD Zero : Erreur resutat" severity error;
		assert (SIGNAL_Test_Bench_Z_UAL = '1') report "Test ADD Zero : Z_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_N_UAL = '0') report "Test ADD Zero : N_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_C_UAL = '0') report "Test ADD Zero : C_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_V_UAL = '0') report "Test ADD Zero : V_UAL incorrect" severity error;
		wait for 10 ns;

		--Test Add somme Negatif drapeau ( a negatif )
		SIGNAL_Test_Bench_OP_UAL <= "000";
		SIGNAL_Test_Bench_A_UAL <= x"FFFF_FFD0";  -- Nombre negatif
		SIGNAL_Test_Bench_B_UAL <= x"0000_0000";
		wait for 1 ns;

        assert (SIGNAL_Test_Bench_S_UAL = x"FFFF_FFD0") report "Test ADD Negatif : Erreur resutat" severity error;
		assert (SIGNAL_Test_Bench_Z_UAL = '0') report "Test ADD Negatif : Z_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_N_UAL = '1') report "Test ADD Negatif : N_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_C_UAL = '0') report "Test ADD Negatif : C_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_V_UAL = '0') report "Test ADD Negatif : V_UAL incorrect" severity error;
		wait for 10 ns;

		--Test Add somme Carry_Debordement drapeau ( vu qu on deborde lorsque fait une retenu )
		SIGNAL_Test_Bench_OP_UAL <= "000";
		SIGNAL_Test_Bench_A_UAL <= x"4000_0000";
		SIGNAL_Test_Bench_B_UAL <= x"4000_0000";
		wait for 1 ns;

		assert (SIGNAL_Test_Bench_S_UAL = x"8000_0000") report "Test ADD Carry_Debordement : Erreur resutat" severity error;
		assert (SIGNAL_Test_Bench_Z_UAL = '0') report "Test ADD Carry_Debordement : Z_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_N_UAL = '1') report "Test ADD Carry_Debordement : N_UAL incorrect" severity error; -- Normale en cas de Carry_Debordement
		assert (SIGNAL_Test_Bench_C_UAL = '1') report "Test ADD Carry_Debordement : C_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_V_UAL = '1') report "Test ADD Carry_Debordement : V_UAL incorrect" severity error;
		wait for 10 ns;

		wait;
    end process Test_bench_UAL;   
end test_bench_UAL_architecture;