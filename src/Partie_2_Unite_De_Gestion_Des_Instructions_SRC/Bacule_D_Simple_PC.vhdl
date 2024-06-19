library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Mux_2_to_1_N_Bits_entity is
    generic ( Mux_N : integer := 32 );
    port (
        Mux_A, Mux_B : in std_logic_vector( Mux_N-1 downto 0 );
        Mux_COM : in std_logic;
        Mux_S : out std_logic_vector( Mux_N-1 downto 0)
    );
end Mux_2_to_1_N_Bits_entity;

architecture mux_architecture of Mux_2_to_1_N_Bits_entity is
begin
    process (Mux_A, Mux_B, Mux_COM)
    begin
        if (Mux_COM = '0') then
            Mux_S <= Mux_A;
        else
            Mux_S <= Mux_B;
        end if;
    end process;
end mux_architecture;
