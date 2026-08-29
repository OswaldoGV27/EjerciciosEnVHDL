-- Programa de registro serie-serie
-- Elaborado por:
-- Fecha:

-- ********************** Declaracion de la biblioteca **********************

    Library ieee;
    use ieee.std_logic_1164.all;

-- ********************** Declaracion de la entidad *************************
    entity serie_serie is
        
        port(
                clk, clr: in std_logic;     -- Declaracion de entradas
                D:        in std_logic;     -- Entrada del registro
                ctrl:     in std_logic;     -- Control de carga y salida
                Q:        out std_logic    -- Salida del registro
        );

    end serie_serie;

-- ********************** Declaracion de la arquitectura ********************
architecture registro of serie_serie is

    signal      RSS: std_logic_vector(3 dowto 0);       -- Creacion del registro de 4 bits
        
        begin

            process(clk, clr, D, ctrl)                  -- Este es un proceso para realizar (Completar)
                
                begin
                    if clr = '0' then                   -- Si hay un reset
                        RSS <= "0000";                  -- se borra el registro
                    
                    elsif (clk'event and clk = '1') then    -- Todo se ejecuta con el reloj
                        for i in 0 to 3 loop            -- Declaracion del for
                            case ctrl is                -- Declaracion del case

                                when '0' =>             -- Almacena la entrada
                                    RSS(i) <= D;        -- Almacena un dato

                                when others =>          -- Extrayendo el dato
                                Q <= RSS(i);            -- Extrayendo bit por bit

                            end case;
                        end loop;
                    end if;
            end process;                                -- fin del proceso
end registro;