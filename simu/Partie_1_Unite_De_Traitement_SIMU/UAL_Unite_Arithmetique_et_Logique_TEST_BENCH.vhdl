use std.textio.all; -- Par Monsieur DOUZE Yann 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use IEEE.std_logic_unsigned.ALL;

entity test_bench_UAL_Unite_Arithmetique_et_Logique_entity is
    
end test_bench_UAL_Unite_Arithmetique_et_Logique_entity;

architecture test_bench_UAL_architecture of test_bench_UAL_Unite_Arithmetique_et_Logique_entity is
	
	-- Entrees
	signal SIGNAL_Test_Bench_OP_UAL  : std_logic_vector(2 downto 0) := "000"; -- Signal de commande sur 3 bits
    signal SIGNAL_Test_Bench_A_UAL,SIGNAL_Test_Bench_B_UAL : std_logic_vector(31 downto 0) := (others => '0');
	
    -- Sorties
	signal SIGNAL_Test_Bench_S_UAL   : std_logic_vector(31 downto 0) := x"0000_0000";
    signal SIGNAL_Test_Bench_N_UAL,SIGNAL_Test_Bench_Z_UAL, SIGNAL_Test_Bench_C_UAL,SIGNAL_Test_Bench_V_UAL : std_logic :='0'; -- Drapeaux

begin 
	uut_UAL : entity work.UAL_Unite_Arithmetique_et_Logique_entity
        port map 
		(
            OP_UAL=> SIGNAL_Test_Bench_OP_UAL,
            A_UAL => SIGNAL_Test_Bench_A_UAL,
            B_UAL => SIGNAL_Test_Bench_B_UAL,
            S_UAL => SIGNAL_Test_Bench_S_UAL,
            N_UAL => SIGNAL_Test_Bench_N_UAL,
            Z_UAL => SIGNAL_Test_Bench_Z_UAL,
            C_UAL => SIGNAL_Test_Bench_C_UAL,
            V_UAL => SIGNAL_Test_Bench_V_UAL
        );

Test_bench_UAL : process 
	
	variable L : line;
	
    begin

        -- Boucle pour les valeurs d'OP
        for i in 0 to 7 loop
            SIGNAL_Test_Bench_OP_UAL <= std_logic_vector(to_unsigned(i, 3));  
            wait for 160 ns;
			
			for N in 0 to 1 loop
				
				-- Re demarrage de A et B
				SIGNAL_Test_Bench_A_UAL <= (others => '0');
				SIGNAL_Test_Bench_B_UAL <= (others => '0');
				SIGNAL_Test_Bench_A_UAL(31) <= not SIGNAL_Test_Bench_A_UAL(31);
				SIGNAL_Test_Bench_B_UAL(31) <= not SIGNAL_Test_Bench_B_UAL(31);
				
				-- Boucle A
				for ii in 0 to 7 loop
					SIGNAL_Test_Bench_A_UAL(ii*4) <= '1'; 
					--report "Test : A = " & to_string(SIGNAL_Test_Bench_S_UAL);
					write (L, lf & "Test : A =");
					write (L, to_integer(unsigned(SIGNAL_Test_Bench_S_UAL)));
					wait for 10 ns;
				end loop;
				
				wait for 80 ns;
				
				-- Boucle B
				for iii in 0 to 7 loop
					SIGNAL_Test_Bench_B_UAL(iii*4) <= '1'; 
					--report "Test : B = " & to_string(SIGNAL_Test_Bench_S_UAL);					
					wait for 10 ns; 
				end loop;
				
				wait for 80 ns;
				
            end loop;
        end loop;
        
        wait;  -- Attendre la fin de la simulation
    end process Test_bench_UAL;   
	
end test_bench_UAL_architecture;