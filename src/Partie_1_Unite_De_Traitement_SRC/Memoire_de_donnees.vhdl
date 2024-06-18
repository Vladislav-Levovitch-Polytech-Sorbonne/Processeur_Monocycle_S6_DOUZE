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
signal DataIn_SIGNAL_Memory : std_logic_vector(31 downto 0) := (others => '0');
signal Memory : mem := (others => (others => '0')); -- La memoire etant plus opaque que le Banc de Registre ici je trouve plus adaptee d utiliser le tableau (et je n etait pas fan cette fois d initialiser les 32 mots :)
-- Le tableau a le desavantage d etre plus opaque comme strucuture de donnee mais c est plus coherent avec le module ( memoire )

-- Content
begin

Memory_Local_Mux_Process : process (COM_Memrory, DataIn_A_Memory, DataIn_B_Memory) -- Combinatoire assignation
    begin 
        case COM_Memrory is 
            when '0' => DataIn_SIGNAL_Memory  <= DataIn_A_Memory;  -- Entree A
            when '1' => DataIn_SIGNAL_Memory  <= DataIn_B_Memory;  -- Entree B
            when others => DataIn_SIGNAL_Memory  <= (others => '0');   -- Dans le doute mais ne doit pas arriver
        end case;
    end process Memory_Local_Mux_Process;

Memory_Reading_Process : process (Addr_Memory, Memory) -- Pas sur que Memory doit etre dans la liste de sensibilite mais dans le cas ou on reecrit sur le registre sans changer l adresse ...
    begin 
        DataOut_Memory <= (Memory(to_integer(unsigned(Addr_Memory)))); -- Selection du Addr_Memory_ieme vecteur
    end process Memory_Reading_Process;

Memory_Writing_Process : process (Clk_Memory, Rst_Memory) -- Synchrone
    begin
        if Rst_Memory = '1' then -- Verification si redemarrage memoire
            for i in 63 downto 0 loop
                Memory(i) <= (others => '0');
            end loop;
            DataOut_Memory <= (others => '0');

        elsif (Rst_Memory = '0') then
            if rising_edge(Clk_Memory) then
                if WE_Memory = '1' then
                    Memory(to_integer(unsigned(Addr_Memory))) <= DataIn_SIGNAL_Memory;
                end if;
            end if;
        end if;
    end process Memory_Writing_Process;
end Memoire_architecture;