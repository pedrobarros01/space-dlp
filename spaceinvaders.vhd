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
	movimentoplayer_two: in std_logic_vector(0 to 1);
	movimentoplayer: in std_logic_vector(0 to 1);
	tiroplayer: in std_logic_vector(0 to 1);
	h_sync: out std_logic;
	v_sync: out std_logic;
	pins_display_one_uni: out std_logic_vector(0 to 6);
	pins_display_one_dec: out std_logic_vector(0 to 6);
	pins_display_two_uni: out std_logic_vector(0 to 6);
	pins_display_two_dec: out std_logic_vector(0 to 6);
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
	signal coordinate_player_one: list_coordinates_players;
	signal coordinate_player_two: list_coordinates_players;
	signal tiro_vez: std_logic_vector(0 to quantidade_players - 1) := "00";
	signal coordinate_shoots: list_coordinates_shoots;
	signal life_invasores: list_invasores_life;
	signal tiro_collision: std_logic_vector(0 to quantidade_players - 1) := "00";
	signal tiro_collision_inv: std_logic_vector(0 to quantidade_players - 1) := "00";
	signal shot_turn_inv:  std_logic_vector(0 to quantidade_invasores - 1) := "000000000000000000000000000000000000000";
	signal coord_shot_inv: list_coordinates_shoots_invasores;
	signal sorteio_invasor: list_invasores_shoots_drawing;
	signal life_players: list_life_players;
	signal coord_life_player_one: list_coordinates_life;
	signal coord_life_player_two: list_coordinates_life;
	signal score_segment_player_one:  list_display_player_score;
	signal score_Segment_player_two:  list_display_player_score;
	signal powerup_players: list_powerup_player;
	signal score_player_one: integer;
	signal score_player_two: integer;
	signal player_win: integer;
	signal estado_jogo: states_game;
	begin
	coordinate_player(0) <= coordinate_player_one(0);
	coordinate_player(1) <= coordinate_player_two(1);
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
		estado_jogo => estado_jogo,
		pixel_invasores => pixel_list_coordinates_inv
	);
	player_one: playership port map(
		reset => resetgeral,
		clock => novoclockplayer,
		player => 0,
		life_players => life_players,
		estado_jogo => estado_jogo,
		movimento => movimentoplayer,
		coord_player => coordinate_player_one 
	);
	player_two: playership port map(
		reset => resetgeral,
		clock => novoclockplayer,
		player => 1,
		life_players => life_players,
		estado_jogo => estado_jogo,
		movimento => movimentoplayer_two,
		coord_player => coordinate_player_two 
	);
	shoot: shotcontroller port map(
		reset => resetgeral,
		clock => novoclockplayer,
		tiro => tiroplayer,
		life_players => life_players,
		estado_jogo => estado_jogo,
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
		life_players => life_players,
		shoot_turn => tiro_vez,
		coord_shot_inv => coord_shot_inv,
		shot_turn_inv => shot_turn_inv,
		sorteio_invasor => sorteio_invasor,
		coord_life_player_one => coord_life_player_one,
		coord_life_player_two => coord_life_player_two,
		powerup_players => powerup_players,
		estado_jogo => estado_jogo,
		player_win => player_win,
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
		estado_jogo => estado_jogo,
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
		estado_jogo => estado_jogo,
		coord_shot_inv => coord_shot_inv,
		sorteio_invasor => sorteio_invasor,
		shot_turn_inv => shot_turn_inv,
		tiro_collision_inv => tiro_collision_inv
		
	);
	hud: hudgame port map (
		reset => resetgeral,
		clock => novoclockplayer,
		life_players => life_players,
		estado_jogo => estado_jogo,
		coord_life_player_one => coord_life_player_one,
		coord_life_player_two => coord_life_player_two
	);
	score: scoreboard port map (
		reset => resetgeral,
		clock => novoclockplayer,
		tiro_players_collision => tiro_collision,
		powerup_players => powerup_players,
		estado_jogo => estado_jogo,
		score_player_one => score_player_one,
		score_player_two => score_player_two,
		score_segment_player_one => score_segment_player_one,
		score_Segment_player_two => score_Segment_player_two
	);
	powerup: powerupcontroller port map (
		reset => resetgeral,
		clock => novoclockplayer,
		estado_jogo => estado_jogo,
		tiro_players_collision => tiro_collision,
		powerup_players => powerup_players
		
	);
	rules: gamerules port map (
		reset => resetgeral,
		clock => novoclockplayer,
		life_invasores => life_invasores,
		life_players => life_players,
		score_player_one => score_player_one,
		score_player_two => score_player_two,
		player_win => player_win,
		estado_jogo => estado_jogo
	
	);
	disp_p_one_dec: display port map(
		number => score_segment_player_one(0),
		pins_display => pins_display_one_dec
	);
	
	disp_p_one_uni: display port map(
		number => score_segment_player_one(1),
		pins_display => pins_display_one_uni
	);
	
	disp_p_two_dec: display port map(
		number => score_Segment_player_two(0),
		pins_display => pins_display_two_dec
	);
	
	disp_p_two_uni: display port map(
		number => score_Segment_player_two(1),
		pins_display => pins_display_two_uni
	);

end behavior;