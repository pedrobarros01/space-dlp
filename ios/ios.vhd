library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.ios.all;

package ios is
	component vgacontrol is 
	port(
		rst: in std_logic;
		clk_vga: in std_logic;
		hsync_vga: out std_logic;
		vsync_vga: out std_logic;
		row_pixel: out integer;
		column_pixel: out integer;
		active_region: out std_logic
	);
	end component;
end package;