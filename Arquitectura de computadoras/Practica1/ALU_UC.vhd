-- Paquete de la ALU para SUMA, RESTA, MULTIPLICACION en operaciones aritmeticas
-- Para OR, AND, NAND, XOR, XNOR, NOR, NOT para operaciones Logicas
-- Corrimiento a la izquierda, corrimiento a la derecha

-- Fecha: marzo de 2025

-- Declaracion de Bibliotecas
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;  -- Esta biblioteca es usada para operaciones con signo
use ieee.numeric_std.all;

-- Declaracion de la entidad
package ALU_UC is

    -- Declaracion de constantes

    signal aux    : std_logic_vector(15 downto 0) := "0000000000000000";  -- registro para revision de Flag
    constant zero : std_logic_vector(7 downto 0)  := "00000000" ;  -- Para 0
    constant full : std_logic_vector(7 downto 0)  := "00001111" ;  -- Para 1

    -- Cabecera del procedimiento de la instrucción SUMA
    procedure ADD(signal REN1 : in std_logic_vector (7 downto 0);
                  signal REN2 : in std_logic_vector (7 downto 0);
                  signal flag : out std_logic_vector (2 downto 0);
                  signal A    : out std_logic_vector (7 downto 0));

    -- Cabecera del procedimiento de la instrucción RESTA
    procedure SUB(signal REN1 : in std_logic_vector (7 downto 0);
                  signal REN2 : in std_logic_vector (7 downto 0);
                  signal flag : out std_logic_vector (2 downto 0);
                  signal A    : out std_logic_vector (7 downto 0));

    -- Cabecera del procedimiento de la instrucción MULTIPLICACIÓN
    procedure MUL(signal REN1 : in std_logic_vector (7 downto 0);
                  signal REN2 : in std_logic_vector (7 downto 0);
                  signal flag : out std_logic_vector (2 downto 0);
                  signal Am   : out std_logic_vector (15 downto 0));

    -- Cabecera del procedimiento de la instrucción AND
    procedure andS(signal REN1 : in std_logic_vector(7 downto 0);
                   signal REN2 : in std_logic_vector(7 downto 0);
                   signal A    : out std_logic_vector(7 downto 0));

    -- Cabecera del procedimiento de la instrucción OR
    procedure LOR(signal REN1 : in std_logic_vector (7 downto 0);
                  signal REN2 : in std_logic_vector (7 downto 0);
                  signal A    : out std_logic_vector (7 downto 0));

    -- Cabecera del procedimiento de la instrucción NOT
    procedure notS(signal REN1 : in std_logic_vector(7 downto 0);
                   signal REN2 : in std_logic_vector(7 downto 0);
                   signal A    : out std_logic_vector(7 downto 0));

    -- Cabecera del procedimiento de la instrucción NOR
    procedure norS(signal REN1 : in std_logic_vector(7 downto 0);
                   signal REN2 : in std_logic_vector(7 downto 0);
                   signal A    : out std_logic_vector(7 downto 0));

    -- Cabecera del procedimiento de la instrucción NAND
    procedure nandS(signal REN1 : in std_logic_vector(7 downto 0);
                    signal REN2 : in std_logic_vector(7 downto 0);
                    signal A    : out std_logic_vector(7 downto 0));

    -- Cabecera del procedimiento de la instrucción XOR
    procedure xorS(signal REN1 : in std_logic_vector(7 downto 0);
                   signal REN2 : in std_logic_vector(7 downto 0);
                   signal A    : out std_logic_vector(7 downto 0));

    -- Cabecera del procedimiento de la instrucción XNOR
    procedure xnorS(signal REN1 : in std_logic_vector(7 downto 0);
                    signal REN2 : in std_logic_vector(7 downto 0);
                    signal A    : out std_logic_vector(7 downto 0));

    -- Cabecera del procedimiento de la instrucción CORRIMIENTO A LA DERECHA
    procedure LDER(signal REN1 : in std_logic_vector(7 downto 0);
                   signal REN2 : in std_logic_vector (7 downto 0);
                   signal A    : out std_logic_vector (7 downto 0));

    -- Cabecera del procedimiento de la instrucción CORRIMIENTO A LA IZQUIERDA
    procedure LIZQ(signal REN1 : in std_logic_vector(7 downto 0);
                   signal REN2 : in std_logic_vector (7 downto 0);
                   signal A    : out std_logic_vector (7 downto 0));
end package;


