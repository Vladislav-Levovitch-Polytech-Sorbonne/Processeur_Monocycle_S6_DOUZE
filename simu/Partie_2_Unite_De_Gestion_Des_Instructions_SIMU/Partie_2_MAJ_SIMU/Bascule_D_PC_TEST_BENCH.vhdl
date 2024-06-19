library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity test_bench_Bascule_D_Simple_PC_entity is
end test_bench_Bascule_D_Simple_PC_entity;

architecture test_bench_Bascule_D_Simple_PC_architecture of test_bench_Bascule_D_Simple_PC_entity is

-- Signals
	-- Entree
	signal SIGNAL_Test_Bench_PC_Clk : std_logic := '0';
	signal SIGNAL_Test_Bench_PC_Rst : std_logic := '0';
	signal SIGNAL_Test_Bench_PC_In  : std_logic_vector(31 downto 0) := (others => '0');

	-- Sortie
	signal SIGNAL_Test_Bench_PC_Out : std_logic_vector(31 downto 0) := (others => '0');

-- Content
begin

Bascule_D_Simple_PC : entity work.Bascule_D_Simple_PC_entity
	port map 
	(
		Bascule_D_Clk => SIGNAL_Test_Bench_PC_Clk,
		Bascule_D_In  => SIGNAL_Test_Bench_PC_In,
		Bascule_D_Rst => SIGNAL_Test_Bench_PC_Rst,
		Bascule_D_Out => SIGNAL_Test_Bench_PC_Out
	);

-- Clock process
UUT_TIC_TAC : entity work.Tic_Tac_entity
	port map 
	(
		THE_Clk => SIGNAL_Test_Bench_PC_Clk
	);

process
begin

	SIGNAL_Test_Bench_PC_Rst <= '0';
	SIGNAL_Test_Bench_PC_In <= x"1234_5678"; 
	wait for 12 ns;

	SIGNAL_Test_Bench_PC_Rst <= '1';

	wait for 12 ns;

	SIGNAL_Test_Bench_PC_Rst <= '0';
	SIGNAL_Test_Bench_PC_In <= x"87654321";
	wait for 12 ns;

	SIGNAL_Test_Bench_PC_Rst <= '1';
	wait for 12 ns;

	SIGNAL_Test_Bench_PC_Rst <= '0';
	SIGNAL_Test_Bench_PC_In <= x"ABCD_EFAB"; 
	wait for 12 ns;
	wait;

end process;
end test_bench_Bascule_D_Simple_PC_architecture;
