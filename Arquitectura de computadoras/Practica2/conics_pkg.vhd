-- =====================================================================
--  conics_pkg.vhd  –  Paquete de procedimientos para figuras cónicas
-- =====================================================================
--  Cada procedimiento recibe:
--     Xcur, Ycur : posición actual del haz (contador HPOS / VPOS)
--     Xpos, Ypos : centro de la figura (para círculo/elipse) o vértice (parábola),
--                  foco izquierdo (hipérbola).  Mantiene compatibilidad con SQ.
--     RGB        : bus de 8 bits de color (solo se escribe si DRAW = '1').
--     DRAW       : bandera — '1' cuando el píxel pertenece a la figura.
--  NOTA: a efectos de síntesis solo modificamos DRAW; el color final se decide
--        fuera, igual que con el antiguo procedimiento SQ.
-- =====================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package conics_pkg is
    -- Mantener misma firma que SQ para plug‑and‑play
    procedure CIRCLE  (signal Xcur,Ycur,Xpos,Ypos : in  integer;
                       signal RGB                : out std_logic_vector(7 downto 0);
                       signal DRAW               : out std_logic);
    procedure ELLIPSE (signal Xcur,Ycur,Xpos,Ypos : in  integer;
                       signal RGB                : out std_logic_vector(7 downto 0);
                       signal DRAW               : out std_logic);
    procedure PARABOLA(signal Xcur,Ycur,Xpos,Ypos : in  integer;
                       signal RGB                : out std_logic_vector(7 downto 0);
                       signal DRAW               : out std_logic);
    procedure HYPERBOLA(signal Xcur,Ycur,Xpos,Ypos : in  integer;
                       signal RGB                : out std_logic_vector(7 downto 0);
                       signal DRAW               : out std_logic);
end conics_pkg;

package body conics_pkg is
    --------------------------------------------------------------------
    --  CIRCLE  (radio fijo = 150 px)
    --------------------------------------------------------------------
    procedure CIRCLE(signal Xcur,Ycur,Xpos,Ypos : in integer;
                      signal RGB : out std_logic_vector(7 downto 0);
                      signal DRAW: out std_logic) is
        constant R2 : integer := 150*150;  -- radio^2
        variable dx,dy : integer;
    begin
        dx := Xcur - Xpos;
        dy := Ycur - Ypos;
        if (dx*dx + dy*dy) <= R2 then
            DRAW <= '1';
        else
            DRAW <= '0';
        end if;
    end procedure;

    --------------------------------------------------------------------
    --  ELLIPSE  (a=200, b=100)
    --------------------------------------------------------------------
    procedure ELLIPSE(signal Xcur,Ycur,Xpos,Ypos : in integer;
                  signal RGB  : out std_logic_vector(7 downto 0);
                  signal DRAW : out std_logic) is
    constant a2 : integer := 200*200;    -- 40 000
    constant b2 : integer := 100*100;    -- 10 000
    variable dx,dy : integer;

    subtype s48 is signed(47 downto 0);
    subtype s96 is signed(95 downto 0);
    variable lhs96, rhs96 : s96;
begin
    dx := Xcur - Xpos;
    dy := Ycur - Ypos;

    lhs96 :=
        resize( s48(to_signed(dx*dx,48)) * s48(to_signed(b2,48)), 96) +
        resize( s48(to_signed(dy*dy,48)) * s48(to_signed(a2,48)), 96);

    rhs96 := s96(to_signed(a2*b2,96));   -- 400 000 en 96 bits

    if lhs96 <= rhs96 then
        DRAW <= '1';
    else
        DRAW <= '0';
    end if;
end procedure;

    --------------------------------------------------------------------
    --  PARABOLA  4p = 200  (p = 50)  eje horizontal, abre a la derecha
    --------------------------------------------------------------------
    procedure PARABOLA(signal Xcur,Ycur,Xpos,Ypos : in integer;
                       signal RGB : out std_logic_vector(7 downto 0);
                       signal DRAW: out std_logic) is
        constant four_p : integer := 200; -- 4p
        variable dx,dy : integer;
    begin
        dx := Xcur - Xpos;
        dy := Ycur - Ypos;
        if dx >= 0 and (dy*dy) <= (four_p*dx) then
            DRAW <= '1';
        else
            DRAW <= '0';
        end if;
    end procedure;

    --------------------------------------------------------------------
    --  HYPERBOLA  (horizontal)  (x^2/a^2) - (y^2/b^2) = 1
    --  a = 150, b = 75  →  a^2=22500, b^2=5625
    --------------------------------------------------------------------
    procedure HYPERBOLA(signal Xcur,Ycur,Xpos,Ypos : in integer;
                    signal RGB  : out std_logic_vector(7 downto 0);
                    signal DRAW : out std_logic) is
    constant a2 : integer := 150*150;    -- 22 500
    constant b2 : integer :=  75*75;     --  5 625
    variable dx,dy : integer;

    subtype s48 is signed(47 downto 0);
    subtype s96 is signed(95 downto 0);
    variable lhs96, rhs96 : s96;
begin
    dx := abs(Xcur - Xpos);
    dy := abs(Ycur - Ypos);

    lhs96 :=
        resize( s48(to_signed(dx*dx,48)) * s48(to_signed(b2,48)), 96) -
        resize( s48(to_signed(dy*dy,48)) * s48(to_signed(a2,48)), 96);

    rhs96 := s96(to_signed(a2*b2,96));   -- 126 562 5 en 96 bits

    if lhs96 >= rhs96 then
        DRAW <= '1';
    else
        DRAW <= '0';
    end if;
end procedure;
end package body;
