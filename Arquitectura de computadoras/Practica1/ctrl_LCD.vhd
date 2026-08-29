-- Programa de funciones, constantes y procedimientos para controlar el LCD
-- Fecha: marzo de 2025

Library ieee;
Use ieee.std_logic_1164.all;


package ctrl_LCD is
    -- Declaracion de arreglos para mensaje
    type arreglo is array (0 to 15) of std_logic_vector(7 downto 0);  -- Creacion de un arreglo

    -- Cabeceras
    procedure mensaje(constant ent : std_logic;
                      variable U : integer range 0 to 15;
                      signal D: out std_logic_vector(7 downto 0));

    procedure actualizar_mensaje1(msg : arreglo);
    procedure actualizar_mensaje2(msg : arreglo);

    procedure ascii_conv (signal code : in std_logic_vector (3 downto 0);
                          signal D    : out std_logic_vector (7 downto 0));


    constant ascii0 : std_logic_vector(7 downto 0) := X"30";
    constant ascii1 : std_logic_vector(7 downto 0) := X"31";
    constant ascii2 : std_logic_vector(7 downto 0) := X"32";
    constant ascii3 : std_logic_vector(7 downto 0) := X"33";
    constant ascii4 : std_logic_vector(7 downto 0) := X"34";
    constant ascii5 : std_logic_vector(7 downto 0) := X"35";
    constant ascii6 : std_logic_vector(7 downto 0) := X"36";
    constant ascii7 : std_logic_vector(7 downto 0) := X"37";
    constant ascii8 : std_logic_vector(7 downto 0) := X"38";
    constant ascii9 : std_logic_vector(7 downto 0) := X"39";
    constant asciiA : std_logic_vector(7 downto 0) := X"41";
    constant asciiB : std_logic_vector(7 downto 0) := X"42";
    constant asciiC : std_logic_vector(7 downto 0) := X"43";
    constant asciiD : std_logic_vector(7 downto 0) := X"44";
    constant asciiE : std_logic_vector(7 downto 0) := X"45";
    constant asciiF : std_logic_vector(7 downto 0) := X"46";
	 
	 
	 -- Arreglo de caracteres para la primera linea
    signal mensaje1 : arreglo := (others => ascii0);

    -- Arreglo de caracteres para la segunda linea
    signal mensaje2 : arreglo := (others => ascii0);
end ctrl_LCD;


package body ctrl_LCD is
    procedure mensaje(constant ent : std_logic;
                      variable U   : integer range 0 to 15; 
                      signal D     : out std_logic_vector(7 downto 0))
    is begin
        if ent = '0' then
            D <= mensaje1(U);  -- Las constantes del Mensaje1 salen en funcion de la variable U
        else
            D <= mensaje2(U);  -- Las constantes del Mensaje2 salen en funcion de la variable U
        end if;
    end mensaje;

    procedure actualizar_mensaje1(msg : arreglo) is begin
        mensaje1 <= msg;
    end actualizar_mensaje1;

    procedure actualizar_mensaje2(msg : arreglo) is begin
        mensaje2 <= msg;
    end actualizar_mensaje2;


    procedure ascii_conv (signal code : in std_logic_vector (3 downto 0);
                          signal D    : out std_logic_vector (7 downto 0))
    is begin
        case code is  -- Seleccion de constante dependiendo del valor de entrada
            when "0000" => D <= ascii0;
            when "0001" => D <= ascii1;
            when "0010" => D <= ascii2;
            when "0011" => D <= ascii3;
            when "0100" => D <= ascii4;
            when "0101" => D <= ascii5;
            when "0110" => D <= ascii6;
            when "0111" => D <= ascii7;
            when "1000" => D <= ascii8;
            when "1001" => D <= ascii9;
            when "1010" => D <= asciiA;
            when "1011" => D <= asciiB;
            when "1100" => D <= asciiC;
            when "1101" => D <= asciiD;
            when "1110" => D <= asciiE;
            when others => D <= asciiF;
        end case;
    end ascii_conv;
end ctrl_LCD;
