-- =====================================================================
--  SYNC_CONICS.vhd – Módulo de sincronía + figuras cónicas + texto
-- =====================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.conics_pkg.all;  -- nuevas figuras
use work.text_pkg.all;


entity SYNC_CONICS is
    port(
        CLK           : in  std_logic;
        HSYNC, VSYNC  : out std_logic;
        R, G, B       : out std_logic_vector(7 downto 0);
        KEYS          : in  std_logic_vector(3 downto 0);
        S             : in  std_logic_vector(1 downto 0);
		  Xpos_out      : out std_logic_vector(11 downto 0);  -- NUEVO
        Ypos_out      : out std_logic_vector(11 downto 0)   -- NUEVO
    );
end entity;

architecture MAIN of SYNC_CONICS is

    ------------------------------------------------------------------
    -- Constantes modo 1280×1024 @ 60 Hz, pixel‑clock 108 MHz
    ------------------------------------------------------------------
    signal HPOS : integer range 0 to 1688 := 0;
    signal VPOS : integer range 0 to 1066 := 0;

    -- Centro / vértice de la figura activa
    signal CX, CY : integer range 0 to 1688 := 640;

    signal DRAW  : std_logic;
    signal RGB_i : std_logic_vector(7 downto 0);
    --texto
	 signal DRAW_TEXT : std_logic;
	 --CORDENADAS
	 signal DRAW_COORD : std_logic;
begin
    ------------------------------------------------------------------
    -- Selección de la figura según los switches S(1 downto 0)
    ------------------------------------------------------------------
    
    TITLE(HPOS, VPOS, S, DRAW_TEXT);
	 COORDS(HPOS, VPOS, CX, CY, DRAW_COORD);
    process(CLK)
    begin
        if rising_edge(CLK) then
            ------------------------------------------------------------------
            --  A) Dibujar la figura seleccionada
            ------------------------------------------------------------------
            case S is
                when "00" => CIRCLE   (HPOS, VPOS, CX, CY, RGB_i, DRAW);
                when "01" => ELLIPSE  (HPOS, VPOS, CX, CY, RGB_i, DRAW);
                when "10" => PARABOLA (HPOS, VPOS, CX, CY, RGB_i, DRAW);
                when others => HYPERBOLA(HPOS, VPOS, CX, CY, RGB_i, DRAW);
            end case;

            -- =========================================================
            --  Mux de color: primero el texto, después la figura
            -- =========================================================
            if DRAW_TEXT = '1' then
                -- Prioridad más alta: la palabra (blanco fijo)
                R <= (others => '1');
                G <= (others => '1');
                B <= (others => '1');
            elsif DRAW_COORD = '1' then
                -- Cordenadas
                R <= (others => '1');
                G <= (others => '1');
                B <= (others => '1');
				elsif DRAW = '1' then
                -- Segundo nivel: la figura (blanco)
                R <= (others => '1');
                G <= (others => '1');
                B <= (others => '1');
            else
                -- Fondo negro
                R <= (others => '0');
                G <= (others => '0');
                B <= (others => '0');
            end if;

            ------------------------------------------------------------------
            --  B) Contadores H / V
            ------------------------------------------------------------------
            if HPOS < 1688 then
                HPOS <= HPOS + 1;
            else
                HPOS <= 0;
                if VPOS < 1066 then
                    VPOS <= VPOS + 1;
                else
                    VPOS <= 0;
                    -- actualizar posición con los botones al final de cada cuadro
                    if KEYS(0)='0' then CX <= CX + 5; end if; -- derecha
                    if KEYS(1)='0' then CX <= CX - 5; end if; -- izquierda
                    if KEYS(2)='0' then CY <= CY - 5; end if; -- arriba
                    if KEYS(3)='0' then CY <= CY + 5; end if; -- abajo
                end if;
            end if;
            Xpos_out <= std_logic_vector(to_unsigned(CX,12));
            Ypos_out <= std_logic_vector(to_unsigned(CY,12));
            ------------------------------------------------------------------
            --  C) Pulsos de sincronía VESA 1280×1024 @ 60 Hz
            ------------------------------------------------------------------
            If	( HPOS > 48 and HPOS < 160 ) then	
									HSYNC <= '0';
								Else
									HSYNC	<= '1';
								End If;
								
								If (VPOS > 0 and VPOS < 4) then
									VSYNC <= '0';
								Else
									VSYNC	<= '1';
								End If;
        end if;
    end process;

    ------------------------------------------------------------------
    --  D) Texto: nombre de la figura (opcional, placeholder)
    --      Podrías reutilizar la ROM de fuente existente o agregar una nueva.
    ------------------------------------------------------------------
end architecture;