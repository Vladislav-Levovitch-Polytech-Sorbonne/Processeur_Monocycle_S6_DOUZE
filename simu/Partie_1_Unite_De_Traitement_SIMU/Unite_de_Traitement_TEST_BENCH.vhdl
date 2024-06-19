library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity test_bench_Unite_de_Traitement_entity is
end test_bench_Unite_de_Traitement_entity;

architecture test_bench_Unite_de_Traitement_architecture of test_bench_Unite_de_Traitement_entity is

-- Signal
    -- Entrees
    signal SIGNAL_Test_Bench_Clk_UT, SIGNAL_Test_Bench_Rst_UT, SIGNAL_Test_Bench_WE_UT : std_logic := '0';
    signal SIGNAL_Test_Bench_Ra_UT, SIGNAL_Test_Bench_Rb_UT, SIGNAL_Test_Bench_Rw_UT : std_logic_vector (3 downto 0) := "0000"; -- Bus Adresse
    signal SIGNAL_Test_Bench_OP_UT  : std_logic_vector (2 downto 0) := "000"; -- 3 bits de Commande de l operation a selectionner sur l UAL
    
	-- Sorties
    signal SIGNAL_Test_Bench_N_UT, SIGNAL_Test_Bench_Z_UT, SIGNAL_Test_Bench_C_UT, SIGNAL_Test_Bench_V_UT : std_logic := '0'; -- Drapeaux
    signal SIGNAL_Test_Bench_S_UT : std_logic_vector (31 downto 0) := x"0000_0000"; -- Bit de resultat

-- Content
begin 

UUT_UAL_Banc_de_Registre : entity work.UAL_Banc_de_Registre_entity

	port map 
	(
		Clk_UT => SIGNAL_Test_Bench_Clk_UT, 
		Rst_UT => SIGNAL_Test_Bench_Rst_UT, 
		WE_UT  => SIGNAL_Test_Bench_WE_UT,

		Ra_UT => SIGNAL_Test_Bench_Ra_UT,
		Rb_UT => SIGNAL_Test_Bench_Rb_UT,
		Rw_UT => SIGNAL_Test_Bench_Rw_UT,
		OP_UT => SIGNAL_Test_Bench_OP_UT,

		S_UT => SIGNAL_Test_Bench_S_UT,

		N_UT => SIGNAL_Test_Bench_N_UT, 
		Z_UT => SIGNAL_Test_Bench_Z_UT, 
		C_UT => SIGNAL_Test_Bench_C_UT,
		V_UT => SIGNAL_Test_Bench_V_UT
	);

UUT_THE_HORLOGE : entity work.Tic_Tac_entity -- Horloge
	port map 
	(
		THE_Clk => SIGNAL_Test_Bench_Clk_UT
	);

Test_bench_Unite_de_Traitement : process 
    begin        
        wait for 1 ns;
        SIGNAL_Test_Bench_Rst_UT <= '1'; -- Reset redemarrage sans echec avec valeurs deja dans les registres utile R15 et R7
		wait for 1 ns;
        SIGNAL_Test_Bench_Rst_UT <= '0';
		wait for 1 ns;
        SIGNAL_Test_Bench_WE_UT <= '1'; -- Dans le doute
		wait for 12 ns; -- Maj coup de clock

        -- R1 = R15
        SIGNAL_Test_Bench_Ra_UT <= "1111"; -- R15
        SIGNAL_Test_Bench_OP_UT <= "011";  -- S = A
        SIGNAL_Test_Bench_Rw_UT <= "0001"; -- Ecriture dans R1
        wait for 12 ns;

        -- Verification R1 = 
        assert SIGNAL_Test_Bench_S_UT = x"0040_2010" report "Test = incorrect" severity failure;
        wait for 12 ns;

        -- R1 = R1 + R15
        SIGNAL_Test_Bench_Ra_UT <= "1111"; -- R15
        SIGNAL_Test_Bench_Rb_UT <= "0001"; -- R1
        SIGNAL_Test_Bench_OP_UT <= "000"; -- S = A + B
        SIGNAL_Test_Bench_Rw_UT <= "0001"; -- Ecriture dans R1
        wait for 12 ns;

        -- Verification R1 +
        assert SIGNAL_Test_Bench_S_UT = x"0080_4020" report "Test +1 incorrect" severity failure;
        wait for 12 ns;

        -- R2 = R1 + R15
        SIGNAL_Test_Bench_Ra_UT <= "0001"; -- R1
        SIGNAL_Test_Bench_Rb_UT <= "1111"; -- R15
        SIGNAL_Test_Bench_OP_UT <= "000"; -- S = A + B
        SIGNAL_Test_Bench_Rw_UT <= "0010"; -- Ecriture dans R2
        wait for 12 ns;

        -- Verification R2 +
        assert SIGNAL_Test_Bench_S_UT = x"00C0_6030" report "Test +2 incorrect" severity failure;
        wait for 12 ns;

        -- R3 = R1 - R15
        SIGNAL_Test_Bench_Ra_UT <= "0001"; -- R1
        SIGNAL_Test_Bench_Rb_UT <= "1111"; -- R15
        SIGNAL_Test_Bench_OP_UT <= "010"; -- S = A - B
        SIGNAL_Test_Bench_Rw_UT <= "0011"; -- Ecriture dans R3
        wait for 12 ns;

        -- Verification R3 -
        assert SIGNAL_Test_Bench_S_UT = x"0040_2010" report "Test -3 incorrect" severity failure;
        wait for 12 ns;

        -- R5 = R7 - R15
        SIGNAL_Test_Bench_Rw_UT <= "0111"; -- Ecriture dans R7
        wait for 12 ns;
        
        SIGNAL_Test_Bench_Ra_UT <= "0111"; -- R7
        SIGNAL_Test_Bench_Rb_UT <= "1111"; -- R15
        SIGNAL_Test_Bench_OP_UT <= "010"; -- S = A - B
        SIGNAL_Test_Bench_Rw_UT <= "0101"; -- Ecriture dans R5
        wait for 12 ns;

        -- Verification R5 -
        assert SIGNAL_Test_Bench_S_UT = x"00000000" report "Test -5 incorrect" severity failure;
        wait for 12 ns;

        wait;
    end process Test_bench_Unite_de_Traitement;   
end test_bench_Unite_de_Traitement_architecture;
