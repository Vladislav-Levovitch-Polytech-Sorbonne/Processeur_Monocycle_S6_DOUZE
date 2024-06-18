library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Extension_de_Signe_entity is

    generic( N_Ext : integer := 16 ); -- Prevision concatenation 16 + 16

    port 
    (
        E_Ext  : in std_logic_vector(N_Ext-1 downto 0);
        -- N_Ext : in integer range 0 to 32; -- Approche stylé aussi

        S_Ext : out std_logic_vector(31 downto 0)
    );
end Extension_de_Signe_entity;

architecture Extension_de_Signe_entity_architecture of Extension_de_Signe_entity is

-- Signal
signal S_SIGNAL_Ext : std_logic_vector((31-N_Ext) downto 0) := (others => '1');

-- Content
begin
    -- Initialisation
process (E_Ext) -- Combinatoire simple
begin
    S_Ext <= S_SIGNAL_Ext & E_Ext;
    if (E_Ext(N_Ext-1) = '1') then
        S_Ext(32-1 downto N_Ext-1) <= (others => '1');

    elsif (E_Ext(N_Ext-1) = '0') then
        S_SIGNAL_Ext <= (others => '0');
    end if;
end process;
end architecture Extension_de_Signe_entity_architecture;