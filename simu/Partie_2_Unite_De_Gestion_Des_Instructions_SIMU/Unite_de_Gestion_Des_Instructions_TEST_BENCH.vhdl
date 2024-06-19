library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity TEST_BENCH_Unite_de_Gestion_Des_Instructions_entity is
end TEST_BENCH_Unite_de_Gestion_Des_Instructions_entity;

architecture TEST_BENCH_Unite_de_Gestion_Des_Instructions_architecture of TEST_BENCH_Unite_de_Gestion_Des_Instructions_entity is

-- Signal
    -- Entrees
    signal SIGNAL_Clk_UGI, SIGNAL_Rst_R_UGI, SIGNAL_nPCsel_UGI : std_logic := '0';
    signal SIGNAL_Offset_UGI : std_logic_vector(23 downto 0):= (others => '0');

    -- Sortie
    signal SIGNAL_Instruction_UGI : std_logic_vector(31 downto 0):= (others => '0');

-- Content
begin

UUT_Unite_de_Gestion_Des_Instructions : entity work.Unite_de_Gestion_Des_Instructions_entity
    port map
    (
        Clk_UGI => SIGNAL_Clk_UGI,
        Rst_R_UGI => SIGNAL_Rst_R_UGI,
        nPCsel_UGI  => SIGNAL_nPCsel_UGI,
        Offset_UGI => SIGNAL_Offset_UGI,

        Instruction_UGI => SIGNAL_Instruction_UGI
    );

UUT_LA_HORLOGE : entity work.Tic_Tac_entity -- Horloge
    port map
    (
        THE_Clk => SIGNAL_Clk_UGI
    );

Test_bench_Unite_de_Gestion_Des_Instructions : process
    begin
        wait for 1 ns;
        SIGNAL_Rst_R_UGI <= '1';
        wait for 1 ns;
        SIGNAL_Rst_R_UGI <= '0';
        wait for 47 ns;

        SIGNAL_nPCsel_UGI <= '1';
        wait for 2 ns;
        SIGNAL_Offset_UGI <= x"00_0003";
        wait for 10 ns;
        SIGNAL_Offset_UGI <= x"00_0012";
        SIGNAL_Rst_R_UGI <= '1';    
        wait for 1 ns;
        SIGNAL_Rst_R_UGI <= '0';
        wait for 1 ns;
        SIGNAL_nPCsel_UGI <= '0';
        wait for 2 ns;


        wait;
    end process;
end TEST_BENCH_Unite_de_Gestion_Des_Instructions_architecture;
