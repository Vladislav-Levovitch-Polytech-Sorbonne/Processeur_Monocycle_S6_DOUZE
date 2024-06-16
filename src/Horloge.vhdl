library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
-- use IEEE.std_logic_unsigned.ALL;

entity Tic_Tac_entity is
    port 
    (
        THE_Clk : out std_logic
    );
end Tic_Tac_entity;

architecture Tic_Tac_architecture of Tic_Tac_entity is

-- Signal et Cst
    signal SIGNAL_Clk : std_logic := '0';
    constant Clk_PERIOD : time := 10 ns;  -- Double de periode up, utile horloge

-- Content
begin

    THE_Clk <= SIGNAL_Clk;
    
    Clk_process : process
    begin
        while True loop -- Convention proposee par ChatGPT

            SIGNAL_Clk <= '0';
            wait for Clk_PERIOD / 2;

            SIGNAL_Clk <= '1';
            wait for Clk_PERIOD / 2;
            
        end loop;
    end process Clk_process;
end Tic_Tac_architecture;
