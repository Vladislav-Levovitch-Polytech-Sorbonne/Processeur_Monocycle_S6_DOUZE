library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.ALL;

entity test_bench_UAL_Banc_de_Registre_entity is
    
end test_bench_UAL_Banc_de_Registre_entity;

architecture test_bench_UAL_Banc_de_Registre_architecture of test_bench_UAL_Banc_de_Registre_entity is
	
	-- Entrees
	signal SIGNAL_Test_Bench_Clk_BR : std_logic := '0';
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

UUT_THE_HORLOGE : entity work.Tic_Tac_entity -- Aidee par ChatGPT
        port map 
		(
            THE_Clk => SIGNAL_Test_Bench_Clk_BR
        );

Test_bench_UAL_Banc_de_Registre : process 
	
    begin		

		-- TEST Ecriture 

		wait for 1 ns; -- Protection d entree en non assignation
		SIGNAL_Test_Bench_WE_BR <= '1';
		SIGNAL_Test_Bench_W_BR <= x"4444_4444";
		SIGNAL_Test_Bench_Rw_BR <= "1111";

		wait for 12 ns; -- Protection des asserts attente periode horloe
        assert (SIGNAL_Test_Bench_A_BR = x"0000_0000") report "Test Ecriture sans registre de sortie : Erreur resutat" severity error;
		wait for 3 ns;

		-- TEST Lecture 
	-- Test Lecture Simple
		SIGNAL_Test_Bench_W_BR <= x"AAAA_1111";
		SIGNAL_Test_Bench_Rw_BR <= "0001";
		SIGNAL_Test_Bench_Rb_BR <= "1111";
		wait for 12 ns; -- Protection des asserts attente periode horloge
        assert (SIGNAL_Test_Bench_B_BR = x"4444_4444") report "Test Ecriture avec registre de sortie B : Erreur resutat" severity error;
		
		-- TEST Lecture 
	-- Test Lecture apres Ecriture
		SIGNAL_Test_Bench_W_BR <= x"0000_1001";
		SIGNAL_Test_Bench_Rw_BR <= "0010";
		SIGNAL_Test_Bench_Ra_BR <= "1111";
		SIGNAL_Test_Bench_Rb_BR <= "0001";
		wait for 12 ns; -- Protection des asserts attente periode horloge
        assert (SIGNAL_Test_Bench_A_BR = x"4444_4444") report "Test Ecriture avec registre simultane de sortie A : Erreur resutat" severity error;
		assert (SIGNAL_Test_Bench_B_BR = x"AAAA_1111") report "Test Ecriture avec registre simultane de sortie B : Erreur resutat" severity error;
		
		-- TEST Lecture 
	-- Test Lecture avant Ecriture
		SIGNAL_Test_Bench_W_BR <= x"0000_10AA";
		SIGNAL_Test_Bench_Rw_BR <= "0011";
		SIGNAL_Test_Bench_Ra_BR <= "0011";
		SIGNAL_Test_Bench_Rb_BR <= "1111";
		wait for 12 ns; -- Protection des asserts attente periode horloge
		assert (SIGNAL_Test_Bench_A_BR = x"0000_0000") report "Test Ecriture avec registre simultane et avant ecriture de sortie A : Erreur resutat" severity error;
		assert (SIGNAL_Test_Bench_B_BR = x"4444_4444") report "Test Ecriture avec registre simultane et avant ecriture de sortie B : Erreur resutat" severity error;

	-- Test Lecture Enable sans ecriture
		SIGNAL_Test_Bench_WE_BR <= '0';
		SIGNAL_Test_Bench_W_BR <= x"0000_0002"; -- Pour mieu voir on aurait pu decaler d une periode en plus le retabli
		SIGNAL_Test_Bench_Rw_BR <= "0110";
		SIGNAL_Test_Bench_Ra_BR <= "0110";
		SIGNAL_Test_Bench_Rb_BR <= "0011";
		wait for 5 ns;
		assert (SIGNAL_Test_Bench_A_BR = x"0000_0000") report "Test sans Ecriture A : Erreur resutat" severity error;
		assert (SIGNAL_Test_Bench_B_BR = x"0000_10AA") report "Test sans Ecriture B : Erreur resutat" severity error;
		SIGNAL_Test_Bench_WE_BR <= '1';
		wait for 12 ns; -- Protection des asserts attente periode horloge
		
	-- Test Lecture Reset
		SIGNAL_Test_Bench_Rst_BR <= '1';
		wait for 2 ns;
		SIGNAL_Test_Bench_Rst_BR <= '0';
		SIGNAL_Test_Bench_W_BR <= x"0000_10A1";
		SIGNAL_Test_Bench_Rw_BR <= "1100";
		wait for 3 ns;
		SIGNAL_Test_Bench_Ra_BR <= "1100";
		SIGNAL_Test_Bench_Rb_BR <= "0010";
		wait for 19 ns; -- Protection des asserts attente periode horloge
		assert (SIGNAL_Test_Bench_A_BR = x"0000_0000") report "Test Ecriture apres Reset A : Erreur resutat" severity error;
		assert (SIGNAL_Test_Bench_B_BR = x"0000_0000") report "Test Ecriture apres Reset B : Erreur resutat" severity error;
		wait for 1 ns;

		wait;
    end process Test_bench_UAL_Banc_de_Registre;   
end test_bench_UAL_Banc_de_Registre_architecture;