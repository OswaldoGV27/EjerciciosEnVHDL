-- Programa de Unidad de Control, con 8 instrucciones para una arquitectura de 8 bits
-- Fecha: marzo de 2025

-- Declaracion de Bibliotecas

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;  -- Esta biblioteca es usada para operaciones con signo
use ieee.numeric_std.all;
use work.ALU_UC.all;       -- Paquete de los registros
use work.bcd_7seg.all;     -- Paquete para los display
use work.LCD_package.all;  -- Paquetes para el LCD
use work.ctrl_LCD.actualizar_mensaje1;
use work.ctrl_LCD.actualizar_mensaje2;
use work.ctrl_LCD.ascii_conv;
use work.ctrl_LCD.arreglo;

--    Inicio de la entidad

entity U_Control is
    Port(
        clk, clr  : in std_logic;                        -- Reloj, Reset
        exe       : in std_logic;                        -- Boton de ejecucion
        ent_datos : in std_logic_vector(7 downto 0);     -- Datos de los switches
        ent_inst  : in std_logic_vector(3 downto 0);     -- Intrucciones del Switch
        bus_datos : inout std_logic_vector(7 downto 0);  -- Bus de datos (incluye RAM)
        flag      : out std_logic_vector (2 downto 0);   -- Banderas de estado
        bus_dir   : out std_logic_vector(19 downto 0);   -- Bus de direcciones 19 bits
        bus_ctrl  : out std_logic_vector(4 downto 0);    -- Bus de Control para SRAM
        Disp_7sg  : out std_logic_vector(55 downto 0);   -- Despliegue en 7 segmentos para todos los display

        -- LCD
        Datos     : out std_logic_vector(7 downto 0);
        LCD_E, RS, RW : out std_logic
    );
end entity;


architecture control of  U_Control is
    -- Creacion de los registros

    signal AX   : std_logic_vector (15 downto 0) := "0000000000000000";  -- Reg. Acumulador
    signal PC   : unsigned(7 downto 0)           := "00000000";  -- Reg. contador de programa
    signal IX   : std_logic_vector (12 downto 0) := "0000000000000";  -- Reg. Indice
    signal inst : std_logic_vector (3 downto 0)  := "0000";  -- zero
    signal aux  : std_logic_vector (7 downto 0)  := "00000000";  -- auxiliar

    -- Constantes ascii para el nmemo
    constant C : std_logic_vector (7 downto 0) := X"43";
	constant L : std_logic_vector (7 downto 0) := X"4c";
	constant A : std_logic_vector (7 downto 0) := X"41";
	constant M : std_logic_vector (7 downto 0) := X"4d";
	constant O : std_logic_vector (7 downto 0) := X"4f";
	constant V : std_logic_vector (7 downto 0) := X"56";
	constant X : std_logic_vector (7 downto 0) := X"58";
	constant I : std_logic_vector (7 downto 0) := X"49";
	constant D : std_logic_vector (7 downto 0) := X"44";
	constant S : std_logic_vector (7 downto 0) := X"53";
	constant U : std_logic_vector (7 downto 0) := X"55";
	constant B : std_logic_vector (7 downto 0) := X"42";
	constant N : std_logic_vector (7 downto 0) := X"4e";
	constant T : std_logic_vector (7 downto 0) := X"54";
	constant R : std_logic_vector (7 downto 0) := X"52";
	constant E : std_logic_vector (7 downto 0) := X"45";
	constant Z : std_logic_vector (7 downto 0) := X"5a";
	constant Q : std_logic_vector (7 downto 0) := X"51";

    signal sw : std_logic := '1'; -- Controlador de refresco del LCD

    signal data : arreglo;  -- Primera linea del LCD: contiene la misma informaciÃƒÂ³n que los displays
    signal memo : arreglo;  -- Segunda linea del LCD: contiene el memo propuesto
