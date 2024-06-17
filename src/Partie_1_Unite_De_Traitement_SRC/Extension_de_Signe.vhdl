library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Extension_de_Signe_entity is

    generic( N_Ext : integer := 16 ); -- Prevision concatenation 16 + 16

    port 
    (
        E_Ext  : in std_logic_vector(N_Ext-1 downto 0);

        S_Ext : out std_logic_vector(31 downto 0);
    );
end Extension_de_Signe_entity;

architecture Extension_de_Signe_entity_architecture of Extension_de_Signe_entity is

-- Signal
signal S_SIGNAL_Ext : std_logic_vector(31-(N_Ext) downto 0) := (others => '0');

-- Content
begin
    -- Initialisation
    S_Ext <= (others => '0');

process (S_SIGNAL_Ext) -- Combinatoire simple
begin

    if (E_Ext(N_Ext-1) = '1') 
        S_SIGNAL_mux <= (others => '1');
    end if;

    S_Ext <= S_SIGNAL_Ext & E_Ext;
end process;
end architecture Extension_de_Signe_entity_architecture;