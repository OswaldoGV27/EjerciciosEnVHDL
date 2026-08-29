-- Programa de registro R_serie_serie
-- Elaborado por:
-- Fecha:

-- ********************** Declaracion de la biblioteca **********************

    Library ieee;
    use ieee.std_logic_1164.all;

-- ********************** Declaracion de la entidad *************************
    entity R_serie_serie is
        port(
                clk, clr: in std_logic;                        -- Entrada de reloj y reset
                D:        in std_logic_vector(7 downto 0);     -- Entrada de datos
                sel:      in std_logic_vector(3 downto 0);     -- Selector de registro
                ctrl:     in std_logic;                        -- Control de carga y descarga
                HEX0:     out std_logic_vector(6 downto 0);    -- Display 0
                HEX1:     out std_logic_vector(6 downto 0);    -- Display 1
                Q:        out std_logic_vector(7 downto 0)     -- Salida del registro
        );

    end R_serie_serie;

-- ********************** Declaracion de la arquitectura ********************
architecture data of R_serie_serie is

-- Declaracion de constantes

    constant zero: std_logic_vector(6 downto 0) := "1000000";
    constant mono: std_logic_vector(6 downto 0) := "1111001";
    constant duo: std_logic_vector(6 downto 0) := "0100100";
    constant trio: std_logic_vector(6 downto 0) := "0110000";
    constant tetr: std_logic_vector(6 downto 0) := "0011001";
    constant quin: std_logic_vector(6 downto 0) := "0010010";
    constant sixt: std_logic_vector(6 downto 0) := "0000010";
    constant hept: std_logic_vector(6 downto 0) := "1111000";
    constant octo: std_logic_vector(6 downto 0) := "0000000";
    constant nano: std_logic_vector(6 downto 0) := "0011000";
    constant alfa: std_logic_vector(6 downto 0) := "0001000";
    constant beta: std_logic_vector(6 downto 0) := "0000011";
    constant cobr: std_logic_vector(6 downto 0) := "1000110";
    constant delt: std_logic_vector(6 downto 0) := "0100001";
    constant eco: std_logic_vector(6 downto 0) := "0000110";
    constant fuck: std_logic_vector(6 downto 0) := "0001110";
        
        begin
        
        -- La dalida decodificada en 7 segmentos
            whit Q(3 downto 0) select
                HEX0 <= zero when "0000",
                        mono when "0001",
                        duo when "0010",
                        trio when "0011", 
                        tetr when "0100",
                        quin when "0101", 
                        sixt when "0110", 
                        hept when "0111", 
                        octo when "1000",
                        nano when "1001", 
                        alfa when "1010", 
                        beta when "1011", 
                        cobr when "1100", 
                        delt when "1101", 
                        eco when "1110", 
                        fuck when others;
                
                HEX1 <= zero when "0000",
                        mono when "0001",
                        duo when "0010",
                        trio when "0011", 
                        tetr when "0100",
                        quin when "0101", 
                        sixt when "0110", 
                        hept when "0111", 
                        octo when "1000",
                        nano when "1001", 
                        alfa when "1010", 
                        beta when "1011", 
                        cobr when "1100", 
                        delt when "1101", 
                        eco when "1110", 
                        fuck when others; 

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
                        Registro1 <= "X00";                  -- se borra el registro
                        Registro2 <= X'00';
                        Registro3 <= X'00';
                        Registro4 <= X'00';
                        Registro5 <= X'00';
                        Registro6 <= X'00';
                        Registro7 <= X'00';
                        Registro8 <= X'00';
                    else 
                        if (ctrl = '1') then            -- Declaracion del registro
                        case sel is                    
                            when "0000" then                  
                                registro1 <= D;
                            when "0001" then                  
                                registro2 <= D;
                            when "0010" then                  
                                registro3 <= D;
                            when "0011" then                  
                                registro4 <= D;
                            when "0100" then                  
                                registro5 <= D;
                            when "0101" then                  
                                registro6 <= D;
                            when "0110" then                  
                                registro7 <= D;
                            when others
                                registro8 <= D;
                        end case;                  
                    
                    else
                        case sel is
                            when "0000" then                  
                                Q <= registro1;
                            when "0001" then                  
                                Q <= registro2;
                            when "0010" then                  
                                Q <= registro3;
                            when "0011" then                  
                                Q <= registro4;
                            when "0100" then                  
                                Q <= registro5;
                            when "0101" then                  
                                Q <= registro6;
                            when "0110" then                  
                                Q <= registro7;
                            when others
                                Q <= registro8;
                        end case; 
                        end if;
                    end if;
            end process;                                -- fin del proceso
end data;