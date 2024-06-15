library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
-- use IEEE.std_logic_unsigned.ALL; -- Pas super utile vu que numeric a deja et les signed et le unsigned mais par precaution pour eviter les bug on laisse

entity UAL_Unite_Arithmetique_et_Logique_entity is
    port 
    (
        OP_UAL  : in std_logic_vector(2 downto 0); -- Signal de COMMANDE 3 bits
        A_UAL,B_UAL : in std_logic_vector(31 downto 0);
        S_UAL : out std_logic_vector(31 downto 0);
        N_UAL,Z_UAL,C_UAL,V_UAL : out std_logic -- Drapeaux
    );
end UAL_Unite_Arithmetique_et_Logique_entity;

architecture UAL_architecture of UAL_Unite_Arithmetique_et_Logique_entity is
-- Signal
signal S_SIGNAL_UAL : std_logic_vector(31 downto 0) := (others => '0');

-- Content
begin
    S_UAL <= S_SIGNAL_UAL;

process (A_UAL,B_UAL,OP_UAL,S_SIGNAL_UAL) -- Combinatoire toute sortie dans la liste de sensibilite
begin
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

-- Debordement
    if ((OP_UAL = "000")) and ((A_UAL(31) = B_UAL(31)) and (S_SIGNAL_UAL(31) /= B_UAL(31))) then
        V_UAL <= '1';
    end if;

    if ((OP_UAL = "010")) and ((A_UAL(31) /= B_UAL(31)) and (S_SIGNAL_UAL(31) /= B_UAL(31))) then
        V_UAL <= '1';
    end if;

-- Zero
    if (S_SIGNAL_UAL = x"0000_0000") then 
        Z_UAL <= '1';
    end if;

-- Retenu addition
    if (((OP_UAL = "000") and (A_UAL(31) = B_UAL(31) and B_UAL(31)/=B_UAL(30) and B_UAL(30) = A_UAL(30)))) then -- or ((OP_UAL = "010") and (A_UAL(31) /= B_UAL(31) and A_UAL(31)/=A_UAL(30) and B_UAL(30) /= A_UAL(30))))  then
        C_UAL <= '1';
    end if;

-- Retenu soustraction
    if ((OP_UAL = "010") and (A_UAL(31) /= B_UAL(31)) and (S_SIGNAL_UAL(31) /= A_UAL(31))) then
        V_UAL <= '1';
    end if;

-- Détection du zéro
if (S_SIGNAL_UAL = x"00000000") then 
    Z_UAL <= '1';
end if;

-- Negatif 
    N_UAL <= S_SIGNAL_UAL(1); -- Aide par Monsieur DOUZE Yann car j avais fait complique pour rien

end process;
end UAL_architecture;