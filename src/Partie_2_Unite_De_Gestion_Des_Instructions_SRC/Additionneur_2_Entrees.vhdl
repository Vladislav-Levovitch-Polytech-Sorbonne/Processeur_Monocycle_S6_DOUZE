library IEEE; -- Restructuration code pour eviter les drapeaux jaunes voir github la version d avant fonctionnait aussi
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Additionneur_2_Entrees_entity is
    port 
    (
        Add_E_A, Add_E_B : in std_logic_vector(31 downto 0);

        Add_S_A, Add_S_B : out std_logic_vector(31 downto 0)
    );
end Additionneur_2_Entrees_entity;

architecture Additionneur_2_Entrees_architecture of Additionneur_2_Entrees_entity is

    signal SIGNAL_Add_Stockage : std_logic_vector(31 downto 0) := (others => '0');

begin
    process (Add_E_A, Add_E_B)

        variable variable_A, variable_B : unsigned(31 downto 0);
        variable result_A, result_B : unsigned(31 downto 0);

    begin
        -- Add_E_A + 1 modulo 64
        variable_A := unsigned(Add_E_A) + 1;
        result_A := variable_A mod 64;
        SIGNAL_Add_Stockage <= std_logic_vector(result_A);
        Add_S_A <= std_logic_vector(result_A);  -- PC += 1
        
        -- (PC + 1) + Add_E_B modulo 64
        variable_B := unsigned(SIGNAL_Add_Stockage) + unsigned(Add_E_B);
        result_B := variable_B mod 64;
        Add_S_B <= std_logic_vector(result_B);  -- PC+1 += Offset
    end process;
end Additionneur_2_Entrees_architecture;
