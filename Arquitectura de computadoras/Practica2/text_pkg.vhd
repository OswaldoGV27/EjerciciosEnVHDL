-- =====================================================================
--  text_pkg.vhd  –  Procedimiento TITLE (2× escala, palabras completas)
-- =====================================================================
--  Palabras en español SIN acento: "CIRCULO", "ELIPSE", "PARABOLA", "HIPERBOLA".
--  Longitud máxima = 9 caracteres; fuente 8×8 expandida a 16×16.
-- =====================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package text_pkg is
    procedure TITLE(
        signal Xcur     : in integer;
        signal Ycur     : in integer;
        signal S        : in std_logic_vector(1 downto 0);
        signal DRAW_TXT : out std_logic
    );
	 procedure COORDS(
        signal Xcur, Ycur : in  integer;
        signal Xpos, Ypos : in  integer;
        signal DRAW_NUM   : out std_logic
    );
end package;
package body text_pkg is
    --------------------------------------------------------------------
    -- Parámetros
    --------------------------------------------------------------------
    constant PIXEL_SCALE : integer := 2;
    constant TEXT_X_START : integer := 200;
    constant TEXT_Y_START : integer := 100;
    constant GLYPH_W      : integer := 8;
    constant GLYPH_H      : integer := 8;
    constant GLYPH_W_VIS  : integer := GLYPH_W * PIXEL_SCALE; -- 16
    constant GLYPH_H_VIS  : integer := GLYPH_H * PIXEL_SCALE; -- 16
    constant SPACING      : integer := 2;
    constant CHARS        : integer := 9;                     -- ahora 9
    constant LINE_WIDTH_PX: integer := CHARS*(GLYPH_W_VIS+SPACING) - SPACING;

    --------------------------------------------------------------------
    -- Tipos & fuente 8×8 (letras A‑Z + espacio)
    --------------------------------------------------------------------
    subtype row_t   is std_logic_vector(GLYPH_W-1 downto 0);
    type    glyph_t is array(0 to GLYPH_H-1) of row_t;

	 --------------------------------------------------------------------
    -- Definición de letras 8×8 (ASCII art)
    --------------------------------------------------------------------
    constant FONT_C : glyph_t := (
        "00111100",
        "01100010",
        "11000000",
        "11000000",
        "11000000",
        "11000000",
        "01100010",
        "00111100"
    );

    constant FONT_I : glyph_t := (
        "00111100",
        "00011000",
        "00011000",
        "00011000",
        "00011000",
        "00011000",
        "00011000",
        "00111100"
    );

    constant FONT_R : glyph_t := (
        "01111100",
        "01000100",
        "01000100",
        "01111100",
        "01101000",
        "01011000",
        "01001100",
        "01000110"
    );

    constant FONT_L : glyph_t := (
        "11000000",
        "11000000",
        "11000000",
        "11000000",
        "11000000",
        "11000000",
        "11111110",
        "11111110"
    );

    constant FONT_E : glyph_t := (
        "11111110",
        "11000000",
        "11000000",
        "11111100",
        "11111100",
        "11000000",
        "11000000",
        "11111110"
    );

    constant FONT_P : glyph_t := (
        "11111100",
        "11000110",
        "11000110",
        "11111100",
        "11000000",
        "11000000",
        "11000000",
        "11000000"
    );

    constant FONT_A : glyph_t := (
        "00111000",
        "01101100",
        "11000110",
        "11000110",
        "11111110",
        "11000110",
        "11000110",
        "11000110"
    );

    constant FONT_B : glyph_t := (
        "11111100",
        "11000110",
        "11000110",
        "11111100",
        "11000110",
        "11000110",
        "11000110",
        "11111100"
    );

    constant FONT_O : glyph_t := (
        "00111100",
        "01100110",
        "11000011",
        "11000011",
        "11000011",
        "11000011",
        "01100110",
        "00111100"
    );

    constant FONT_H : glyph_t := (
        "11000110",
        "11000110",
        "11000110",
        "11111110",
        "11111110",
        "11000110",
        "11000110",
        "11000110"
    );

    constant FONT_Y : glyph_t := (
        "11000110",
        "11000110",
        "01101100",
        "00111000",
        "00010000",
        "00110000",
        "00110000",
        "11111000"
    );
	 
	 constant FONT_X : glyph_t := (
    "11000011",
    "01100110",
    "00111100",
    "00011000",
    "00011000",
    "00111100",
    "01100110",
    "11000011"
);
    
	 -- Letra U
    constant FONT_U : glyph_t := (
        "11000110",
        "11000110",
        "11000110",
        "11000110",
        "11000110",
        "11000110",
        "01100110",
        "00111100"
    );

    -- Letra S
    constant FONT_S : glyph_t := (
        "00111110",
        "01100000",
        "01100000",
        "00111100",
        "00000110",
        "00000110",
        "01100110",
        "00111100"
    );
    -- 8×8 espacio en blanco
    constant FONT_SPC : glyph_t := (
        "00000000",
        "00000000",
        "00000000",
        "00000000",
        "00000000",
        "00000000",
        "00000000",
        "00000000"
    );
    --Numeros del 0 al 9
	 constant FONT_0 : glyph_t := (
        "00111100",
        "01100110",
        "11001110",
        "11011110",
        "11110110",
        "11100110",
        "01100110",
        "00111100"
    );

    constant FONT_1 : glyph_t := (
        "00011000",
        "00111000",
        "01111000",
        "00011000",
        "00011000",
        "00011000",
        "00011000",
        "01111110"
    );

    constant FONT_2 : glyph_t := (
        "00111100",
        "01100110",
        "00000110",
        "00001100",
        "00011000",
        "00110000",
        "01100000",
        "01111110"
    );

    constant FONT_3 : glyph_t := (
        "00111100",
        "01100110",
        "00000110",
        "00011100",
        "00000110",
        "00000110",
        "01100110",
        "00111100"
    );

    constant FONT_4 : glyph_t := (
        "00001100",
        "00011100",
        "00111100",
        "01101100",
        "11001100",
        "11111110",
        "00001100",
        "00001100"
    );

    constant FONT_5 : glyph_t := (
        "01111110",
        "01100000",
        "01100000",
        "01111100",
        "00000110",
        "00000110",
        "01100110",
        "00111100"
    );

    constant FONT_6 : glyph_t := (
        "00111100",
        "01100000",
        "11000000",
        "11111100",
        "11000110",
        "11000110",
        "01100110",
        "00111100"
    );

    constant FONT_7 : glyph_t := (
        "01111110",
        "00000110",
        "00001100",
        "00011000",
        "00110000",
        "00110000",
        "00110000",
        "00110000"
    );

    constant FONT_8 : glyph_t := (
        "00111100",
        "01100110",
        "01100110",
        "00111100",
        "01100110",
        "01100110",
        "01100110",
        "00111100"
    );

    constant FONT_9 : glyph_t := (
        "00111100",
        "01100110",
        "01100110",
        "01100110",
        "00111110",
        "00000110",
        "00001100",
        "00111000"
    );
	 
	 constant FONT_EQ : glyph_t := (
    "00000000","01111110","00000000","00000000",
    "00000000","01111110","00000000","00000000"
);
    --------------------------------------------------------------------
    -- Palabras completas (relleno con espacios hasta 9)
    --------------------------------------------------------------------
    type word_t is array(0 to CHARS-1) of glyph_t;
    constant WORD_CIRCULO : word_t := (
        FONT_C, FONT_I, FONT_R, FONT_C, FONT_U, FONT_L, FONT_O, FONT_SPC, FONT_SPC);

    constant WORD_ELIPSE  : word_t := (
        FONT_E, FONT_L, FONT_I, FONT_P, FONT_S, FONT_E, FONT_SPC, FONT_SPC, FONT_SPC);

    constant WORD_PARABOLA: word_t := (
        FONT_P, FONT_A, FONT_R, FONT_A, FONT_B, FONT_O, FONT_L, FONT_A, FONT_SPC);

    constant WORD_HIPERBOLA: word_t := (
        FONT_H, FONT_I, FONT_P, FONT_E, FONT_R, FONT_B, FONT_O, FONT_L, FONT_A);
    --Arreglo de numeros
	 type digit_vec is array(0 to 9) of glyph_t;
    constant DIGITS : digit_vec := (
    FONT_0, FONT_1, FONT_2, FONT_3, FONT_4,
    FONT_5, FONT_6, FONT_7, FONT_8, FONT_9
);
	--------------------------------------------------------------------
    -- Función auxiliar: entero → cadena de 4 dígitos con ceros delante
    --------------------------------------------------------------------
    function int2str4(val : integer) return string is
        variable s : string(1 to 4) := (others => '0');
        variable v : integer := val;
    begin
        for i in 4 downto 1 loop
            s(i) := character'val(48 + (v mod 10)); -- '0' = 48
            v    := v / 10;
        end loop;
        return s;
    end function;
    --------------------------------------------------------------------
    -- Procedimiento TITLE
    --------------------------------------------------------------------
    procedure TITLE(signal Xcur, Ycur : in integer;
                    signal S         : in std_logic_vector(1 downto 0);
                    signal DRAW_TXT  : out std_logic) is
        variable sel_word : word_t := WORD_CIRCULO;
        variable char_idx : integer;
        variable glyph_x, glyph_y : integer;
        variable bit_on   : boolean := false;
    begin
        case S is
            when "00"   => sel_word := WORD_CIRCULO;
            when "01"   => sel_word := WORD_ELIPSE;
            when "10"   => sel_word := WORD_PARABOLA;
            when others  => sel_word := WORD_HIPERBOLA;
        end case;

        if (Xcur >= TEXT_X_START) and (Xcur < TEXT_X_START + LINE_WIDTH_PX) and
           (Ycur >= TEXT_Y_START) and (Ycur < TEXT_Y_START + GLYPH_H_VIS) then

            char_idx := (Xcur - TEXT_X_START) / (GLYPH_W_VIS + SPACING);
            glyph_x  := (Xcur - TEXT_X_START) mod (GLYPH_W_VIS + SPACING);
            glyph_y  := Ycur - TEXT_Y_START;

            if (char_idx < CHARS) and (glyph_x < GLYPH_W_VIS) then
                if sel_word(char_idx)(glyph_y / PIXEL_SCALE)(GLYPH_W-1 - glyph_x / PIXEL_SCALE) = '1' then
                    bit_on := true;
                end if;
            end if;
        end if;

        if bit_on then
            DRAW_TXT <= '1';
        else
            DRAW_TXT <= '0';
        end if;
    end procedure;
	 -------------------------------------------------------------------
    --  Procedimiento COORDS  ("X=####  Y=####")
    --------------------------------------------------------------------
    constant COORD_X : integer := 200;
    constant COORD_Y : integer := 140;  -- bajo el título
    constant COLS    : integer := 13;   -- X =  Y =
    constant COORD_W : integer := COLS*(GLYPH_W_VIS+SPACING) - SPACING;

    procedure COORDS(signal Xcur,Ycur : in integer;
                     signal Xpos,Ypos : in integer;
                     signal DRAW_NUM  : out std_logic) is
        variable strX, strY : string(1 to 4);
        variable cidx       : integer;
        variable gx,gy      : integer;
        variable gsel       : glyph_t := FONT_SPC;
        variable bit_on     : boolean := false;
    begin
        strX := int2str4(Xpos);
        strY := int2str4(Ypos);

        if (Xcur >= COORD_X) and (Xcur < COORD_X + COORD_W) and
           (Ycur >= COORD_Y) and (Ycur < COORD_Y + GLYPH_H_VIS) then

            cidx := (Xcur - COORD_X) / (GLYPH_W_VIS + SPACING);
            gx   := (Xcur - COORD_X) mod (GLYPH_W_VIS + SPACING);
            gy   := Ycur - COORD_Y;

            -- Selección de glifo según columna
            case cidx is
                when 0  => gsel := FONT_X;
                when 1  => gsel := FONT_EQ;
                when 2  => gsel := DIGITS(character'pos(strX(1))-48);
                when 3  => gsel := DIGITS(character'pos(strX(2))-48);
                when 4  => gsel := DIGITS(character'pos(strX(3))-48);
                when 5  => gsel := DIGITS(character'pos(strX(4))-48);
                when 6  => gsel := FONT_SPC;
                when 7  => gsel := FONT_Y;
                when 8  => gsel := FONT_EQ;
                when 9  => gsel := DIGITS(character'pos(strY(1))-48);
                when 10 => gsel := DIGITS(character'pos(strY(2))-48);
                when 11 => gsel := DIGITS(character'pos(strY(3))-48);
                when 12 => gsel := DIGITS(character'pos(strY(4))-48);
                when others => gsel := FONT_SPC;
            end case;

            if gx < GLYPH_W_VIS then
                if gsel(gy/PIXEL_SCALE)(GLYPH_W-1 - gx/PIXEL_SCALE)='1' then
                    bit_on := true;
                end if;
            end if;
        end if;
        if bit_on then
            DRAW_NUM <= '1';
        else
            DRAW_NUM <= '0';
        end if;
        
    end procedure;
end package body;