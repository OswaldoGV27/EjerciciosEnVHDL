-- Programa de registro serie-paralelo
-- Elaborado por:
-- Fecha:

-- ********************** Declaracion de la biblioteca **********************

    Library ieee;
    use ieee.std_logic_1164.all;

-- ********************** Declaracion de la entidad *************************
    entity serie_paralelo is
        
        port(
                clk, clr: in std_logic;     -- Declaracion de entradas
                D:        in std_logic;     -- Entrada del registro
                ctrl:     in std_logic;     -- Control de carga y salida
                Q:        out std_logic_vector (7 downto 0)   -- Salida del registro
        );

    end serie_paralelo;

-- ********************** Declaracion de la arquitectura ********************
architecture registro of serie_paralelo is

    signal      RSP: std_logic_vector(7 dowto 0);       -- Creacion del registro de 8 bits
        
        begin

            process(clk, clr, D, ctrl)                  -- Este es un proceso para realizar (Completar)
                
                begin
                    if clr = '0' then                   -- Si hay un reset
                        RSP <= "X00";                  -- se borra el registro
                    
                    elsif (clk'event and clk = '1') then    -- Todo se ejecuta con el reloj
                        for i in 0 to 7 loop            -- Declaracion del for
                            case ctrl is                -- Declaracion del case

                                when '0' =>             -- Almacena la entrada
                                    RSP(i) <= D;        -- Almacena un dato

                                when others =>          -- Extrayendo el dato
                                Q <= RSP;            -- Extrayendo en una exhibicion

                            end case;
                        end loop;
                    end if;
            end process;                                -- fin del proceso
end registro;