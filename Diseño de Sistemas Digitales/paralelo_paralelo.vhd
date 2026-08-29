-- Programa de registro paralelo-paralelo
-- Elaborado por:
-- Fecha:

-- ********************** Declaracion de la biblioteca **********************

    Library ieee;
    use ieee.std_logic_1164.all;

-- ********************** Declaracion de la entidad *************************
    entity paralelo_paralelo is
        port(
                clk, clr: in std_logic;                        -- Entrada de reloj y reset
                D:        in std_logic_vector(7 downto 0);     -- Entrada de datos
                sel:      in std_logic_vector(3 downto 0);     -- Selector de registro
                ctrl:     in std_logic;                        -- Control de carga y descarga
                Q:        out std_logic_vector(7 downto 0)    -- Salida del registro
        );

    end paralelo_paralelo;

-- ********************** Declaracion de la arquitectura ********************
architecture registro of paralelo_paralelo is
        
        begin

            process(clk, clr, D, ctrl)                  -- Lista Sensible
                variable registro1: std_logic_vector(7 dowto 0);       -- Registro1
                variable registro2: std_logic_vector(7 dowto 0);       -- Registro2
                variable registro3: std_logic_vector(7 dowto 0);       -- Registro3
                variable registro4: std_logic_vector(7 dowto 0);       -- Registro4
                variable registro5: std_logic_vector(7 dowto 0);       -- Registro5
                variable registro6: std_logic_vector(7 dowto 0);       -- Registro6
                variable registro7: std_logic_vector(7 dowto 0);       -- Registro7
                variable registro8: std_logic_vector(7 dowto 0);       -- Registro8
                
                begin
                    if clr = '0' then                       -- Si hay un reset
                        Registro <= "X00";                  -- se borra el registro

                    else 
                        case ctrl then                      -- Si el control es
                            when '0' then                   -- Activado; almacena
                                registro <= D;
                            when others                     -- De lo contrario
                                Q <= Registro;              -- Extrae
                        end case;
                    end if;
            end process;                                -- fin del proceso
end registro;