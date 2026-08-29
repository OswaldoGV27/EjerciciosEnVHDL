library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CTRL7SEG is
    Port ( CTRL : in STD_LOGIC;
           A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           D : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end CTRL7SEG;

architecture CTRL7SEG of CTRL7SEG is
begin
    process(CTRL, A, B, C, D)
        variable bin : STD_LOGIC_VECTOR (3 downto 0);
    begin
        bin := A & B & C & D;
        if CTRL = '0' then -- Convertidor Binario a 7 Segmentos
            case bin is
                when "0000" => seg <= "0111111"; -- 0
                when "0001" => seg <= "0000110"; -- 1
                when "0010" => seg <= "1011011"; -- 2
                when "0011" => seg <= "1001111"; -- 3
                when "0100" => seg <= "1100110"; -- 4
                when "0101" => seg <= "1101101"; -- 5
                when "0110" => seg <= "1111101"; -- 6
                when "0111" => seg <= "0000111"; -- 7
                when "1000" => seg <= "1111111"; -- 8
                when "1001" => seg <= "1100111"; -- 9
                when "1010" => seg <= "1110111"; -- A
                when "1011" => seg <= "1111100"; -- b
                when "1100" => seg <= "0111001"; -- C
                when "1101" => seg <= "1011110"; -- d
                when "1110" => seg <= "1111001"; -- E
                when others => seg <= "1110001"; -- F
            end case;
        else -- Convertidor BCD a 7 Segmentos
            case bin is
                when "0000" => seg <= "0111111"; -- 0
                when "0001" => seg <= "0000110"; -- 1
                when "0010" => seg <= "1011011"; -- 2
                when "0011" => seg <= "1001111"; -- 3
                when "0100" => seg <= "1100110"; -- 4
                when "0101" => seg <= "1101101"; -- 5
                when "0110" => seg <= "1111101"; -- 6
                when "0111" => seg <= "0000111"; -- 7
                when "1000" => seg <= "1111111"; -- 8
                when "1001" => seg <= "1100111"; -- 9
                when others => seg <= "1000000"; -- Para valores no definidos en BCD (1010-1111)
            end case;
        end if;
    end process;
end CTRL7SEG;