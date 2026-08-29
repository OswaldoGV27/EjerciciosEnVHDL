library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity COD_Prio3A8 is
    Port (
        Entrada : in  STD_LOGIC_VECTOR (7 downto 0); -- Entradas
        Enable : in  STD_LOGIC; -- Habilitación
        Salida : out  STD_LOGIC_VECTOR (2 downto 0) -- Salida
    );
end COD_Prio3A8;

architecture COD of COD_Prio3A8 is
begin
    process(Entrada, Enable)
        variable CTRL : STD_LOGIC_VECTOR(2 downto 0); -- Variable temporal
    begin
        if Enable = '1' then
            if Entrada = "00000001" then CTRL := "000";
            elsif Entrada = "00000010" then CTRL := "001";
            elsif Entrada = "00000100" then CTRL := "010";
            elsif Entrada = "00001000" then CTRL := "011";
            elsif Entrada = "00010000" then CTRL := "100";
            elsif Entrada = "00100000" then CTRL := "101";
            elsif Entrada = "01000000" then CTRL := "110";
            elsif Entrada = "10000000" then CTRL := "111";
            else CTRL := "000"; -- En caso de ninguna entrada activa
            end if;
        else
            CTRL := "000"; -- Si la habilitación está baja, salida en cero
        end if;
        Salida <= CTRL;
    end process;
end COD;

