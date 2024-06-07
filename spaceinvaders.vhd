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
	tiroplayer: in std_logic_vector(0 to 1);
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
	signal tiro_vez: std_logic_vector(0 to quantidade_players - 1) := "00";
	signal coordinate_shoots: list_coordinates_shoots;
	signal mov_esq_dir: std_logic := '0';
	signal mov_inv_vez: std_logic := '0';
	signal state_desce: std_logic := '0';
	signal life_invasores: list_invasores_life;
	signal tiro_collision: std_logic_vector(0 to quantidade_players - 1) := "00";
	signal tiro_collision_inv: std_logic_vector(0 to quantidade_players - 1) := "00";
	signal shot_turn_inv:  std_logic_vector(0 to quantidade_invasores - 1) := "000000000000000000000000000000000000000";
	signal coord_shot_inv: list_coordinates_shoots_invasores;
	signal sorteio_invasor: list_invasores_shoots_drawing;
	signal life_players: list_life_players;
	signal coord_life: list_coordinates_life;
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
		clock => novoclockplayer,
		mov_inv_vez => mov_inv_vez,
		mov_esq_dir => mov_esq_dir,
		state_desce => state_desce,
		pixel_invasores => pixel_list_coordinates_inv
	);
	player: playership port map(
		reset => resetgeral,
		clock => novoclockplayer,
		player => 0,
		movimento => movimentoplayer,
		coord_player => coordinate_player 
	);
	shoot: shotcontroller port map(
		reset => resetgeral,
		clock => novoclockplayer,
		tiro => tiroplayer,
		tiro_vez => tiro_vez,
		coord_players => coordinate_player,
		coord_shot => coordinate_shoots,
		tiro_collision => tiro_collision
	
	);
	

	draw: desenhotela port map(
		reset => resetgeral,
		clock => novoclock,
		region => regionativa,
		row_pixel => row,
		column_pixel => column,
		coord_inv => pixel_list_coordinates_inv,
		coord_player => coordinate_player,
		coord_shoot => coordinate_shoots,
		life_invasores => life_invasores,
		shoot_turn => tiro_vez,
		coord_shot_inv => coord_shot_inv,
		shot_turn_inv => shot_turn_inv,
		sorteio_invasor => sorteio_invasor,
		coord_life => coord_life,
		R => red,
		G => green,
		B => blue
	);
	
	collsion: collisioncontroller port map(
		reset => resetgeral,
		clock => novoclockplayer,
		coord_inv => pixel_list_coordinates_inv,
		coord_shoot => coordinate_shoots,
		shoot_turn => tiro_vez,
		shot_turn_inv => shot_turn_inv,
		sorteio_invasor => sorteio_invasor,
		coord_player => coordinate_player,
		coord_shot_inv => coord_shot_inv,
		tiro_collision => tiro_collision,
		life_invasores => life_invasores,
		life_players => life_players,
		tiro_collision_inv => tiro_collision_inv

	
	);
	shotinvasor: shotinvasorcontroller port map (
		reset => resetgeral,
		clock => novoclockplayer,
		life_invasores => life_invasores,
		coord_inv => pixel_list_coordinates_inv,
		tiro_collision => tiro_collision,
		coord_shot_inv => coord_shot_inv,
		sorteio_invasor => sorteio_invasor,
		shot_turn_inv => shot_turn_inv,
		tiro_collision_inv => tiro_collision_inv
		
	);
	hud: hudgame port map (
		reset => resetgeral,
		clock => novoclockplayer,
		life_players => life_players,
		coord_life => coord_life
	);

end behavior;