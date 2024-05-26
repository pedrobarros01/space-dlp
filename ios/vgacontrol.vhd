library ieee;
use ieee.std_logic_1164.all;


entity vgacontrol is
port(
	rst: in std_logic;
	clk_vga: in std_logic;
	hsync_vga: out std_logic;
	vsync_vga: out std_logic;
	row_pixel: out integer;
	column_pixel: out integer;
	active_region: out std_logic
);
end vgacontrol;


architecture behavior of vgacontrol is
	constant D: integer := 640;
	constant E: integer := 16;
	constant B: integer := 96;
	constant C: integer := 48;
	constant R: integer := 480;
	constant S: integer := 11;
	constant P: integer := 2;
	constant Q: integer := 31;
	signal column_pixel_aux: integer := 0 ;
	signal active_region_horizontal: std_logic := '0';
	signal active_region_vertical: std_logic := '0';
	
begin
	horizontal: process(rst, clk_vga)
		variable count: integer range 0 to 800 := 0;
	begin
		IF rst = '0' THEN
			count := 0;
			hsync_vga <= '0';
			column_pixel_aux <= 0;
			column_pixel <= 0;
			active_region_horizontal <= '0';
		ELSIF rising_edge(clk_vga) THEN
			IF count = D + E + B + C THEN
				count := 0;
				active_region_horizontal <= '1';
				column_pixel <= count;
				column_pixel_aux <= count;
				hsync_vga <= '1';
			ELSIF count <= D - 1 THEN
				active_region_horizontal <= '1';
				column_pixel <= count;
				column_pixel_aux <= count;
				hsync_vga <= '1';
			ELSIF count >= D and count <= D + E - 1 THEN
				active_region_horizontal <= '0';
				column_pixel <= count;
				column_pixel_aux <= count;
				hsync_vga <= '1';
			ELSIF count >= D + E and count <= D + E + B - 1 THEN
				active_region_horizontal <= '0';
				column_pixel <= count;
				column_pixel_aux <= count;
				hsync_vga <= '0';
			ELSIF count >= D + E + B and count <= D + E + B + c - 1 THEN
				active_region_horizontal <= '0';
				column_pixel <= count;
				column_pixel_aux <= count;
				hsync_vga <= '1';
			END IF;
			count := count + 1;
		END IF;
	end process horizontal;
	vertical: process(rst, clk_vga)
		variable count: integer range 0 to 524 := 0;
	begin
		IF rst = '0' THEN
			count := 0;
			vsync_vga <= '0';
			row_pixel <= 0;
			active_region_vertical <= '0';
		ELSIF rising_edge(clk_vga) THEN
			IF column_pixel_aux = 799  then
				count := count + 1;
				IF count = R + S + P + Q THEN
					count := 0;
					active_region_vertical <= '1';
					row_pixel <= count;
					vsync_vga <= '1';
				ELSIF count <= R - 1 THen
					active_region_vertical <= '1';
					row_pixel <= count;
					vsync_vga <= '1';
				ELSIF count >= R and count <= R + S - 1 THEN
					active_region_vertical <= '0';
					row_pixel <= count;
					vsync_vga <= '1';
				ELSIF count >= R + S and count <= R + S + P - 1 THEN
					active_region_vertical <= '0';
					row_pixel <= count;
					vsync_vga <= '0';
				ELSIF count <= R + S + P and count <= R + S + P + Q - 1 then
					active_region_vertical <= '0';
					row_pixel <= count;
					vsync_vga <= '1';
				END IF;
			END IF;
		END IF;
	end process vertical;	
	active_region <= active_region_horizontal and active_region_vertical;
end behavior;