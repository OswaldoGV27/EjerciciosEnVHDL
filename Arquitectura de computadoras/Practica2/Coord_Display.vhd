library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.bcd_pkg.all;

entity Coord_Display is
    port(
        Xpos : in  integer range 0 to 9999;
        Ypos : in  integer range 0 to 9999;
        HEX7,HEX6,HEX5,HEX4,
        HEX3,HEX2,HEX1,HEX0 : out std_logic_vector(6 downto 0)
    );
end;

architecture rtl of Coord_Display is
    signal bx : bcd4_t;
    signal by : bcd4_t;
begin
    -- Conversión binario → BCD (combinacional)
    bx <= bin2bcd4(Xpos);
    by <= bin2bcd4(Ypos);

    ------------------------------------------------------------------
    -- Instancias de Display7Segmentos
    ------------------------------------------------------------------
    D7 : entity work.Display7Segmentos port map(value => bx(3), segments => HEX7);
    D6 : entity work.Display7Segmentos port map(value => bx(2), segments => HEX6);
    D5 : entity work.Display7Segmentos port map(value => bx(1), segments => HEX5);
    D4 : entity work.Display7Segmentos port map(value => bx(0), segments => HEX4);

    D3 : entity work.Display7Segmentos port map(value => by(3), segments => HEX3);
    D2 : entity work.Display7Segmentos port map(value => by(2), segments => HEX2);
    D1 : entity work.Display7Segmentos port map(value => by(1), segments => HEX1);
    D0 : entity work.Display7Segmentos port map(value => by(0), segments => HEX0);
end rtl;