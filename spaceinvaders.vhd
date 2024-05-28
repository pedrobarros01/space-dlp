library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.ios.all;
use spaceinvaders.controllergame.all;
use spaceinvaders.auxiliadores.all;

entity spaceinvaders is
port(
	resetgeral: in std_logic;
	clk: in std_logic;
	h_sync: out std_logic;
	v_sync: out std_logic;
	red: out std_logic;
	green: out std_logic;
	blue: out std_logic
);
end spaceinvaders;

architecture behavior of spaceinvaders is
	signal row: integer;
	signal column: integer;
	signal regionativa: std_logic;
	signal novoclock: std_logic;
	
	
begin
	divisor: divisorclock port map(
		clk => clk,
		reset => resetgeral,
		clkout => novoclock
	);
	vga: vgacontrol port map(
		rst => resetgeral,
		clk_vga => novoclock,
		hsync_vga => h_sync,
		vsync_vga => v_sync,
		row_pixel => row,
		column_pixel => column,
		active_region => regionativa
		
	);
	gene: pixelgen port map(
		reset => resetgeral,
		clock => novoclock, 
		region => regionativa,
		column_pixel => column,
		R => red,
		G => green,
		B => blue
	);

end behavior;