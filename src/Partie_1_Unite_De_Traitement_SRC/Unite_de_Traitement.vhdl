library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Unite_de_Traitement_entity is
    port 
    (
        Clk_UT, Rst_R_UT, Rst_M_UT, WE_UT, WrEN_UT : in std_logic;

        Ra_UT, Rb_UT, Rw_UT : in std_logic_vector(3 downto 0);
        Addr_UT : in std_logic_vector(5 downto 0);

        OP_UAL_UT  : in std_logic_vector(2 downto 0); -- Signal de COMMANDE 3 bits
        OP_1_Mux, OP_2_Mux, COM_Memory : in std_logic; -- Signal de COMMANDE 1 bits
        Imm_UT  : in std_logic_vector(15 downto 0);

        S_UT : out std_logic_vector(31 downto 0); -- Variable copie pour sortie
        N_UT, Z_UT, C_UT, V_UT : out std_logic -- Drapeaux
    );
end Unite_de_Traitement_entity;

architecture Unite_de_Traitement_architecture of Unite_de_Traitement_entity is

-- Signal

    signal SIGNAL_A_UT : std_logic_vector(31 downto 0) := (others => '1'); -- Sortie Registre to UAL
    signal SIGNAL_B_UT : std_logic_vector(31 downto 0) := (others => '1'); -- Sortie Registre to Mux + Memoire 
    signal SIGNAL_B_Mux_1_UT : std_logic_vector(31 downto 0) := (others => '1'); -- Sortie Mux to UAL
    signal SIGNAL_Imm_Ext_UT : std_logic_vector(31 downto 0) := (others => '1'); -- Sortie Imm to Mux1
    signal SIGNAL_DataOut_UT : std_logic_vector(31 downto 0) := (others => '1'); -- Sortie Memory to Mux2
    signal SIGNAL_S_UT : std_logic_vector(31 downto 0) := (others => '1'); -- Sortie UAL to Mux2 + Memory

    signal SIGNAL_W_Mux_2_UT : std_logic_vector(31 downto 0) := (others => '1'); -- Sortie MuxBis depuis UAL to rebouclage Registre + Copie S

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
            W_BR  => SIGNAL_W_Mux_2_UT,

            A_BR => SIGNAL_A_UT,
            B_BR => SIGNAL_B_UT
        );

    UUT_UAL : entity work.UAL_Unite_Arithmetique_et_Logique_entity
        port map
        (
            OP_UAL => OP_UT,
            A_UAL => SIGNAL_A_UT,
            B_UAL => SIGNAL_B_Mux_1_UT,
            S_UAL => SIGNAL_S_UT,
            N_UAL => N_UT,
            Z_UAL => Z_UT,
            C_UAL => C_UT,
            V_UAL => V_UT
        );

    UUT_Extension_de_Signe : entity work.Extension_de_Signe_entity
        port map
        (
            E_Ext => Imm_UT,

            S_Ext => SIGNAL_Imm_Ext_UT
        );
    

    UUT_Memoire_de_donnees : entity work.Memoire_de_donnees_entity
        port map
        (
            Clk_Memory => Clk_UT,
            Rst_Memory => Rst_M_UT,
            WE_Memory => WrEN_UT,
            COM_Memory => COM_Memory,

            Addr_Memory => Addr_UT,
            DataIn_A_Memory => SIGNAL_B_UT,
            DataIn_B_Memory => SIGNAL_S_UT,

            DataOut_Memory => SIGNAL_DataOut_UT
        );

    UUT_Mux_B : entity work.Mux_2_to_1_N_Bits_entity
        port map
        (
            Mux_A => SIGNAL_B_UT,
            Mux_B => SIGNAL_Imm_Ext_UT,
            Mux_COM => OP_1_Mux,

            Mux_S => SIGNAL_B_Mux_1_UT
        );

    UUT_Mux_W : entity work.Mux_2_to_1_N_Bits_entity
        port map
        (
            Mux_A => SIGNAL_S_UT,
            Mux_B => SIGNAL_DataOut_UT,
            Mux_COM => OP_2_Mux,

            Mux_S => SIGNAL_W_Mux_2_UT
        );

-- Maj S et Memoire
    process (Clk_UT)
    begin
        if rising_edge(Clk_UT) then
            S_UT <= SIGNAL_W_Mux_2_UT; -- Copie de S pour etre visible sur le chronogramme
        end if;
    end process;

end Unite_de_Traitement_architecture;
