library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity test_bench_multiplexeur_entity is
    generic( Mux_N : integer := 4); -- Prevision selection offset ou addresse a choisir sur 4 bits
end test_bench_multiplexeur_entity;

architecture test_bench_multiplexeur_architecture of test_bench_multiplexeur_entity is

-- Signal
    -- Entrees
    signal SIGNAL_Test_Bench_Mux_A, SIGNAL_Test_Bench_Mux_B : std_logic_vector (Mux_N-1 downto 0) := (others => '0');
    signal SIGNAL_Test_Bench_Mux_COM : std_logic := '0'; -- Signal de COMMANDE 1 bit

	-- Sorties
    signal SIGNAL_Test_Bench_Mux_S : std_logic_vector (Mux_N-1 downto 0) := (others => '0'); -- Bit de resultat extendu

-- Content
begin 

UUT_Multiplexeur : entity work.Mux_2_to_1_N_Bits_entity

	port map 
	(
        Mux_A => SIGNAL_Test_Bench_Mux_A,
        Mux_B => SIGNAL_Test_Bench_Mux_B, 
        Mux_COM => SIGNAL_Test_Bench_Mux_COM,

        Mux_S => SIGNAL_Test_Bench_Mux_S
	);

Test_bench_multiplexeur : process 
    begin        
        wait for 1 ns;
        
        -- Verification A
        SIGNAL_Test_Bench_Mux_A <= "1010";
        wait for 1 ns;
        assert SIGNAL_Test_Bench_Mux_S = x"A" report "Test A incorrect" severity error;
        wait for 4 ns;

        -- Verification B
        SIGNAL_Test_Bench_Mux_B <= "1011";
        SIGNAL_Test_Bench_Mux_COM <= '1';
        wait for 1 ns;
        assert SIGNAL_Test_Bench_Mux_S = x"B" report "Test B incorrect" severity error;
        wait for 4 ns;

        -- Verification B
        SIGNAL_Test_Bench_Mux_A <= "1111";
        wait for 1 ns;
        assert SIGNAL_Test_Bench_Mux_S = x"B" report "Test A sans F incorrect" severity error;
        wait for 4 ns;

        wait;
    end process Test_bench_multiplexeur;   
end test_bench_multiplexeur_architecture;
