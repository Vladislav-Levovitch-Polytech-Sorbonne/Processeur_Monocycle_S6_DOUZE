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
signal S_SIGNAL_UAL : std_logic_vector(31 downto 0) := (others => '0');

-- Content
begin
    S_UAL <= S_SIGNAL_UAL;

    process (Ra_BR,Rb_BR,Rw_BR, W_BR) -- Combinatoire lecture    -- Je ne suis pas sur qu un petit if Enable n aurait pas ete de trop
    begin
    
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