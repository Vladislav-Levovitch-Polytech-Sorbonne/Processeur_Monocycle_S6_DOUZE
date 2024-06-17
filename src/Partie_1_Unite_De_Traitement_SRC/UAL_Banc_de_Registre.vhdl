library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity UAL_Banc_de_Registre_entity is
    port 
    (
        Clk_BRUAL, Rst_BRUAL, WE_BRUAL : in std_logic;

        Ra_BRUAL, Rb_BRUAL, Rw_BRUAL : in std_logic_vector(3 downto 0);
        W_BRUAL: in std_logic_vector(31 downto 0);

        S_BRUAL : out std_logic_vector(31 downto 0);
        N_BRUAL, Z_BRUAL, C_BRUAL, V_BRUAL : out std_logic -- Drapeaux
    );
end UAL_Banc_de_Registre_entity;

architecture UAL_Banc_de_Registre_architecture of UAL_Banc_de_Registre_entity is
-- Signal
signal A_SIGNAL_BRUAL : std_logic_vector(31 downto 0) := (others => '0');
signal B_SIGNAL_BRUAL : std_logic_vector(31 downto 0) := (others => '0');

-- Content
begin
    UUT_Banc_de_Registre : entity work.Banc_de_Registre_entity
        port map 
		(
			Clk_BR => Clk_BRUAL,
        	Rst_BR => Rst_BRUAL,
        	WE_BR  => WE_BRUAL,

        	Ra_BR => Ra_BRUAL,
			Rb_BR => Rb_BRUAL,
			Rw_BR => Rw_BRUAL,
        	W_BR  => W_BRUAL,

        	A_BR => A_SIGNAL_BRUAL,
			B_BR => B_SIGNAL_BRUAL
        );

    process (Clk_BRUAL,Rst_BRUAL) -- Synchrone Ecriture 

    begin
        if ( Rst_BRUAL = '1') then  -- Re Initialisation des Registres (et sortie par l occasion meme si combinatoire dans le doute)
            Registre_0_RB <= (others => '0');
            Registre_1_RB <= (others => '0');
            Registre_2_RB <= (others => '0');
            Registre_3_RB <= (others => '0');
            Registre_4_RB <= (others => '0');
            Registre_5_RB <= (others => '0');
            Registre_6_RB <= (others => '0');
            Registre_7_RB <= (others => '0');
            Registre_8_RB <= (others => '0');
            Registre_9_RB <= (others => '0');
            Registre_10_RB <= (others => '0');
            Registre_11_RB <= (others => '0');
            Registre_12_RB <= (others => '0');
            Registre_13_RB <= (others => '0');
            Registre_14_RB <= (others => '0');
            Registre_15_RB <= (others => '0');

        elsif (Rst_BRUAL = '0') then
            if rising_edge(Clk_BRUAL) then
                if (WE_BRUAL = '1') then
                    case Rw_BRUAL is 
                        when "0000" => Registre_0_RB <= W_BRUAL;  -- Registre 0
                        when "0001" => Registre_1_RB <= W_BRUAL;  -- Registre 1
                        when "0010" => Registre_2_RB <= W_BRUAL;  -- Registre 2
                        when "0011" => Registre_3_RB <= W_BRUAL;  -- Registre 3
                        when "0100" => Registre_4_RB <= W_BRUAL;  -- Registre 4
                        when "0101" => Registre_5_RB <= W_BRUAL;  -- Registre 5
                        when "0110" => Registre_6_RB <= W_BRUAL;  -- Registre 6
                        when "0111" => Registre_7_RB <= W_BRUAL;  -- Registre 7
                        when "1000" => Registre_8_RB <= W_BRUAL;  -- Registre 8
                        when "1001" => Registre_9_RB <= W_BRUAL;  -- Registre 9
                        when "1010" => Registre_10_RB <= W_BRUAL; -- Registre 10
                        when "1011" => Registre_11_RB <= W_BRUAL; -- Registre 11
                        when "1100" => Registre_12_RB <= W_BRUAL; -- Registre 12
                        when "1101" => Registre_13_RB <= W_BRUAL; -- Registre 13
                        when "1110" => Registre_14_RB <= W_BRUAL; -- Registre 14
                        when "1111" => Registre_15_RB <= W_BRUAL; -- Registre 15

                        when others => Registre_0_RB <= W_BRUAL;  -- Par default
                    end case;

                end if;
            end if;
        end if;
    end process;
end UAL_Banc_de_Registre_architecture;