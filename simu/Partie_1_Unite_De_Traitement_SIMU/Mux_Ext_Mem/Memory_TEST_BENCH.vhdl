library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity test_bench_Memory_entity is
end test_bench_Memory_entity;

architecture test_bench_Memory_architecture of test_bench_Memory_entity is

-- Signal
    -- Entrees
    signal SIGNAL_Test_Bench_Clk_Memory, SIGNAL_Test_Bench_Rst_Memory, SIGNAL_Test_Bench_WE_Memory, SIGNAL_Test_Bench_COM_Memory : std_logic := '0';
    signal SIGNAL_Test_Bench_Addr_Memory : std_logic_vector(5 downto 0) := (others => '0');
    signal SIGNAL_Test_Bench_DataIn_A_Memory, SIGNAL_Test_Bench_DataIn_B_Memory : std_logic_vector(31 downto 0) := (others => '0');

	-- Sorties
    signal SIGNAL_Test_Bench_DataOut_Memory : std_logic_vector(31 downto 0);

-- Content
begin
UUT_TIK_TAK : entity work.Tic_Tac_entity
    port map 
    (
        THE_Clk => SIGNAL_Test_Bench_Clk_Memory
    );

UUT_Memoire_de_donnees : entity work.Memoire_de_donnees_entity
    port map 
    (
        Clk_Memory => SIGNAL_Test_Bench_Clk_Memory,
        Rst_Memory => SIGNAL_Test_Bench_Rst_Memory,
        WE_Memory  => SIGNAL_Test_Bench_WE_Memory,
        COM_Memory => SIGNAL_Test_Bench_COM_Memory,
        Addr_Memory => SIGNAL_Test_Bench_Addr_Memory,
        DataIn_A_Memory => SIGNAL_Test_Bench_DataIn_A_Memory,
        DataIn_B_Memory => SIGNAL_Test_Bench_DataIn_B_Memory,
        DataOut_Memory => SIGNAL_Test_Bench_DataOut_Memory
    );

Test_bench_Memory : process
    begin
        
        -- Test en vrac

        wait for 1 ns;
        --SIGNAL_Test_Bench_Rst_Memory <= '1';
        wait for 1 ns;
        SIGNAL_Test_Bench_Rst_Memory <= '0';
        wait for 1 ns;
        SIGNAL_Test_Bench_DataIn_B_Memory <= x"02402010";
        SIGNAL_Test_Bench_WE_Memory <= '1';
        SIGNAL_Test_Bench_DataIn_A_Memory <= x"00402010";
        SIGNAL_Test_Bench_Addr_Memory <= "001010"; -- Addresse 10
        wait for 1 ns;
    
        SIGNAL_Test_Bench_Addr_Memory <= "001000"; -- Adresse 8
        SIGNAL_Test_Bench_COM_Memory <= '0'; -- Entree A
        wait for 1 ns;
        
        wait for 1 ns;
    
        SIGNAL_Test_Bench_WE_Memory <= '1';
        SIGNAL_Test_Bench_DataIn_B_Memory <= x"00804020";
        wait for 1 ns;
        SIGNAL_Test_Bench_WE_Memory <= '0';
        wait for 1 ns;
    
        SIGNAL_Test_Bench_Addr_Memory <= "001110"; -- Adresse au 14
        SIGNAL_Test_Bench_COM_Memory <= '1';
        wait for 5 ns;
        SIGNAL_Test_Bench_Addr_Memory <= "001011"; -- Adresse 11

        -- Test reset
        assert SIGNAL_Test_Bench_DataOut_Memory = x"FFFF_FFFF" report "Test valeurs blanches" severity failure;
        SIGNAL_Test_Bench_Rst_Memory <= '1';
        wait for 4 ns;
        SIGNAL_Test_Bench_Rst_Memory <= '0';
        SIGNAL_Test_Bench_WE_Memory <= '1';
        
        -- Test post reset et initialialisation des valeurs a 0
        SIGNAL_Test_Bench_Addr_Memory <= "001011"; -- Adresse 11
        SIGNAL_Test_Bench_DataIn_B_Memory <= x"0200_0010"; -- Current selection
        SIGNAL_Test_Bench_DataIn_A_Memory <= x"0503_0000";
        assert SIGNAL_Test_Bench_DataOut_Memory = x"0000_0000" report "Test initialisation avant ecriture" severity failure; -- Valeur pas encore ecrite => post initialisation toutes les valeurs sont remises a 0
        wait for 12 ns;

        -- Test changement registre et conservation memoire
        assert SIGNAL_Test_Bench_DataOut_Memory = x"0200_0010" report "Test lecture post reset" severity failure;
        SIGNAL_Test_Bench_COM_Memory <= '0'; -- Selection valeurs de A
        SIGNAL_Test_Bench_Addr_Memory <= "001000"; -- Adresse 8 nouvellement pour A
        wait for 11 ns;
        assert SIGNAL_Test_Bench_DataOut_Memory = x"0503_0000" report "Test lecture memoir" severity failure;
        SIGNAL_Test_Bench_Addr_Memory <= "001011"; -- Adresse 11 precedemment ecrite par B
        assert SIGNAL_Test_Bench_DataOut_Memory = x"0200_0010" report "Test lecture post reset" severity failure;
        
        wait;
    end process Test_bench_Memory;
end test_bench_Memory_architecture;
