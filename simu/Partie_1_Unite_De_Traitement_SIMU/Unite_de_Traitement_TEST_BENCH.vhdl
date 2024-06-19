-- Test Bench co redigee avec l aide au debugage ChatGPT notamment sur les asserts et initialisation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity test_bench_Unite_de_Traitement_entity is
end test_bench_Unite_de_Traitement_entity;

architecture test_bench_Unite_de_Traitement_architecture of test_bench_Unite_de_Traitement_entity is
-- Signal
    -- Entrees
    signal SIGNAL_Test_Bench_Clk_UT, SIGNAL_Test_Bench_Rst_R_UT, SIGNAL_Test_Bench_Rst_M_UT, SIGNAL_Test_Bench_WE_UT, SIGNAL_Test_Bench_WrEN_UT : std_logic := '0';
    signal SIGNAL_Test_Bench_Ra_UT, SIGNAL_Test_Bench_Rb_UT, SIGNAL_Test_Bench_Rw_UT : std_logic_vector (3 downto 0) := x"F"; -- Bus Adresse
    signal SIGNAL_Test_Bench_Addr_UT : std_logic_vector(5 downto 0) := "111111"; -- Adresse memoire
    signal SIGNAL_Test_Bench_OP_UAL_UT  : std_logic_vector (2 downto 0) := "111"; -- 3 bits de Commande de l operation a selectionner sur l UAL
    signal SIGNAL_Test_Bench_OP_1_Mux, SIGNAL_Test_Bench_OP_2_Mux, SIGNAL_Test_Bench_COM_Memory : std_logic := '0';
    signal SIGNAL_Test_Bench_Imm_UT : std_logic_vector(15 downto 0) := x"0000"; -- Valeur immediate

    -- Sorties
    signal SIGNAL_Test_Bench_N_UT, SIGNAL_Test_Bench_Z_UT, SIGNAL_Test_Bench_C_UT, SIGNAL_Test_Bench_V_UT : std_logic := '0'; -- Drapeaux
    signal SIGNAL_Test_Bench_S_UT : std_logic_vector (31 downto 0) := x"FFFF_FFFF"; -- Bit de resultat

