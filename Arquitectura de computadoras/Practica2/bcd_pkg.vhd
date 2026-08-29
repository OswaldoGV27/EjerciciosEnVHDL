library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package bcd_pkg is
    type bcd4_t is array(3 downto 0) of std_logic_vector(3 downto 0);
    function bin2bcd4(i : integer) return bcd4_t;
end;

package body bcd_pkg is
    function bin2bcd4(i : integer) return bcd4_t is
        variable v : integer := i;
        variable d : bcd4_t  := (others => "0000");
    begin
        for k in 3 downto 0 loop
            d(k) := std_logic_vector(to_unsigned(v mod 10,4));
            v    := v / 10;
        end loop;
        return d;
    end;
end;