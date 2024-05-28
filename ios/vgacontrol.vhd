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
	constant S: integer := 10;
	constant P: integer := 2;
	constant Q: integer := 33;
	signal column_pixel_aux: integer := 0 ;
	signal active_region_horizontal: std_logic := '0';
	signal active_region_vertical: std_logic := '0';
	
begin
	horizontal: process(rst, clk_vga)
		variable count: integer:= 0;
	begin
		IF rst = '0' THEN
			count := 0;
			hsync_vga <= '0';
			column_pixel_aux <= 0;
			column_pixel <= 0;
			active_region_horizontal <= '0';
		ELSIF rising_edge(clk_vga) THEN
			IF count = 803 THEN
				count := 0;
				active_region_horizontal <= '1';
				column_pixel <= count;
				column_pixel_aux <= count;
				hsync_vga <= '1';
			ELSIF count <= 639 THEN
				active_region_horizontal <= '1';
				column_pixel <= count;
				column_pixel_aux <= count;
				hsync_vga <= '1';
			ELSIF count >= 640 and count <= 656 THEN
				active_region_horizontal <= '0';
				column_pixel <= count;
				column_pixel_aux <= count;
				hsync_vga <= '1';
			ELSIF count >= 657 and count <= 753 THEN
				active_region_horizontal <= '0';
				column_pixel <= count;
				column_pixel_aux <= count;
				hsync_vga <= '0';
			ELSIF count >= 754 and count <= 802 THEN
				active_region_horizontal <= '0';
				column_pixel <= count;
				column_pixel_aux <= count;
				hsync_vga <= '1';
			END IF;
			count := count + 1;
		END IF;
	end process horizontal;
	vertical: process(rst, clk_vga)
		variable count: integer:= 0;
	begin
		IF rst = '0' THEN
			count := 0;
			vsync_vga <= '0';
			row_pixel <= 0;
			active_region_vertical <= '0';
		ELSIF rising_edge(clk_vga) THEN
			IF column_pixel_aux = 802  then
				count := count + 1;
			END IF;
			IF count = 527 THEN
					count := 0;
					active_region_vertical <= '1';
					row_pixel <= count;
					vsync_vga <= '1';
			ELSIF count <= 479 THen
					active_region_vertical <= '1';
					row_pixel <= count;
					vsync_vga <= '1';
			ELSIF count >= 480 and count <= 490 THEN
					active_region_vertical <= '0';
					row_pixel <= count;
					vsync_vga <= '1';
			ELSIF count >= 491 and count <= 492 THEN
					active_region_vertical <= '0';
					row_pixel <= count;
					vsync_vga <= '0';
			ELSIF count >= 493 and count <= 526 then
					active_region_vertical <= '0';
					row_pixel <= count;
					vsync_vga <= '1';
				END IF;
		END IF;
	end process vertical;	
	active_region <= active_region_horizontal and active_region_vertical;
end behavior;