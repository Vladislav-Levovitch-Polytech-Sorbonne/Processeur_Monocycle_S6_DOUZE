library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Valeur_Initialisee_Banc_de_Registre_entity is
    port 
    (
        Clk_BR : in std_logic;
        Rst_BR : in std_logic;
        WE_BR  : in std_logic;

        Ra_BR, Rb_BR, Rw_BR : in std_logic_vector(3 downto 0);
        W_BR: in std_logic_vector(31 downto 0);

        A_BR, B_BR : out std_logic_vector(31 downto 0)
    );
end Valeur_Initialisee_Banc_de_Registre_entity;

architecture Banc_de_Registre_architecture of Valeur_Initialisee_Banc_de_Registre_entity is
-- Signal
signal A_SIGNAL_RB : std_logic_vector(31 downto 0) := (others => '0');
signal B_SIGNAL_RB : std_logic_vector(31 downto 0) := (others => '0');
signal Registre_0_RB, Registre_1_RB, Registre_2_RB ,Registre_3_RB ,Registre_4_RB ,Registre_5_RB ,Registre_6_RB ,Registre_7_RB ,Registre_8_RB ,Registre_9_RB ,Registre_10_RB ,Registre_11_RB ,Registre_12_RB ,Registre_13_RB ,Registre_14_RB ,Registre_15_RB : std_logic_vector(31 downto 0) := (others => '0');

-- Content
begin

    process (Ra_BR,Rb_BR) -- Combinatoire lecture   -- Je ne suis pas sur qu un petit if Enable n aurait pas ete de trop
    begin
        case Ra_BR is 
            when "0000" => A_BR  <= Registre_0_RB;  -- Registre 0
            when "0001" => A_BR  <= Registre_1_RB;  -- Registre 1
            when "0010" => A_BR  <= Registre_2_RB;  -- Registre 2
            when "0011" => A_BR  <= Registre_3_RB;  -- Registre 3
            when "0100" => A_BR  <= Registre_4_RB;  -- Registre 4
            when "0101" => A_BR  <= Registre_5_RB;  -- Registre 5
            when "0110" => A_BR  <= Registre_6_RB;  -- Registre 6
            when "0111" => A_BR  <= Registre_7_RB;  -- Registre 7
            when "1000" => A_BR  <= Registre_8_RB;  -- Registre 8
            when "1001" => A_BR  <= Registre_9_RB;  -- Registre 9
            when "1010" => A_BR  <= Registre_10_RB;-- Registre 10
            when "1011" => A_BR  <= Registre_11_RB;-- Registre 11
            when "1100" => A_BR  <= Registre_12_RB;-- Registre 12
            when "1101" => A_BR  <= Registre_13_RB;-- Registre 13
            when "1110" => A_BR  <= Registre_14_RB;-- Registre 14
            when "1111" => A_BR  <= Registre_15_RB;-- Registre 15

            when others => A_BR  <= (others => '0');   -- Dans le doute mais ne doit pas arriver
        end case;

        case Rb_BR is 
            when "0000" => B_BR  <= Registre_0_RB;  -- Registre 0
            when "0001" => B_BR  <= Registre_1_RB;  -- Registre 1
            when "0010" => B_BR  <= Registre_2_RB;  -- Registre 2
            when "0011" => B_BR  <= Registre_3_RB;  -- Registre 3
            when "0100" => B_BR  <= Registre_4_RB;  -- Registre 4
            when "0101" => B_BR  <= Registre_5_RB;  -- Registre 5
            when "0110" => B_BR  <= Registre_6_RB;  -- Registre 6
            when "0111" => B_BR  <= Registre_7_RB;  -- Registre 7
            when "1000" => B_BR  <= Registre_8_RB;  -- Registre 8
            when "1001" => B_BR  <= Registre_9_RB;  -- Registre 9
            when "1010" => B_BR  <= Registre_10_RB;-- Registre 10
            when "1011" => B_BR  <= Registre_11_RB;-- Registre 11
            when "1100" => B_BR  <= Registre_12_RB;-- Registre 12
            when "1101" => B_BR  <= Registre_13_RB;-- Registre 13
            when "1110" => B_BR  <= Registre_14_RB;-- Registre 14
            when "1111" => B_BR  <= Registre_15_RB;-- Registre 15

            when others => B_BR <= (others => '0');   -- Dans le doute mais ne doit pas arriver
        end case;
    end process;

    process (Clk_BR,Rst_BR) -- Synchrone Ecriture 

    begin
        if ( Rst_BR = '1') then  -- Re Initialisation des Registres (et sortie par l occasion meme si combinatoire dans le doute)
            Registre_0_RB <= (others => '0');
            Registre_1_RB <= (others => '0');
            Registre_2_RB <= (others => '0');
            Registre_3_RB <= (others => '0');
            Registre_4_RB <= (others => '0');
            Registre_5_RB <= (others => '0');
            Registre_6_RB <= (others => '0');
            Registre_7_RB <= x"FFBF_DFF0"; -- Complement a 2 de x"0040_2010"
            Registre_8_RB <= (others => '0');
            Registre_9_RB <= (others => '0');
            Registre_10_RB <= (others => '0');
            Registre_11_RB <= (others => '0');
            Registre_12_RB <= (others => '0');
            Registre_13_RB <= (others => '0');
            Registre_14_RB <= (others => '0');
            Registre_15_RB <= x"0040_2010"; -- Initialisation manuel tres archaique a evite mais nous etions vraiment sans issu

        elsif (Rst_BR = '0') then
            if rising_edge(Clk_BR) then
                if (WE_BR = '1') then
                    case Rw_BR is 
                        when "0000" => Registre_0_RB <= W_BR;  -- Registre 0
                        when "0001" => Registre_1_RB <= W_BR;  -- Registre 1
                        when "0010" => Registre_2_RB <= W_BR;  -- Registre 2
                        when "0011" => Registre_3_RB <= W_BR;  -- Registre 3
                        when "0100" => Registre_4_RB <= W_BR;  -- Registre 4
                        when "0101" => Registre_5_RB <= W_BR;  -- Registre 5
                        when "0110" => Registre_6_RB <= W_BR;  -- Registre 6
                        when "0111" => Registre_7_RB <= W_BR;  -- Registre 7
                        when "1000" => Registre_8_RB <= W_BR;  -- Registre 8
                        when "1001" => Registre_9_RB <= W_BR;  -- Registre 9
                        when "1010" => Registre_10_RB <= W_BR; -- Registre 10
                        when "1011" => Registre_11_RB <= W_BR; -- Registre 11
                        when "1100" => Registre_12_RB <= W_BR; -- Registre 12
                        when "1101" => Registre_13_RB <= W_BR; -- Registre 13
                        when "1110" => Registre_14_RB <= W_BR; -- Registre 14
                        when "1111" => Registre_15_RB <= W_BR; -- Registre 15

                        when others => Registre_0_RB <= W_BR;  -- Par default
                    end case;

                end if;
            end if;
        end if;
    end process;
end Banc_de_Registre_architecture;