library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Unite_de_Traitement_entity is
    port 
    (
        Clk_UT, Rst_UT, WE_UT, WrEN_UT : in std_logic;

        Ra_UT, Rb_UT, Rw_UT : in std_logic_vector(3 downto 0);

        OP_UAL_UT  : in std_logic_vector(2 downto 0); -- Signal de COMMANDE 3 bits
        OP_1_Mux, OP_2_Mux : in std_logic; -- Signal de COMMANDE 1 bits

        S_UT : out std_logic_vector(31 downto 0); -- Variable copie en sortie
        N_UT, Z_UT, C_UT, V_UT : out std_logic -- Drapeaux
    );
end Unite_de_Traitement_entity;

architecture Unite_de_Traitement_architecture of Unite_de_Traitement_entity is

-- Signal

    signal A_SIGNAL_UT : std_logic_vector(31 downto 0) := (others => '0'); -- Sortie Registre to UAL
    signal B_SIGNAL_UT : std_logic_vector(31 downto 0) := (others => '0'); -- Sortie Registre to Mux + Memoire 
    signal W_SIGNAL_UT : std_logic_vector(31 downto 0) := (others => '0'); -- Sortie MuxBis depuis UAL to rebouclage Registre + Copie S

-- Content
begin

    UUT_Banc_de_Registre : entity work.Banc_de_Registre_entity
        port map
        (
            Clk_BR => Clk_UT,
            Rst_BR => Rst_UT,
            WE_BR  => WE_UT,

            Ra_BR => Ra_UT,
            Rb_BR => Rb_UT,
            Rw_BR => Rw_UT,
            W_BR  => W_SIGNAL_UT,

            A_BR => A_SIGNAL_UT,
            B_BR => B_SIGNAL_UT
        );

    UUT_UAL : entity work.UAL_Unite_Arithmetique_et_Logique_entity
        port map
        (
            OP_UAL => OP_UT,
            A_UAL => A_SIGNAL_UT,
            B_UAL => B_SIGNAL_UT,
            S_UAL => W_SIGNAL_UT,
            N_UAL => N_UT,
            Z_UAL => Z_UT,
            C_UAL => C_UT,
            V_UAL => V_UT
        );

    UUT_Extension_de_Signe : entity work.Extension_de_Signe
        port map
        (
            E_Ext => ,

            S_Ext => 
        );

    UUT_Memoire_de_donnees : entity work.Memoire_de_donnees
        port map
        (
            Clk_Memory => Clk_UT,
            Rst_Memory => 
            WE_Memory => 
            COM_Memory => 

            Addr_Memory =>
            DataIn_A_Memory =>
            DataIn_B_Memory =>

            DataOut_Memory =>
        );

    UUT_Mux : entity

-- Maj S et Memoire
    process (Clk_UT)
    begin
        if rising_edge(Clk_UT) then
            S_UT <= W_SIGNAL_UT; -- Copie de S pour etre visible sur le chronogramme
        end if;
    end process;

end Unite_de_Traitement_architecture;
