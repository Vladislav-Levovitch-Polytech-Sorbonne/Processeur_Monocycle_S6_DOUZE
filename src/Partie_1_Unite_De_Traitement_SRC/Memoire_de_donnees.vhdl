library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Memoire_de_donnees_entity is
    port 
    (
        Clk_Memory : in std_logic;
        Rst_Memory : in std_logic;
        WE_Memory  : in std_logic;
        COM_Memrory: in std_logic; -- Signal de COMMANDE 1 bit

        Addr_Memory :  in std_logic_vector(5 downto 0);
        DataIn_A_Memory, DataIn_B_Memory: in std_logic_vector(31 downto 0);

        DataOut_Memory : out std_logic_vector(31 downto 0)
    );
end Memoire_de_donnees_entity;

architecture Memoire_architecture of Memoire_de_donnees_entity is

    type mem is array(64-1 downto 0) of std_logic_vector(31 downto 0);

-- Signal
signal DataIn_SIGNAL_Memory : std_logic_vector(31 downto 0);
signal Memory : mem := (others => (others => '0')); -- La memoire etant plus opaque que le Banc de Registre ici je trouve plus adaptee d utiliser le tableau (et je n etait pas fan cette fois d initialiser les 32 mots :)
-- Le tableau a le desavantage d etre plus opaque comme strucuture de donnee mais c est plus coherent avec le module ( memoire )

-- Content
begin

Memory_Writing_Process : process (Clk_Memory, Rst_Memory)
begin
    if Rst_Memory = '1' then -- Reset de la mémoire
        Memory <= (others => (others => '0'));
        DataOut_Memory <= (others => '0');
    elsif rising_edge(Clk_Memory) then
        if WE_Memory = '1' then
            if (COM_Memrory = '0') then
                Memory(to_integer(unsigned(Addr_Memory))) <= DataIn_A_Memory;  -- Entree A
            elsif (COM_Memrory = '1') then
                Memory(to_integer(unsigned(Addr_Memory))) <= DataIn_B_Memory;  -- Entree B
            end if;
        end if;
    end if;
end process Memory_Writing_Process;

Memory_Reading_Process : process (Clk_Memory)
begin
    if rising_edge(Clk_Memory) then
        DataOut_Memory <= Memory(to_integer(unsigned(Addr_Memory)));
    end if;
end process Memory_Reading_Process;

end Memoire_architecture;