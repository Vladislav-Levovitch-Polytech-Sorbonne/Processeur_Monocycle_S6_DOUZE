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
        COM_Memrory => SIGNAL_Test_Bench_COM_Memory,
        Addr_Memory => SIGNAL_Test_Bench_Addr_Memory,
        DataIn_A_Memory => SIGNAL_Test_Bench_DataIn_A_Memory,
        DataIn_B_Memory => SIGNAL_Test_Bench_DataIn_B_Memory,
        DataOut_Memory => SIGNAL_Test_Bench_DataOut_Memory
    );

Test_bench_Memory : process
    begin
        wait for 1 ns;
        SIGNAL_Test_Bench_Rst_Memory <= '1';
        wait for 1 ns;
        SIGNAL_Test_Bench_Rst_Memory <= '0';
        wait for 1 ns;
        SIGNAL_Test_Bench_DataIn_B_Memory <= x"02402010";
        SIGNAL_Test_Bench_WE_Memory <= '1';
        SIGNAL_Test_Bench_DataIn_A_Memory <= x"00402010";
        SIGNAL_Test_Bench_Addr_Memory <= "001010"; -- Addresse 10
        wait for 1 ns;
    
        -- 
        SIGNAL_Test_Bench_Addr_Memory <= "001011"; -- Addresse 11
        SIGNAL_Test_Bench_COM_Memory <= '0'; -- Entree A
        wait for 1 ns;
        
        assert SIGNAL_Test_Bench_DataOut_Memory = x"00402010" report "Test 1 faile" severity error;
        wait for 1 ns;
    
        SIGNAL_Test_Bench_WE_Memory <= '1';
        SIGNAL_Test_Bench_DataIn_B_Memory <= x"00804020";
        wait for 1 ns;
        SIGNAL_Test_Bench_WE_Memory <= '0';
        wait for 1 ns;
    
        SIGNAL_Test_Bench_Addr_Memory <= "001110";
        SIGNAL_Test_Bench_COM_Memory <= '1';
        wait for 1 ns;
        
        assert SIGNAL_Test_Bench_DataOut_Memory = x"00804020" report "Test 2 faile" severity error;
        wait for 22 ns;
        wait;
    end process Test_bench_Memory;
end test_bench_Memory_architecture;
