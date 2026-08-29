-- Programa para instanciar componente controlador del LCD
-- Fecha: marzo de 2025

library ieee;
use ieee.std_logic_1164.all;

-- Paquete para LCD_comp

package LCD_package is
    component LCD_comp is
        Port(
            clr, clk  : in std_logic;
            SW        : in std_logic;
            Datos     : out std_logic_vector(7 downto 0);
            E, RS, RW : out std_logic
        );
    end component LCD_comp;
end LCD_package;
