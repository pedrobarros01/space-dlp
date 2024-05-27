library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.ios.all;
use spaceinvaders.controllergame.all;
use spaceinvaders.auxiliadores.all;

entity spaceinvaders is
port(
	reset: in std_logic;
	clk: in std_logic;
	h_sync: out std_logic;
	v_sync: out std_logic;
	red: out std_logic_vector(3 downto 0);
	green: out std_logic_vector(3 downto 0);
	blue: out std_logic_vector(3 downto 0)
);
end spaceinvaders;

architecture behavior of spaceinvaders is
	signal row: integer;
	signal column: integer;
	signal region: std_logic;
	signal novoclock: std_logic;
	
	
begin
	divisor: divisorclock port map(
		clk => clk,
		clkout => novoclock
	);
	vga: vgacontrol port map(
		rst => reset,
		clk_vga => novoclock,
		hsync_vga => h_sync,
		vsync_vga => v_sync,
		row_pixel => row,
		column_pixel => column,
		active_region => region
		
	);
	gene: pixelgen port map(
		reset => reset,
		clock => novoclock, 
		region => region,
		column_pixel => column,
		r => red,
		g => green,
		b => blue
	);

end behavior;