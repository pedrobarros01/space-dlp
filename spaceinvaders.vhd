library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.ios.all;
use spaceinvaders.controllergame.all;
use spaceinvaders.auxiliadores.all;
use spaceinvaders.tipagens.all;

entity spaceinvaders is
port(
	resetgeral: in std_logic;
	clk: in std_logic;
	movimentoplayer: in std_logic_vector(0 to 1);
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
	signal novoclockplayer: std_logic;
	signal pixel_list_coordinates_inv: list_coordinates_invasores;
	signal coordinate_player: list_coordinates_players;
	
	
begin
	onehertz: clockdivideronehertz port map(
		clk => clk,
		reset => resetgeral,
		clkout => novoclockplayer
	
	);
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
	invs: invaderships port map(
		reset => resetgeral,
		clock => novoclock, 
		pixel_invasores => pixel_list_coordinates_inv
	);
	player: playership port map(
		reset => resetgeral,
		clock => novoclockplayer,
		player => 0,
		movimento => movimentoplayer,
		coord_player => coordinate_player 
	);
	draw: desenhotela port map(
		reset => resetgeral,
		clock => novoclock,
		region => regionativa,
		row_pixel => row,
		column_pixel => column,
		coord_inv => pixel_list_coordinates_inv,
		coord_player => coordinate_player,
		R => red,
		G => green,
		B => blue
	);

end behavior;