library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity UAL_Banc_de_Registre_entity is
    port 
    (
        Clk_BRUAL, Rst_BRUAL, WE_BRUAL : in std_logic;

        Ra_BRUAL, Rb_BRUAL, Rw_BRUAL : in std_logic_vector(3 downto 0);
        OP_BRUAL  : in std_logic_vector(2 downto 0); -- Signal de COMMANDE 3 bits

        S_BRUAL : out std_logic_vector(31 downto 0); -- Variable copie en sortie
        N_BRUAL, Z_BRUAL, C_BRUAL, V_BRUAL : out std_logic -- Drapeaux
    );
end UAL_Banc_de_Registre_entity;

architecture UAL_Banc_de_Registre_architecture of UAL_Banc_de_Registre_entity is
-- Signal
signal A_SIGNAL_BRUAL : std_logic_vector(31 downto 0) := (others => '0');
signal B_SIGNAL_BRUAL : std_logic_vector(31 downto 0) := (others => '0');
signal W_SIGNAL_BRUAL : std_logic_vector(31 downto 0) := (others => '0');

-- Content
begin
    -- UUT_Banc_de_Registre : entity work.Banc_de_Registre_entity
    UUT_UAL_Banc_de_Registre : entity work.Valeur_Initialisee_Banc_de_Registre_entity
        
        port map 
		(
			Clk_BR => Clk_BRUAL,
        	Rst_BR => Rst_BRUAL,
        	WE_BR  => WE_BRUAL,

        	Ra_BR => Ra_BRUAL,
			Rb_BR => Rb_BRUAL,
			Rw_BR => Rw_BRUAL,
        	W_BR  => W_SIGNAL_BRUAL,

        	A_BR => A_SIGNAL_BRUAL,
			B_BR => B_SIGNAL_BRUAL
        );
    
    UUT_UAL : entity work.UAL_Unite_Arithmetique_et_Logique_entity
        port map 
		(
            OP_UAL=> OP_BRUAL,
            A_UAL => A_SIGNAL_BRUAL,
            B_UAL => B_SIGNAL_BRUAL,
            S_UAL => W_SIGNAL_BRUAL,
            N_UAL => N_BRUAL,
            Z_UAL => Z_BRUAL,
            C_UAL => C_BRUAL,
            V_UAL => V_BRUAL
        );

    Maj_Sortie : process (W_SIGNAL_BRUAL) -- Combinatoire Mono

    begin
    S_BRUAL <= W_SIGNAL_BRUAL; -- Attention il y a un coup d horloge d ecart 

    end process Maj_Sortie;
end UAL_Banc_de_Registre_architecture;