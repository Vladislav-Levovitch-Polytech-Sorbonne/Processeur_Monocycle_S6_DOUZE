library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity test_bench_Extensionneur_entity is
    generic( N_Ext : integer := 16 ); -- Prevision concatenation 16 + 16
end test_bench_Extensionneur_entity;

architecture test_bench_Extensionneur_architecture of test_bench_Extensionneur_entity is

-- Signal
    -- Entrees
    signal SIGNAL_Test_Bench_E_Ext : std_logic_vector (N_Ext-1 downto 0) := (others => '0');
    
	-- Sorties
    signal SIGNAL_Test_Bench_S_Ext : std_logic_vector (31 downto 0) := x"0000_0000"; -- Bit de resultat extendu

-- Content
begin 

UUT_Extension_de_Signe : entity work.Extension_de_Signe_entity

	port map 
	(
		E_Ext => SIGNAL_Test_Bench_E_Ext, 

		S_Ext => SIGNAL_Test_Bench_S_Ext
	);

Test_bench_Extension_de_Signe : process 
    begin        
        wait for 1 ns;
        
        -- Verification Simple positif
        SIGNAL_Test_Bench_E_Ext <= x"0011";
        wait for 1 ns;
        assert SIGNAL_Test_Bench_S_Ext = x"0000_0011" report "Test + incorrect" severity error;
        wait for 4 ns;

        -- Verification Simple nul
        SIGNAL_Test_Bench_E_Ext <= x"0000";
        wait for 1 ns;
        assert SIGNAL_Test_Bench_S_Ext = x"0000_0000" report "Test 0 incorrect" severity failure;
        wait for 4 ns;

        -- Verification Simple negatif apres positif
        SIGNAL_Test_Bench_E_Ext <= x"FF21";
        wait for 1 ns;
        assert SIGNAL_Test_Bench_S_Ext = x"FFFF_FF21" report "Test - incorrect" severity failure;
        wait for 4 ns;

        -- Verification negatif a la suite
        SIGNAL_Test_Bench_E_Ext <= x"8321";
        wait for 1 ns;
        assert SIGNAL_Test_Bench_S_Ext = x"FFFF_8321" report "Test - incorrect" severity failure;
        wait for 4 ns;

        -- Verification reprise positif apres negatif
        SIGNAL_Test_Bench_E_Ext <= x"3002";
        wait for 1 ns;
        assert SIGNAL_Test_Bench_S_Ext = x"0000_3002" report "Test - incorrect" severity failure;
        wait for 4 ns;

        wait;
    end process Test_bench_Extension_de_Signe;   
end test_bench_Extensionneur_architecture;
