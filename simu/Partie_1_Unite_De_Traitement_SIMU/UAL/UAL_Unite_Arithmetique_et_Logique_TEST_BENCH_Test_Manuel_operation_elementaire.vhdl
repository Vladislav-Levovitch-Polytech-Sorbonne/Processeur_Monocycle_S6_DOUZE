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

		-- TEST ELEMENTAIRE

		wait for 1 ns; -- Protection d entree en non assignation
		--Test A
		SIGNAL_Test_Bench_OP_UAL <= "011";
		SIGNAL_Test_Bench_A_UAL <= x"0000_1983";
		SIGNAL_Test_Bench_B_UAL <= x"0000_0001";
		wait for 1 ns; -- Protection des asserts

        assert (SIGNAL_Test_Bench_S_UAL = x"0000_1983") report "Test A normal : Erreur resutat" severity error;
		assert (SIGNAL_Test_Bench_Z_UAL = '0') report "Test A normal : Z_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_N_UAL = '0') report "Test A normal : N_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_C_UAL = '0') report "Test A normal : C_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_V_UAL = '0') report "Test A normal : V_UAL incorrect" severity error;
		wait for 3 ns;

		--Test B
		SIGNAL_Test_Bench_OP_UAL <= "001";
		SIGNAL_Test_Bench_A_UAL <= x"0000_0001";
		SIGNAL_Test_Bench_B_UAL <= x"0000_1991";
		wait for 1 ns; -- Protection des asserts

        assert (SIGNAL_Test_Bench_S_UAL = x"0000_1991") report "Test B normal : Erreur resutat" severity error;
		assert (SIGNAL_Test_Bench_Z_UAL = '0') report "Test B normal : Z_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_N_UAL = '0') report "Test B normal : N_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_C_UAL = '0') report "Test B normal : C_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_V_UAL = '0') report "Test B normal : V_UAL incorrect" severity error;
		wait for 3 ns;

		--Test OR
		SIGNAL_Test_Bench_OP_UAL <= "100";
		SIGNAL_Test_Bench_A_UAL <= x"0001_0002";
		SIGNAL_Test_Bench_B_UAL <= x"0000_1991";
		wait for 1 ns; -- Protection des asserts

        assert (SIGNAL_Test_Bench_S_UAL = x"0001_1993") report "Test OR normal : Erreur resutat" severity error;
		assert (SIGNAL_Test_Bench_Z_UAL = '0') report "Test OR normal : Z_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_N_UAL = '0') report "Test OR normal : N_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_C_UAL = '0') report "Test OR normal : C_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_V_UAL = '0') report "Test OR normal : V_UAL incorrect" severity error;
		wait for 3 ns;

		--Test AND
		SIGNAL_Test_Bench_OP_UAL <= "101";
		SIGNAL_Test_Bench_A_UAL <= x"0001_0011";
		SIGNAL_Test_Bench_B_UAL <= x"0000_1991";
		wait for 1 ns; -- Protection des asserts

        assert (SIGNAL_Test_Bench_S_UAL = x"0000_0011") report "Test AND normal : Erreur resutat" severity error;
		assert (SIGNAL_Test_Bench_Z_UAL = '0') report "Test AND normal : Z_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_N_UAL = '0') report "Test AND normal : N_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_C_UAL = '0') report "Test AND normal : C_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_V_UAL = '0') report "Test AND normal : V_UAL incorrect" severity error;
		wait for 3 ns;

		--Test XOR
		SIGNAL_Test_Bench_OP_UAL <= "110";
		SIGNAL_Test_Bench_A_UAL <= x"0000_0001";
		SIGNAL_Test_Bench_B_UAL <= x"0000_1991";
		wait for 1 ns; -- Protection des asserts

        assert (SIGNAL_Test_Bench_S_UAL = x"0000_1990") report "Test XOR normal : Erreur resutat" severity error;
		assert (SIGNAL_Test_Bench_Z_UAL = '0') report "Test XOR normal : Z_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_N_UAL = '0') report "Test XOR normal : N_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_C_UAL = '0') report "Test XOR normal : C_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_V_UAL = '0') report "Test XOR normal : V_UAL incorrect" severity error;
		wait for 3 ns;

		--Test NOT
		SIGNAL_Test_Bench_OP_UAL <= "111";
		SIGNAL_Test_Bench_A_UAL <= x"7000_0001";
		wait for 1 ns; -- Protection des asserts

        assert (SIGNAL_Test_Bench_S_UAL = x"8FFF_FFFE") report "Test NOT normal : Erreur resutat" severity error;
		assert (SIGNAL_Test_Bench_Z_UAL = '0') report "Test NOT normal : Z_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_N_UAL = '1') report "Test NOT normal : N_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_C_UAL = '0') report "Test NOT normal : C_UAL incorrect" severity error;
		assert (SIGNAL_Test_Bench_V_UAL = '0') report "Test NOT normal : V_UAL incorrect" severity error;
		wait for 3 ns;

		wait;
    end process Test_bench_UAL;   
end test_bench_UAL_architecture;