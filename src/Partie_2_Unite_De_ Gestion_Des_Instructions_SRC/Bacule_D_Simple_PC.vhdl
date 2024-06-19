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
    if (Bascule_D_Rst = '0') then
        S_SIGNAL_mux <= Bascule_D_A;

    elsif (Bascule_D_Rst = '1') then
        S_SIGNAL_mux <= Bascule_D_B;

    end if;
end process;
end Bascule_D_Simple_PC_architecture;