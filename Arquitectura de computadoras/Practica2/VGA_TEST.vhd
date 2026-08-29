

			library ieee;
			use ieee.std_logic_1164.all;
			use ieee.std_logic_unsigned.all;
			use ieee.numeric_std.all;

	--	Declaracion de la entidad
				
			Entity VGA_TEST Is
					PORT(
						CLOCK_50: IN STD_LOGIC;
						VGA_HS,VGA_VS,VGA_SYNC_N,VGA_BLANK_N,VGA_CLK:OUT STD_LOGIC;
						SW: STD_LOGIC_VECTOR(1 downto 0);
						KEY: STD_LOGIC_VECTOR(3 DOWNTO 0);
						VGA_R,VGA_B,VGA_G: OUT STD_LOGIC_VECTOR(7 downto 0);
						HEX7,HEX6,HEX5,HEX4,
                  HEX3,HEX2,HEX1,HEX0 : out std_logic_vector(6 downto 0)
					    );
			END VGA_TEST;
			
	--	Declaracion de la arquitectura --

			Architecture MAIN of VGA_TEST is
				Signal VGACLK,RESET:STD_LOGIC;
				signal Xpos_s, Ypos_s : std_logic_vector(11 downto 0);
	--	Declaracion del componente de sincronia			
	
			 COMPONENT SYNC_CONICS IS
					 PORT(
						CLK           : in  std_logic;
        HSYNC, VSYNC  : out std_logic;
        R, G, B       : out std_logic_vector(7 downto 0);
        KEYS          : in  std_logic_vector(3 downto 0);
        S             : in  std_logic_vector(1 downto 0);
		  Xpos_out      : out std_logic_vector(11 downto 0);  -- NUEVO
        Ypos_out      : out std_logic_vector(11 downto 0)   -- NUEVO

						);
			  END COMPONENT SYNC_CONICS;

			--	Declaracion del lazo de fase cerrado

				 component pll is
					  port (
							 clkin_clk   : in  std_logic := 'X'; -- clk
							 reset_reset : in  std_logic := 'X'; -- reset
							 clkout1_clk : out std_logic;        -- clk
							 clkout2_clk : out std_logic         -- clk
             			 );
				 END COMPONENT pll;
			-- Conversor coordenadas → displays
			component Coord_Display is
				 port(
					  Xpos : in  integer range 0 to 9999;
					  Ypos : in  integer range 0 to 9999;
					  HEX7,HEX6,HEX5,HEX4,
					  HEX3,HEX2,HEX1,HEX0 : out std_logic_vector(6 downto 0)
				 );
			end component Coord_Display;
 
				BEGIN
				
				VGA_BLANK_N <= '1';			-- La limpieza de pantalla no se hace directamente
				VGA_SYNC_N	<= '1';			--	No se usa la sincronia por color verde
				
				C: pll PORT MAP (CLOCK_50,RESET,VGA_CLK,VGACLK);
				C1: SYNC_CONICS PORT MAP(VGACLK,VGA_HS,VGA_VS,VGA_R,VGA_G,VGA_B,KEY,SW);
				-- >>> Instancia del módulo de displays <<<
            C2 : SYNC_CONICS
    port map (
        VGACLK, VGA_HS, VGA_VS,
        VGA_R,  VGA_G,  VGA_B,
        KEY, SW,
        Xpos_s, Ypos_s
    );
	 CD : Coord_Display
    port map (
        to_integer(unsigned(Xpos_s)),   -- Xpos
        to_integer(unsigned(Ypos_s)),   -- Ypos
        HEX7, HEX6, HEX5, HEX4,
        HEX3, HEX2, HEX1, HEX0
    );
			END MAIN;
 