library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Bascule_D_Simple_PC_entity is 
    
    port 
    (
        Bascule_D_Clk : in std_logic;
        Bascule_D_In : in std_logic_vector( 31 downto 0 );
        Bascule_D_Rst : in std_logic; -- Bit de RESET

        Bascule_D_Out : out std_logic_vector( 31 downto 0)
    );
end Bascule_D_Simple_PC_entity;

architecture Bascule_D_Simple_PC_architecture of Bascule_D_Simple_PC_entity is

-- Content
begin
    
process (Bascule_D_Clk,Bascule_D_Rst) -- Synchrone sinon ca perd son sens
begin   
    if (Bascule_D_Rst = '1') then
        Bascule_D_Out <= x"0000_0000";

    elsif (Bascule_D_Rst = '0') then
        if (rising_edge (Bascule_D_Clk)) then
            Bascule_D_Out <= Bascule_D_In;
        end if; 
    end if;
end process;
end Bascule_D_Simple_PC_architecture;