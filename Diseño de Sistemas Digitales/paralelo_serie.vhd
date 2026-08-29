-- Programa de registro paralelo-serie
-- Elaborado por:
-- Fecha:

-- ********************** Declaracion de la biblioteca **********************

    Library ieee;
    use ieee.std_logic_1164.all;

-- ********************** Declaracion de la entidad *************************
    entity paralelo_serie is
        
        port(
                clk, clr: in std_logic;     -- Declaracion de entradas
                D:        in std_logic_vector (7 downto 0);     -- Entrada del registro
                ctrl:     in std_logic;     -- Control de carga y salida
                Q:        out std_logic    -- Salida del registro
        );

    end paralelo_serie;

-- ********************** Declaracion de la arquitectura ********************
architecture registro of paralelo_serie is

    signal      RPS: std_logic_vector(7 dowto 0);       -- Creacion del registro de 4 bits
        
        begin

            process(clk, clr, D, ctrl)                  -- Este es un proceso para realizar (Completar)
                
                begin
                    if clr = '0' then                   -- Si hay un reset
                        RPS <= "X00";                  -- se borra el registro
                    
                    elsif (clk'event and clk = '1') then    -- Todo se ejecuta con el reloj
                        for i in 0 to 3 loop            -- Declaracion del for
                            case ctrl is                -- Declaracion del case

                                when '0' =>             -- Almacena la entrada
                                    RPS <= D;        -- Almacena un dato directo

                                when others =>          -- Extrayendo el dato
                                Q <= RPS(i);            -- Extrayendo bit por bit

                            end case;
                        end loop;
                    end if;
            end process;                                -- fin del proceso
end registro;