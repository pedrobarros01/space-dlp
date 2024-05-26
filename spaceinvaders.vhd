library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.ios.all;

entity spaceinvaders is
port(
	reset: in std_logic;
	clk: in std_logic;
	h_sync: out std_logic;
	v_sync: out std_logic;
	row: out integer;
	column: out integer;
	region: out std_logic
);
end spaceinvaders;

architecture behavior of spaceinvaders is
	
begin
	vga: vgacontrol port map(
		rst => reset,
		clk_vga => clk,
		hsync_vga => h_sync,
		vsync_vga => v_sync,
		row_pixel => row,
		column_pixel => column,
		active_region => region
		
	);

end behavior;