begin
    UC : process(clk, clr, exe, ent_datos, ent_inst) begin

        if (clr = '0') then
            AX <= "0000000000000000";  -- Limpia el acumulador de 16 bits
            PC <= "00000000";  -- Limpia el contador de programa
            IX <= "0000000000000";  -- Limpia el indice
			flag <= (others => '0');
			data <= (others => X"FE");
            memo <= (others => X"FE");
            sw <= '1';

        elsif (rising_edge(clk)) then
            if (exe = '0') then  -- Fue presionado el boton de la ejecucion de instrucciones
                -- Pone en memo y data en espacios (o caracteres no validos)
                data <= (others => X"FE");
                memo <= (others => X"FE");
                -- Desactiva el refresco del LCD
                sw <= '0';

                case ent_inst is  -- Set de instrucciones

                    when "0000" =>  -- Instruccion CLA
                        AX <= "0000000000000000";  -- Limpia el acumulador
                        memo(0) <= C;
                        memo(1) <= L;
                        memo(2) <= A;

                      when "0001" =>  -- MOVX
                        AX(7 downto 0) <= ent_datos;  -- Carga la parte baja del acumulador con un dato
                        memo(0) <= M;
                        memo(1) <= O;
                        memo(2) <= V;
                        memo(3) <= X;

                    when "0010" =>  -- MOVIX
                        IX (7 downto 0) <= ent_datos;  -- Carga el registro indice con una direccion

                        bus_ctrl (0) <= '0';  -- Control del chip enable (con 0 se activa)
                        bus_ctrl (1) <= '0';  -- Control de salida y entrada (con 0 es salida)

                        bus_ctrl (2) <= '1';  -- Control de escritura/lectura (con 1 es solo lectura)
                        bus_ctrl (3) <= '0';  -- Control de byte bajo (con 0 se habilita el byte bajo)
                        bus_ctrl (4) <= '1';  -- Control de byte alto (con 1 se deshabilita el byte alto)

                        bus_dir <= std_logic_vector("0000000" & IX);  -- Se carga la direccion del registro IX con 11 ceros concatenados
                        AX <= std_logic_vector("00000000" & bus_datos);  -- Se carga AX con el dato de la direccion IX

                        memo(0) <= M;
                        memo(1) <= O;
                        memo(2) <= V;
                        memo(3) <= X;

                      when "0011" =>  -- MOVIA
                        IX (7 downto 0) <= ent_datos;  -- Carga el registro indice con una direccion

                        bus_ctrl (0) <= '0';  -- Control del chip enable (con 0 se activa)
                        bus_ctrl (1) <= '-';  -- Control de salida y entrada (indefinido)

                        bus_ctrl (2) <= '0';  -- Control de escritura/lectura (con 0 es solo escritura)
                        bus_ctrl (3) <= '0';  -- Control de byte bajo (con 0 se habilita el byte bajo)
                        bus_ctrl (4) <= '1';  -- Control de byte alto (con 1 se deshabilita el byte alto)

                        bus_dir <= std_logic_vector("0000000" & IX);  -- Se carga la direccion del registro IX
                        bus_datos <= AX (7 downto 0);  -- Se carga en la direccion de memoria el dato en AX

                        memo(0) <= M;
                        memo(1) <= O;
                        memo(2) <= V;
                        memo(3) <= I;
                        memo(4) <= A;

                      when "0100" =>  -- SUMA
                        -- Suma del acumulador con un dato y el resultado se almacena en el acumulador
                        ADD(AX(7 downto 0), ent_datos, flag, AX(7 downto 0));
                        memo(0) <= A;
                        memo(1) <= D;
                        memo(2) <= D;

                    when "0101" =>  -- RESTA
                        -- Resta del acumulador con un dato y el resultado se almacena en el acumulador
                        SUB(AX(7 downto 0), ent_datos, flag, AX(7 downto 0));
                        memo(0) <= S;
                        memo(1) <= U;
                        memo(2) <= B;

                    when "0110" =>  -- MULTIPLICACIÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…â€œN
                        -- Multiplica el acumulador con un dato y el resultado se almacena en el acumulador
                        MUL(AX(7 downto 0), ent_datos, flag, AX);
                        memo(0) <= M;
                        memo(1) <= U;
                        memo(2) <= L;

                    when "0111" =>  -- Compuerta AND
						andS(AX(7 downto 0), ent_datos, AX(7 downto 0));
                        memo(0) <= A;
                        memo(1) <= N;
                        memo(2) <= D;

                    when "1000" =>  -- Compuerta NOT
                        notS(AX(7 downto 0), ent_datos, AX(7 downto 0));
                        memo(0) <= N;
                        memo(1) <= O;
                        memo(2) <= T;

                    when "1001" =>  -- Compuerta NOR
                        norS(AX(7 downto 0), ent_datos, AX(7 downto 0));
                        memo(0) <= N;
                        memo(1) <= O;
                        memo(2) <= R;

                    when "1010" =>  -- Compuerta NAND
                        nandS(AX(7 downto 0), ent_datos, AX(7 downto 0));
                        memo(0) <= N;
                        memo(1) <= A;
                        memo(2) <= N;
                        memo(3) <= D;

                    when "1011" =>  -- Compuerta XOR
                        xorS(AX(7 downto 0), ent_datos, AX(7 downto 0));
                        memo(0) <= X;
                        memo(1) <= O;
                        memo(2) <= R;

                    when "1100" =>  -- Compuerta XNOR
                        xnorS(AX(7 downto 0), ent_datos, AX(7 downto 0));
                        memo(0) <= X;
                        memo(1) <= N;
                        memo(2) <= O;
                        memo(3) <= R;

                    when "1101" =>  -- Corrimiento a la izquierda
                        LDER(AX(7 downto 0), ent_datos, AX(7 downto 0));
                        memo(0) <= L;
                        memo(1) <= D;
                        memo(2) <= E;
                        memo(3) <= R;

                    when "1110" =>  -- Corrimiento a la derecha
                        LIZQ(AX(7 downto 0), ent_datos, AX(7 downto 0));
                        memo(0) <= L;
                        memo(1) <= I;
                        memo(2) <= Z;
                        memo(3) <= Q;

                    when others =>  -- Compuerta OR
                        -- OR del acumulador con un dato y el resultado se almacena en el acumulador
                        LOR(AX(7 downto 0), ent_datos, AX(7 downto 0));

                        memo(0) <= L;
                        memo(1) <= O;
                        memo(2) <= R;
                end case;

                PC <= PC + 1;  -- Incremento del contador de programa

            else
                -- Mostrando el contador de programa
                aux <= std_logic_vector(PC);
                bcd_conv(aux (3 downto 0), Disp_7sg(48 downto 42));  -- Mostrando el primer  nibble
                bcd_conv(aux (7 downto 4), Disp_7sg(55 downto 49));  -- Mostrando el segundo nibble

                ascii_conv(aux (3 downto 0), data(1));
                ascii_conv(aux (7 downto 4), data(0));

                -- Mostrando el registro indice
                bcd_conv(IX (3 downto 0), Disp_7sg(34 downto 28));  -- Mostrando el primer  nibble
                bcd_conv(IX (7 downto 4), Disp_7sg(41 downto 35));  -- Mostrando el segundo nibble

                ascii_conv(IX (3 downto 0), data(4));
                ascii_conv(IX (7 downto 4), data(3));

                -- Mostrando el codigo de la instruccion
                inst <= std_logic_vector(ent_inst);
                bcd_conv(inst, Disp_7sg(20 downto 14));  -- Mostrando el primer  nibble (REVISAR)
                ascii_conv(inst, data(7));

                inst <= "0000";
                bcd_conv(inst, Disp_7sg(27 downto 21));  -- Mostrando el segundo nibble
                ascii_conv(inst, data(6));

                -- Mostrando el dato en el acumulador
                bcd_conv(AX(3 downto 0), Disp_7sg(6 downto  0));  -- Mostrando el primer  nibble
                bcd_conv(AX(7 downto 4), Disp_7sg(13 downto 7));  -- Mostrando el segundo nibble

                ascii_conv(AX(3 downto 0), data(9));
                ascii_conv(AX(7 downto 4), data(8));

                actualizar_mensaje1(data);
                actualizar_mensaje2(memo);

                -- Activa el refresco del LCD
                sw <= '1';
            end if;
        end if;  -- Fin del if del CLK
    end process UC;

    LCD: LCD_comp port map(
        clr   => clr,
        clk   => clk,
        SW    => SW,
        Datos => Datos,
        E     => LCD_E,
        RS    => RS,
        RW    => RW
    );
end architecture;
