library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Additionneur_2_Entrees_entity is
    port 
    (
        Add_E_A, Add_E_B : in std_logic_vector( 31 downto 0 );

        Add_S_A, Add_S_B : out std_logic_vector( 31 downto 0)
    );
end Additionneur_2_Entrees_entity;

architecture Additionneur_2_Entrees_architecture of Additionneur_2_Entrees_entity is

-- Signal
signal SIGNAL_Add_Stockage : std_logic_vector( 31 downto 0) := (others => '0');

-- Content
begin
process (Add_E_A,Add_E_B) -- Combinatoire toute entree dans la liste de sensibilite
begin   
    SIGNAL_Add_Stockage <= std_logic_vector((unsigned(Add_E_A) + 1) mod 64);
    Add_S_A <= SIGNAL_Add_Stockage; -- PC += 1
    Add_S_B <= std_logic_vector((unsigned(SIGNAL_Add_Stockage) + unsigned(Add_E_B)) mod 64); -- PC+1 += Offset
end process;
end Additionneur_2_Entrees_architecture;