library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.uniform;
use ieee.math_real.floor;

package tipagens is
function rand_int return integer;
constant dimension: integer := 2;
constant quantidade_players: integer := 2;
constant quantidade_invasores: integer := 39;
constant limit_column_sprite_player: integer := 32;
constant limit_row_sprite_player: integer := 6; 
constant limit_column_sprite_shoot: integer := 6;
constant limit_row_sprite_shoot: integer := 10;
constant limit_column_sprite_enemies: integer := 32;
constant limit_row_sprite_enemies: integer := 7;
constant limit_column_sprite_gamer_over: integer := 40;
constant limit_row_sprite_gamer_over: integer := 12;
constant limit_column_sprite_player_win: integer := 72;
constant limit_row_sprite_player_win: integer := 12;
type sprite_array_enemies is array(0 to limit_row_sprite_enemies - 1) of std_logic_vector(0 to limit_column_sprite_enemies - 1);
type sprite_array_player is array(0 to limit_row_sprite_player - 1) of std_logic_vector( 0 to limit_column_sprite_player - 1);
type sprite_array_shoots is array(0 to limit_row_sprite_shoot - 1) of std_logic_vector(0 to limit_column_sprite_shoot - 1);
type sprite_array_gamer_over is array (0 to limit_row_sprite_gamer_over - 1) of std_logic_vector(0 to limit_column_sprite_gamer_over - 1);
type sprite_array_player_win is array (0 to limit_row_sprite_player_win - 1) of std_logic_vector(0 to limit_column_sprite_player_win - 1);
constant sprite_inv: sprite_array_enemies := (  
"00000000000000000000000000000000",
"00000000001100000000011000000000",
"00000000001111111111111000000000",
"00000000111100111110011110000000",
"00000011111111111111111111000000",
"00000011001100000000011001000000",
"00000000000011100111100000000000");
constant sprite_player: sprite_array_player := (
"00000000000000001000000000000000",
"00000000000000111100000000000000",
"00000000111111111111111110000000",
"00000001111111111111111111000000",
"00000001111111111111111111000000",
"00000000000000000000000000000000"
);
constant sprite_shoot: sprite_array_shoots := (
"011110",
"011110",
"011110",
"011110",
"011110",
"011110",
"011110",
"011110",
"011110",
"011110"
);
constant sprite_gamer_over: sprite_array_gamer_over := (
"0011110000111100011000110011111100000000",
"0110000001100110011101110011000000000000",
"0110111001111110011010110011110000000000",
"0110011001100110011000110011000000000000",
"0011110001100110011000110011111100000000",
"0000000000000000000000000000000000000000",
"0011110001100110011111100111110000000000",
"0110011001100110011000000110011000000000",
"0110011001100110011110000111110000000000",
"0110011000111100011000000110011000000000",
"0011110000011000011111100110011000000000",
"0000000000000000000000000000000000000000"
);
constant sprite_player_one_win: sprite_array_player_win := (
"011111000110000000111100011001100111111001111100000000000001100000000000",
"011001100110000001100110001111000110000001100110000000000011100000000000",
"011111000110000001111110000110000111100001111100000000000001100000000000",
"011000000110000001100110000110000110000001100110000000000001100000000000",
"011000000111111001100110000110000111111001100110000000000111111000000000",
"000000000000000000000000000000000000000000000000000000000000000000000000",
"011001100111111001100110001111000111111001100110000110000001100000000000",
"011001100110000001110110011001100110000001100110000110000001100000000000",
"011001100111100001101110011000000111100001100110000110000001100000000000",
"001111000110000001100110011001100110000001100110000000000000000000000000",
"000110000111111001100110001111000111111000111100000110000001100000000000",
"000000000000000000000000000000000000000000000000000000000000000000000000"
);
constant sprite_player_two_win: sprite_array_player_win := (
"011111000110000000111100011001100111111001111100000000000011110000000000",
 "011001100110000001100110001111000110000001100110000000000000011000000000",
 "011111000110000001111110000110000111100001111100000000000011110000000000",
 "011000000110000001100110000110000110000001100110000000000110000000000000",
 "011000000111111001100110000110000111111001100110000000000111111000000000",
 "000000000000000000000000000000000000000000000000000000000000000000000000",
 "011001100111111001100110001111000111111001100110000000000001100000011000",
 "011001100110000001110110011001100110000001100110000000000001100000011000",
 "011001100111100001101110011000000111100001100110000000000001100000011000",
 "001111000110000001100110011001100110000001100110000000000000000000000000",
 "000110000111111001100110001111000111111000111100000000000001100000011000",
 "000000000000000000000000000000000000000000000000000000000000000000000000"

);
type list_invasores_shoots_drawing is array (0 to 12) of integer;
type list_invasores_life is array (0 to quantidade_invasores - 1) of integer;
type list_coordinate_pixel is array(0 to dimension - 1) of integer;
type list_coordinates_invasores is array(0 to quantidade_invasores - 1) of list_coordinate_pixel;
type list_coordinates_players is array(0 to quantidade_players - 1) of list_coordinate_pixel;
type list_coordinates_shoots is array(0 to quantidade_players - 1) of list_coordinate_pixel;
type list_coordinates_shoots_invasores is array(0 to 12) of list_coordinate_pixel;
type list_life_players is array(0 to quantidade_players - 1) of integer;
type list_coordinates_life is array(0 to 8) of list_coordinate_pixel;
type list_display_player_score is array(0 to quantidade_players - 1) of std_logic_vector(0 to 3);
type list_rgb_players is array(0 to quantidade_players - 1) of std_logic_vector(0 to 2);
constant cores_players: list_rgb_players :=( "010", "001" );
constant cores_powerups_players: list_rgb_players := ("111", "101");
type list_powerup_player is array (0 to quantidade_players - 1) of integer;
type states_game is (GAMEROVER, PLAYEROVER, GAMERSTART);
end package;
package body tipagens is
	function rand_int return integer is
		variable seed_one: positive := 1; 
		variable seed_two: positive:= 1;
		variable X: real;
		variable saida: integer;
	begin
		uniform(seed_one, seed_two, X);
		saida := integer(floor(X * 2.0));
		return saida;
	end rand_int;
	
end tipagens;