package body ALU_UC is

    -- Inicio de los procedimientos

    -- Procedimiento de suma
    procedure ADD(signal REN1 : in std_logic_vector (7 downto 0);
                  signal REN2 : in std_logic_vector (7 downto 0);
                  signal flag : out std_logic_vector (2 downto 0);
                  signal A    : out std_logic_vector (7 downto 0))

        is begin
            aux(7 downto 0) <= REN1 + REN2;
            A <= aux (7 downto 0);
            
            if(aux = zero) then
                flag(0) <= '1';  -- Si la operacion tuvo 0 que Z tenga 1
            else
                flag(0) <= '0';
            end if;

            if(aux > full) then
                flag(1) <= '1';  -- Si la operacion excedio la capacidad del registro, que V tenga 1
            else
                flag(1) <= '0';
            end if;

            if(aux < zero) then
                flag(2) <= '1';  -- Si la operacion resulto negativa que N tenga 1
            else
                flag(2) <= '0';
            end if;
    end ADD;

    -- Procedimiento para resta
    procedure SUB(signal REN1 : in std_logic_vector (7 downto 0);
                  signal REN2 : in std_logic_vector (7 downto 0);
                  signal flag : out std_logic_vector (2 downto 0);
                  signal A    : out std_logic_vector (7 downto 0)) 

        is begin
            aux(7 downto 0) <= REN1 - REN2;
            A <= aux(7 downto 0);

            if(aux = zero) then
                flag(0) <= '1';  -- Si la operacion tuvo 0 que Z tenga 1
            else
                flag(0) <= '0';
            end if;

            if(aux > full) then
                flag(1) <= '1';  -- Si la operacion excedio la capacidad del registro, que V tenga 1
            else
                flag(1) <= '0';
            end if;

            if(aux < zero) then
                flag(2) <= '1';  -- Si la operacion resulto negativa que N tenga 1
            else
                flag(2) <= '0';
            end if;
    end SUB;

    -- Procedimiento para multiplicacion
    procedure MUL(signal REN1 : in std_logic_vector (7 downto 0);
                  signal REN2 : in std_logic_vector (7 downto 0);
                  signal flag : out std_logic_vector (2 downto 0);
                  signal Am   : out std_logic_vector (15 downto 0))

        is begin
            aux <= REN1 * REN2;
            Am <= aux;

            if(aux = zero) then
                flag(0) <= '1';  -- Si la operacion tuvo 0 que Z tenga 1
            else
                flag(0) <= '0';
            end if;

            if(aux > full) then
                flag(1) <= '1';  -- Si la operacion excedio la capacidad del registro, que V tenga 1
            else
                flag(1) <= '0';
            end if;

            if(aux < zero) then
                flag(2) <= '1';  -- Si la operacion resulto negativa que N tenga 1
            else
                flag(2) <= '0';
            end if;
    end MUL;

    -- Procedimiento para la instrucción de la compuerta lógica AND
    procedure andS(signal REN1 : in std_logic_vector(7 downto 0);
                   signal REN2 : in std_logic_vector(7 downto 0);
                   signal A    : out std_logic_vector(7 downto 0))

        is begin
            aux(7 downto 0) <= (REN1 AND REN2);
            A <= aux(7 downto 0);
    end andS;

    -- Procedimiento para la instrucción de la compuerta lógica OR
    procedure LOR(signal REN1 : in std_logic_vector (7 downto 0);
                  signal REN2 : in std_logic_vector (7 downto 0);
                  -- signal flag : out std_logic_vector (2 downto 0);  -- ORG
                  signal A    : out std_logic_vector (7 downto 0))

        is begin
            aux(7 downto 0) <= REN1 OR REN2;
            A <= aux(7 downto 0);
    end LOR;

    -- Procedimiento para la instrucción de la compuerta lógica NOT
    procedure notS(signal REN1 : in std_logic_vector(7 downto 0);
                   signal REN2 : in std_logic_vector(7 downto 0);
                   signal A    : out std_logic_vector(7 downto 0))

        is begin
            aux(7 downto 0) <= NOT REN1;
            A <= aux(7 downto 0);
    end notS;

    -- Procedimiento para la instrucción de la compuerta lógica NOR
    procedure norS(signal REN1 : in std_logic_vector(7 downto 0);
                   signal REN2 : in std_logic_vector(7 downto 0);
                   signal A    : out std_logic_vector(7 downto 0))

        is begin
            aux(7 downto 0) <= REN1 NOR REN2;
            A <= aux(7 downto 0);
    end norS;

    -- Procedimiento para la instrucción de la compuerta lógica NAND
    procedure nandS(signal REN1 : in std_logic_vector(7 downto 0);
                   signal REN2 : in std_logic_vector(7 downto 0);
                   signal A    : out std_logic_vector(7 downto 0))

        is begin
            aux(7 downto 0) <= REN1 NAND REN2;
            A <= aux(7 downto 0);
    end nandS;

    -- Procedimiento para la instrucción de la compuerta lógica XOR
    procedure xorS(signal REN1 : in std_logic_vector(7 downto 0);
                   signal REN2 : in std_logic_vector(7 downto 0);
                   signal A    : out std_logic_vector(7 downto 0))

        is begin
            aux(7 downto 0) <= REN1 XOR REN2;
            A <= aux(7 downto 0);
    end xorS;

    -- Procedimiento para la instrucción de la compuerta lógica XNOR
    procedure xnorS(signal REN1 : in std_logic_vector(7 downto 0);
                    signal REN2 : in std_logic_vector(7 downto 0);
                    signal A    : out std_logic_vector(7 downto 0))

        is begin
            aux(7 downto 0) <= REN1 XNOR REN2;
            A <= aux(7 downto 0);
    end xnorS;

    -- Procedimiento para la instrucción de corrimiento a la derecha
    procedure LDER(signal REN1 : in std_logic_vector(7 downto 0);
                   signal REN2 : in std_logic_vector(7 downto 0);
                   signal A    : out std_logic_vector(7 downto 0))

        is begin
            aux(6 downto 0) <= REN1(7 downto 1);  -- Copiamos los 6 bits menos significativos del registro REN1 a un registro auxiliar
            aux(7) <= '0';  -- Asignamos 0 al bit mas significactivo del registro auxiliar
            A <= aux(7 downto 0);  -- Copiamos los 8 bits mas significativos del registro auxiliar al registro A
    end LDER;

    -- Procedimiento para la instrucción de corrimiento a la izquierda
    procedure LIZQ(signal REN1 : in std_logic_vector(7 downto 0);
                   signal REN2 : in std_logic_vector(7 downto 0);
                   signal A    : out std_logic_vector(7 downto 0))

        is begin
            aux(7 downto 1) <= REN1(6 downto 0);  -- Copiamos los 6 bits mas significativos del registro REN1 a un registro auxiliar
            aux(0) <= '0';  -- Asignamos 0 al bit menos significactivo del registro auxiliar
            A <= aux(7 downto 0);  -- Copiamos los 8 bits menos significativos del registro auxiliar al registro A
    end LIZQ;
end ALU_UC;
