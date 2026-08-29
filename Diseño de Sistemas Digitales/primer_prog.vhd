-- Primer programa para el grupo 4CV2
-- Elaborado por: Mi con amor para el grupo 4CV2
-- Fecha: 10 de septiembre de 2025

-- *********************** Declaracion de las bibliotecas ********************
    Library ieee;                   -- Incluyendo una biblioteca
    use ieee.std_logic_1164.all;    -- Incluye todos los paquetes de std_logic_1164
-- *********************** Declaracion de la entidad *************************

    entity primer_prog is
        port (
            a: in std_logic;       -- Declaro la entrada a
            b: out std_logic;      -- Declaro la salida b
        );
    end entity;

-- *********************** declaracion de la arquitectura *********************

    architecture G4CV2 of primer_prog is
        begin
            b <= a;                 -- Asignacion de entrada y salida
            
    end G4CV2;                      -- Fin de la arquitectura
