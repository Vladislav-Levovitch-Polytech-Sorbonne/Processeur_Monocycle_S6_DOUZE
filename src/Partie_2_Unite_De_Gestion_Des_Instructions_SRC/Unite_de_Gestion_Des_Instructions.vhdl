library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Unite_de_Gestion_Des_Instructions_entity is
    port 
    (
        Clk_UGI, Rst_R_UGI, nPCsel_UGI : in std_logic;
        Offset_UGI : in std_logic_vector (23 downto 0);
        
        Instruction_UGI : out std_logic_vector(31 downto 0) -- Variable copie pour sortie
    );
end Unite_de_Gestion_Des_Instructions_entity;

architecture Unite_de_Gestion_Des_Instructions_architecture of Unite_de_Gestion_Des_Instructions_entity is

-- Signal
    signal SIGNAL_Offset_UGI, SIGNAL_PC_UGI, SIGNAL_Mux_UGI, SIGNAL_Add_Off_UGI, SIGNAL_Add_PC_UGI : std_logic_vector(31 downto 0) := (others => '0');

-- Content
begin

    UUT_Memory_Instruction : entity work.instruction_memory_entity
        port map
        (
            In_PC => SIGNAL_PC_UGI, 

            Out_Instruction => Instruction_UGI
        );

    UUT_Extension_de_Signe : entity work.Extension_de_Signe_entity
        port map
        (
            E_Ext => Offset_UGI,

            S_Ext => SIGNAL_Offset_UGI
        );
    

    UUT_Additionneur_2_Entrees : entity work.Additionneur_2_Entrees_entity
        port map
        (
            Add_E_A => SIGNAL_PC_UGI,
            Add_E_B => SIGNAL_Offset_UGI,

            Add_S_A => SIGNAL_Add_PC_UGI,
            Add_S_B => SIGNAL_Add_Off_UGI
        );

    UUT_Mux : entity work.Mux_2_to_1_N_Bits_entity
        port map
        (
            Mux_A => SIGNAL_Add_PC_UGI,
            Mux_B => SIGNAL_Add_Off_UGI,
            Mux_COM => nPCsel_UGI,

            Mux_S => SIGNAL_Mux_UGI
        );

    UUT_D_PC : entity work.Bascule_D_Simple_PC_entity
        port map
        (
            Bascule_D_Clk => Clk_UGI,
            Bascule_D_In => SIGNAL_Mux_UGI,
            Bascule_D_Rst => Rst_R_UGI,

            Bascule_D_Out => SIGNAL_PC_UGI
        );
end Unite_de_Gestion_Des_Instructions_architecture;
