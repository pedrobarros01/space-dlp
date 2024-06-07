library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.controllergame.all;
use spaceinvaders.tipagens.all;
package controllergame is
	component pixelgen is
	port(
		reset: in std_logic;
		clock: in std_logic;
		region: in std_logic;
		column_pixel: in integer;
		R: out std_logic;
		G: out std_logic;
		B: out std_logic
	);
	end component;
	component invaderships is
	port(
		reset: in std_logic;
		clock: in std_logic;
		mov_inv_vez: inout std_logic;
		mov_esq_dir: inout std_logic;
		state_desce: inout std_logic;
		pixel_invasores: inout list_coordinates_invasores
	);
	
	end component;
	component desenhotela is
	port(
		reset: in std_logic;
		clock: in std_logic;
		region: in std_logic;
		row_pixel: in integer;
		column_pixel: in integer;
		coord_inv: in list_coordinates_invasores;
		coord_player: in list_coordinates_players;
		coord_shoot: in list_coordinates_shoots;
		life_invasores: in list_invasores_life;
		shoot_turn: in std_logic_vector(0 to quantidade_players - 1);
		shot_turn_inv: in  std_logic_vector(0 to quantidade_invasores - 1) := "000000000000000000000000000000000000000";
		coord_shot_inv: in list_coordinates_shoots_invasores;
		sorteio_invasor: in list_invasores_shoots_drawing;
		coord_life: in list_coordinates_life;
		R: out std_logic;
		G: out std_logic;
		B: out std_logic
);
	end component;
	component playership is
	port (
		reset: in std_logic;
		clock: in std_logic;
		player: in integer;
		movimento: in std_logic_vector(0 to 1);
		coord_player: out list_coordinates_players
	
	);
	end component;
	component shotcontroller is
	port(
		reset: in std_logic;
		clock: in std_logic;
		tiro: in std_logic_vector(0 to quantidade_players - 1);
		tiro_vez: inout std_logic_vector(0 to quantidade_players - 1);
		coord_players: in list_coordinates_players;
		coord_shot: inout list_coordinates_shoots;
		tiro_collision: in std_logic_vector(0 to quantidade_players - 1)
	);
	end component;
	component collisioncontroller is
	port(
		reset: in std_logic;
		clock: in std_logic;
		coord_inv: in list_coordinates_invasores;
		coord_shoot: in list_coordinates_shoots;
		shoot_turn: inout std_logic_vector(0 to quantidade_players - 1);
		shot_turn_inv: in std_logic_vector(0 to quantidade_invasores - 1);
		sorteio_invasor: in list_invasores_shoots_drawing;
		coord_player: in list_coordinates_players;
		coord_shot_inv: in list_coordinates_shoots_invasores;
		life_invasores: out list_invasores_life;
		life_players: out list_life_players;
		tiro_collision: out std_logic_vector(0 to quantidade_players - 1);
		tiro_collision_inv: out std_logic_vector(0 to quantidade_players - 1)
	);
	end component;
	component shotinvasorcontroller is
	port(
		reset: in std_logic;
		clock: in std_logic;
		life_invasores: in list_invasores_life;
		coord_inv: in list_coordinates_invasores;
		tiro_collision: in std_logic_vector(0 to quantidade_players - 1);
		coord_shot_inv: out list_coordinates_shoots_invasores;
		sorteio_invasor: out list_invasores_shoots_drawing;
		shot_turn_inv: inout std_logic_vector(0 to quantidade_invasores - 1);
		tiro_collision_inv: in std_logic_vector(0 to quantidade_players - 1)
	);
	end component;
	component hudgame is
	port(
		reset: in std_logic;
		clock: in std_logic;
		life_players: in list_life_players;
		coord_life: out list_coordinates_life
	);
	end component;

end package;