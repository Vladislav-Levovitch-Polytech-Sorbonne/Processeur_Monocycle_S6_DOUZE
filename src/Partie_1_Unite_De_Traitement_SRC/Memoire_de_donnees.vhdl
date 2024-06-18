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

-- Signal
signal DataIn_SIGNAL_Memory : std_logic_vector(31 downto 0) := (others => '0');

-- Content
begin
    
    S_UAL <= S_SIGNAL_UAL;

    process (COM_Memrory) -- Combinatoire lecture   -- Je ne suis pas sur qu un petit if Enable n aurait pas ete de trop
        case COM_Memrory is 
            when '0' => DataIn_SIGNAL_Memory  <= DataIn_A_Memory;  -- Entree A
            when '1' => DataIn_SIGNAL_Memory  <= DataIn_B_Memory;  -- Entree B
            when others => DataIn_SIGNAL_Memory  <= (others => '0');   -- Dans le doute mais ne doit pas arriver
        end case;
    begin

Memory_Process : process (A_UAL,B_UAL,OP_UAL,S_SIGNAL_UAL) -- Combinatoire toute sortie dans la liste de sensibilite
    
        type table is array(15 downto 0) of std_logic_vector(31 downto 0);
        alias banc_tb : table is <<signal .UUT.I_banc_de_registre.Banc : table>>;
    begin
begin
    -- Initialisation par defaut des sorties N, Z, C et V
    N_UAL <= '0';
    Z_UAL <= '0';
    C_UAL <= '0';
    V_UAL <= '0';

    
    
end process Memory_Process;
end Memoire_architecture;