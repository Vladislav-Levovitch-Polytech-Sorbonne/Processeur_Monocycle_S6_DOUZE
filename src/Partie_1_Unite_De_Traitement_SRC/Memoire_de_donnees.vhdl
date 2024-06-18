library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Memoire_de_donnees_entity is
    port (
        Clk_Memory    : in std_logic;
        Rst_Memory    : in std_logic;
        WE_Memory     : in std_logic;
        COM_Memory    : in std_logic; -- Signal de COMMANDE 1 bit

        Addr_Memory   : in std_logic_vector(5 downto 0);
        DataIn_A_Memory : in std_logic_vector(31 downto 0);
        DataIn_B_Memory : in std_logic_vector(31 downto 0);

        DataOut_Memory : out std_logic_vector(31 downto 0)
    );
end Memoire_de_donnees_entity;

architecture Memoire_architecture of Memoire_de_donnees_entity is
-- Signal
    type mem is array(0 to 63) of std_logic_vector(31 downto 0);
    signal Memory : mem := (others => (others => '1')); -- La memoire etant plus opaque que le Banc de Registre ici je trouve plus adaptee d utiliser le tableau (et je n etait pas fan cette fois d initialiser les 32 mots :)
    -- Le tableau a le desavantage d etre plus opaque comme strucuture de donnee mais c est plus coherent avec le module ( memoire )

-- Content
begin
--Memory_Reading_Process : process (Addr_Memory)
--    begin
    DataOut_Memory <= Memory(to_integer(unsigned(Addr_Memory)));
--    end process Memory_Reading_Process;

Memory_Writing_Process : process (Clk_Memory,Rst_Memory) -- Reset asynchrone
    begin
        if Rst_Memory = '0' then
            if rising_edge(Clk_Memory) then
                if WE_Memory = '1' then -- Sucre syntaxique pour la lisibilite
                    -- Local Mux
                    case COM_Memory is
                        when '0' => Memory(to_integer(unsigned(Addr_Memory))) <= DataIn_A_Memory;
                        when '1' => Memory(to_integer(unsigned(Addr_Memory))) <= DataIn_B_Memory;
                        when others => null; -- Par securite meme si ne devrait pas arriver 
                    end case;
                end if;
            end if;
        elsif Rst_Memory = '1' then
            -- Redemarrage de la memoire
            for i in 64-1 downto 0 loop
                Memory(i) <= (others => '0');
            end loop;
        end if;
    end process Memory_Writing_Process;
end Memoire_architecture;