-- Content
begin
UUT_Unite_de_Traitement : entity work.Unite_de_Traitement_entity
    port map
    (
        Clk_UT => SIGNAL_Test_Bench_Clk_UT, 
        Rst_R_UT => SIGNAL_Test_Bench_Rst_R_UT,
        Rst_M_UT => SIGNAL_Test_Bench_Rst_M_UT,
        WE_UT => SIGNAL_Test_Bench_WE_UT,
        WrEN_UT => SIGNAL_Test_Bench_WrEN_UT,
        Ra_UT => SIGNAL_Test_Bench_Ra_UT,
        Rb_UT => SIGNAL_Test_Bench_Rb_UT,
        Rw_UT => SIGNAL_Test_Bench_Rw_UT,
        Addr_UT => SIGNAL_Test_Bench_Addr_UT,
        OP_UAL_UT => SIGNAL_Test_Bench_OP_UAL_UT,
        OP_1_Mux => SIGNAL_Test_Bench_OP_1_Mux,
        OP_2_Mux => SIGNAL_Test_Bench_OP_2_Mux,
        COM_Memory => SIGNAL_Test_Bench_COM_Memory,
        Imm_UT => SIGNAL_Test_Bench_Imm_UT,
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
-- Partie Externe sur S
    -- Initialisation au demarrage
    wait for 1 ns;
    SIGNAL_Test_Bench_Rst_M_UT <= '1';
    wait for 1 ns;
    SIGNAL_Test_Bench_Rst_R_UT <= '1';
    wait for 1 ns;
    SIGNAL_Test_Bench_Rst_M_UT <= '0';
    wait for 1 ns;
    SIGNAL_Test_Bench_Rst_R_UT <= '0';
    wait for 1 ns;

    -- Addition 2 Registres nulles pour verifier les drapeaux
    SIGNAL_Test_Bench_WE_UT <= '1';
    SIGNAL_Test_Bench_Ra_UT <= "1111";
    SIGNAL_Test_Bench_Rb_UT <= "0111";
    SIGNAL_Test_Bench_Rw_UT <= "0010";
    SIGNAL_Test_Bench_OP_UAL_UT <= "000";  -- Y = A + B 
    wait for 22 ns;
    assert SIGNAL_Test_Bench_S_UT = x"0000_0000" report "Addition 2 Registre incorrecte" severity error;

    -- Addition Registre + Valeur immediate 1
    SIGNAL_Test_Bench_OP_1_Mux <= '1';
    SIGNAL_Test_Bench_Imm_UT <= x"0301";
    SIGNAL_Test_Bench_Ra_UT <= "0010";
    SIGNAL_Test_Bench_Rw_UT <= "0011";
    SIGNAL_Test_Bench_OP_UAL_UT <= "000";  -- Y = A + B 
    wait for 22 ns;
    assert SIGNAL_Test_Bench_S_UT = x"0000_0301" report "Addition Registre + Valeur immediate incorrecte" severity error;

    -- Addition Registre + Valeur immediate 2
    SIGNAL_Test_Bench_OP_1_Mux <= '1';
    SIGNAL_Test_Bench_Imm_UT <= x"04F0";
    SIGNAL_Test_Bench_Ra_UT <= "0010";
    SIGNAL_Test_Bench_Rw_UT <= "1000";
    SIGNAL_Test_Bench_OP_UAL_UT <= "000";  -- Y = A + B 
    wait for 22 ns;
    assert SIGNAL_Test_Bench_S_UT = x"0000_04F0" report "Addition Registre + Valeur immediate incorrecte" severity error;
    

    -- Soustraction 2 Registres
    SIGNAL_Test_Bench_OP_1_Mux <= '0';
    SIGNAL_Test_Bench_Ra_UT <= "1000";
    SIGNAL_Test_Bench_Rb_UT <= "0011";
    SIGNAL_Test_Bench_Rw_UT <= "1000";
    SIGNAL_Test_Bench_OP_UAL_UT <= "010";  -- Y = A - B 
    wait for 22 ns;
    assert SIGNAL_Test_Bench_S_UT = x"0000_01EF" report "Soustraction 2 Registres incorrecte" severity error;

    -- Soustraction Valeur immediate + Registre 
    SIGNAL_Test_Bench_OP_1_Mux <= '1';
    SIGNAL_Test_Bench_Imm_UT <= x"0001";
    SIGNAL_Test_Bench_Ra_UT <= "0011";
    SIGNAL_Test_Bench_Rw_UT <= "0101";
    SIGNAL_Test_Bench_OP_UAL_UT <= "010";  -- Y = A - B 
    wait for 22 ns;
    assert SIGNAL_Test_Bench_S_UT = x"0000_0300" report "Soustraction Valeur immediate + Registre incorrecte" severity error;

-- Partie interne Memoir + Registre
    -- Copie Registre
    SIGNAL_Test_Bench_OP_UAL_UT <= "011";  -- Y = A
    SIGNAL_Test_Bench_Ra_UT <= "0101";
    SIGNAL_Test_Bench_Rw_UT <= "0110";
    wait for 22 ns;
    assert SIGNAL_Test_Bench_S_UT = x"0000_0300" report "Copie Registre incorrecte" severity error;

    -- Ecriture Registre to Memoire
    SIGNAL_Test_Bench_WrEN_UT <= '1'; -- Ecriture
    SIGNAL_Test_Bench_Addr_UT <= "000001";
    SIGNAL_Test_Bench_Rb_UT <= "0110";
    wait for 22 ns;
    SIGNAL_Test_Bench_WrEN_UT <= '1';
    assert SIGNAL_Test_Bench_S_UT = x"0000_0300" report "Ecriture Mot dans Memoire incorrecte" severity error;

    -- Lecture Mot to Registre
    SIGNAL_Test_Bench_Addr_UT <= "000001";
    SIGNAL_Test_Bench_Rw_UT <= "0111";
    wait for 32 ns;
    assert SIGNAL_Test_Bench_S_UT = x"0000_0300" report "Lecture Mot to Memory incorrecte" severity error;

    wait;
end process Test_bench_Unite_de_Traitement;
end test_bench_Unite_de_Traitement_architecture;
