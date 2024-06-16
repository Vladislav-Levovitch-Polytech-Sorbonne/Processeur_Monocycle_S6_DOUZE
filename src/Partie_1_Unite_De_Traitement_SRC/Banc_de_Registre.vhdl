library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
-- use IEEE.std_logic_unsigned.ALL;

entity Banc_de_Registre_entity is
    port 
    (
        Clk_BR : in std_logic;
        Rst_BR : in std_logic;
        WE_BR  : in std_logic;

        Ra_BR, Rb_BR, Rw_BR : in std_logic_vector(3 downto 0);
        W_BR: in std_logic_vector(31 downto 0);

        A_BR, B_BR : out std_logic_vector(31 downto 0);
    );
end Banc_de_Registre_entity;

architecture Banc_de_Registre_architecture of Banc_de_Registre_entity is
-- Signal
signal S_SIGNAL_RB : std_logic_vector(31 downto 0) := (others => '0');


signal Registre_0_RB : std_logic_vector(31 downto 0) := (others => '0');
signal Registre_1_RB : std_logic_vector(31 downto 0) := (others => '0'); -- Choix personnel, je prefere 16 variables a un tableau
signal Registre_2_RB : std_logic_vector(31 downto 0) := (others => '0');
signal Registre_3_RB : std_logic_vector(31 downto 0) := (others => '0');
signal Registre_4_RB : std_logic_vector(31 downto 0) := (others => '0');
signal Registre_5_RB : std_logic_vector(31 downto 0) := (others => '0');
signal Registre_6_RB : std_logic_vector(31 downto 0) := (others => '0');
signal Registre_7_RB : std_logic_vector(31 downto 0) := (others => '0');
signal Registre_8_RB : std_logic_vector(31 downto 0) := (others => '0');
signal Registre_9_RB : std_logic_vector(31 downto 0) := (others => '0');
signal Registre_10_RB : std_logic_vector(31 downto 0) := (others => '0');
signal Registre_11_RB : std_logic_vector(31 downto 0) := (others => '0');
signal Registre_12_RB : std_logic_vector(31 downto 0) := (others => '0');
signal Registre_13_RB : std_logic_vector(31 downto 0) := (others => '0');
signal Registre_14_RB : std_logic_vector(31 downto 0) := (others => '0');
signal Registre_15_RB : std_logic_vector(31 downto 0) := (others => '0');


-- Initialisation des sorties
A_BR <= (others => '0');
B_BR <= (others => '0');
-- Content
begin
    S_UAL <= S_SIGNAL_UAL;

    process (Ra_BR,Rb_BR) -- Combinatoire lecture    -- Je ne suis pas sur qu un petit if Enable n aurait pas ete de trop
    begin
        case Ra_BR is 
            when "0000" =>  A_BR <= Registre_0_RB;
            when "0000" =>  A_BR <= Registre_0_RB;
            when "0000" =>  A_BR <= Registre_0_RB;
            when "0000" =>  A_BR <= Registre_0_RB;
            when "0000" =>  A_BR <= Registre_0_RB;
            when "0000" =>  A_BR <= Registre_0_RB;
            when "0000" =>  A_BR <= Registre_0_RB;
            when "0000" =>  A_BR <= Registre_0_RB;
            when "0000" =>  A_BR <= Registre_0_RB;
            when "0000" =>  A_BR <= Registre_0_RB;
            when "0000" =>  A_BR <= Registre_0_RB;
            


    end process;

    process (Clk_BR,Rst_BR,) -- Synchrone Ecriture 
    begin

    end process;
        -- Initialisation par defaut des sorties N, Z, C et V
        N_UAL <= '0';
        Z_UAL <= '0';
        C_UAL <= '0';
        V_UAL <= '0';

        case OP_UAL is 
            when "000" =>  S_SIGNAL_UAL <= std_logic_vector (signed(A_UAL)+signed(B_UAL)); 
            when "001" =>  S_SIGNAL_UAL <= B_UAL; 
            when "010" =>  S_SIGNAL_UAL <= std_logic_vector (signed(A_UAL)-signed(B_UAL)); 
            when "011" =>  S_SIGNAL_UAL <= A_UAL; 
            
            when "100" =>  S_SIGNAL_UAL <= (A_UAL or B_UAL); 
            when "101" =>  S_SIGNAL_UAL <= (A_UAL and B_UAL); 
            when "110" =>  S_SIGNAL_UAL <= (A_UAL xor B_UAL); 
            when "111" =>  S_SIGNAL_UAL <= (not (A_UAL)); 

            when others => S_SIGNAL_UAL <= (others => '0'); -- Dans le doutes
        end case;

    -- Retenu Soustration
        if (((OP_UAL = "010") and A_UAL(31) /= B_UAL(31)) and (S_SIGNAL_UAL(31) /= A_UAL(31))) then
            C_UAL <= '1';
        end if;

    end process;
end Banc_de_Registre_architecture;