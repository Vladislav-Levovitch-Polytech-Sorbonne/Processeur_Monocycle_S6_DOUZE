library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Mux_2_to_1_N_Bits_entity is
    
    generic( Mux_N : integer := 4); -- Prevision selection offset ou addresse a choisir sur 4 bits

    port 
    (
        Mux_A, Mux_B : in std_logic_vector( Mux_N-1 downto 0 );
        Mux_COM : in std_logic; -- Signal de COMMANDE 3 bits

        Mux_S : out std_logic_vector( Mux_N-1 downto 0)
    );
end Mux_2_to_1_N_Bits_entity;

architecture mux_architecture of Mux_2_to_1_N_Bits_entity is

-- Signal
signal S_SIGNAL_mux : std_logic_vector(31 downto 0) := (others => '0');

-- Content
begin
    -- Initialisation par defaut des sorties
    Mux_S <= (others => '0');

process (Mux_A,Mux_B,Mux_COM) -- Combinatoire toute entree dans la liste de sensibilite
begin   
    if (Mux_COM = '1') 
        S_SIGNAL_mux <= Mux_A;

    elsif (Mux_COM = '0') 
        S_SIGNAL_mux <= Mux_B;

    end if;
    Mux_S <= S_SIGNAL_mux;
end process;
end mux_architecture;