library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity test_bench_UAL_Banc_de_Registre_entity is
end test_bench_UAL_Banc_de_Registre_entity;

architecture test_bench_UAL_Banc_de_Registre_architecture of test_bench_UAL_Banc_de_Registre_entity is

-- Signal
    -- Entrees
    signal SIGNAL_Test_Bench_Clk_BRUAL, SIGNAL_Test_Bench_Rst_BRUAL, SIGNAL_Test_Bench_WE_BRUAL : std_logic := '0';
    signal SIGNAL_Test_Bench_Ra_BRUAL, SIGNAL_Test_Bench_Rb_BRUAL, SIGNAL_Test_Bench_Rw_BRUAL : std_logic_vector (3 downto 0) := "0000"; -- Bus Adresse
    signal SIGNAL_Test_Bench_OP_BRUAL  : std_logic_vector (2 downto 0) := "000"; -- 3 bits de Commande de l operation a selectionner sur l UAL
    
	-- Sorties
    signal SIGNAL_Test_Bench_N_BRUAL, SIGNAL_Test_Bench_Z_BRUAL, SIGNAL_Test_Bench_C_BRUAL, SIGNAL_Test_Bench_V_BRUAL : std_logic := '0'; -- Drapeaux
    signal SIGNAL_Test_Bench_S_BRUAL : std_logic_vector (31 downto 0) := x"0000_0000"; -- Bit de resultat

-- Content
begin 

UUT_UAL_Banc_de_Registre : entity work.UAL_Banc_de_Registre_entity

	port map 
	(
		Clk_BRUAL => SIGNAL_Test_Bench_Clk_BRUAL, 
		Rst_BRUAL => SIGNAL_Test_Bench_Rst_BRUAL, 
		WE_BRUAL  => SIGNAL_Test_Bench_WE_BRUAL,

		Ra_BRUAL => SIGNAL_Test_Bench_Ra_BRUAL,
		Rb_BRUAL => SIGNAL_Test_Bench_Rb_BRUAL,
		Rw_BRUAL => SIGNAL_Test_Bench_Rw_BRUAL,
		OP_BRUAL => SIGNAL_Test_Bench_OP_BRUAL,

		S_BRUAL => SIGNAL_Test_Bench_S_BRUAL,

		N_BRUAL => SIGNAL_Test_Bench_N_BRUAL, 
		Z_BRUAL => SIGNAL_Test_Bench_Z_BRUAL, 
		C_BRUAL => SIGNAL_Test_Bench_C_BRUAL,
		V_BRUAL => SIGNAL_Test_Bench_V_BRUAL
	);

UUT_THE_HORLOGE : entity work.Tic_Tac_entity -- Horloge
	port map 
	(
		THE_Clk => SIGNAL_Test_Bench_Clk_BRUAL
	);

Test_bench_UAL_Banc_de_Registre : process 
    begin        
        wait for 1 ns;
        SIGNAL_Test_Bench_Rst_BRUAL <= '1'; -- Reset redemarrage sans echec avec valeurs deja dans les registres utile R15 et R7
		wait for 1 ns;
        SIGNAL_Test_Bench_Rst_BRUAL <= '0';
		wait for 1 ns;
        SIGNAL_Test_Bench_WE_BRUAL <= '1'; -- Dans le doute
		wait for 12 ns; -- Maj coup de clock

        -- R1 = R15
        SIGNAL_Test_Bench_Ra_BRUAL <= "1111"; -- R15
        SIGNAL_Test_Bench_OP_BRUAL <= "011";  -- S = A
        SIGNAL_Test_Bench_Rw_BRUAL <= "0001"; -- Ecriture dans R1
        wait for 12 ns;

        -- Verification R1 = 
        assert SIGNAL_Test_Bench_S_BRUAL = x"0040_2010" report "Test = incorrect" severity failure;
        wait for 12 ns;

        -- R1 = R1 + R15
        SIGNAL_Test_Bench_Ra_BRUAL <= "1111"; -- R15
        SIGNAL_Test_Bench_Rb_BRUAL <= "0001"; -- R1
        SIGNAL_Test_Bench_OP_BRUAL <= "000"; -- S = A + B
        SIGNAL_Test_Bench_Rw_BRUAL <= "0001"; -- Ecriture dans R1
        wait for 12 ns;

        -- Verification R1 +
        assert SIGNAL_Test_Bench_S_BRUAL = x"0080_4020" report "Test +1 incorrect" severity failure;
        wait for 12 ns;

        -- R2 = R1 + R15
        SIGNAL_Test_Bench_Ra_BRUAL <= "0001"; -- R1
        SIGNAL_Test_Bench_Rb_BRUAL <= "1111"; -- R15
        SIGNAL_Test_Bench_OP_BRUAL <= "000"; -- S = A + B
        SIGNAL_Test_Bench_Rw_BRUAL <= "0010"; -- Ecriture dans R2
        wait for 12 ns;

        -- Verification R2 +
        assert SIGNAL_Test_Bench_S_BRUAL = x"00C0_6030" report "Test +2 incorrect" severity failure;
        wait for 12 ns;

        -- R3 = R1 - R15
        SIGNAL_Test_Bench_Ra_BRUAL <= "0001"; -- R1
        SIGNAL_Test_Bench_Rb_BRUAL <= "1111"; -- R15
        SIGNAL_Test_Bench_OP_BRUAL <= "010"; -- S = A - B
        SIGNAL_Test_Bench_Rw_BRUAL <= "0011"; -- Ecriture dans R3
        wait for 12 ns;

        -- Verification R3 -
        assert SIGNAL_Test_Bench_S_BRUAL = x"0040_2010" report "Test -3 incorrect" severity failure;
        wait for 12 ns;

        -- R5 = R7 - R15
        SIGNAL_Test_Bench_Rw_BRUAL <= "0111"; -- Ecriture dans R7
        wait for 12 ns;
        
        SIGNAL_Test_Bench_Ra_BRUAL <= "0111"; -- R7
        SIGNAL_Test_Bench_Rb_BRUAL <= "1111"; -- R15
        SIGNAL_Test_Bench_OP_BRUAL <= "010"; -- S = A - B
        SIGNAL_Test_Bench_Rw_BRUAL <= "0101"; -- Ecriture dans R5
        wait for 12 ns;

        -- Verification R5 -
        assert SIGNAL_Test_Bench_S_BRUAL = x"00000000" report "Test -5 incorrect" severity failure;
        wait for 12 ns;

        wait;
    end process Test_bench_UAL_Banc_de_Registre;   
end test_bench_UAL_Banc_de_Registre_architecture;
