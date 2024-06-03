library ieee;
use ieee.std_logic_1164.all;


package tipagens is
constant dimension: integer := 2;
constant quantidade_players: integer := 2;
constant quantidade_invasores: integer := 39;
constant limit_column_sprite_player: integer := 32;
constant limit_row_sprite_player: integer := 10; 
constant limit_column_sprite_shoot: integer := 32;
constant limit_row_sprite_shoot: integer := 10;
constant limit_column_sprite_enemies: integer := 32;
constant limit_row_sprite_enemies: integer := 7;
type sprite_array_enemies is array(0 to limit_row_sprite_enemies - 1) of std_logic_vector(0 to limit_column_sprite_enemies - 1);
type sprite_array_player is array(0 to limit_row_sprite_player - 1) of std_logic_vector( 0 to limit_column_sprite_player - 1);
type sprite_array_shoots is array(0 to limit_row_sprite_shoot - 1) of std_logic_vector(0 to limit_column_sprite_shoot - 1);
constant sprite_inv: sprite_array_enemies := (  
"00000000000000000000000000000000",
"00000000001100000000011000000000",
"00000000001111111111111000000000",
"00000000111100111110011110000000",
"00000011111111111111111111000000",
"00000011001100000000011001000000",
"00000000000011100111100000000000");
constant sprite_player: sprite_array_player := (
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000000000000000000000",
"00000000000000001000000000000000",
"00000000000000111100000000000000",
"00000000111111111111111110000000",
"00000001111111111111111111000000",
"00000001111111111111111111000000",
"00000000000000000000000000000000"
);
constant sprite_shoot: sprite_array_shoots := (
"00000000000000111100000000000000",
"00000000000000111100000000000000",
"00000000000000111100000000000000",
"00000000000000111100000000000000",
"00000000000000111100000000000000",
"00000000000000111100000000000000",
"00000000000000111100000000000000",
"00000000000000111100000000000000",
"00000000000000111100000000000000",
"00000000000000111100000000000000"
);
type list_coordinate_pixel is array(0 to dimension - 1) of integer;
type list_coordinates_invasores is array(0 to quantidade_invasores - 1) of list_coordinate_pixel;
type list_coordinates_players is array(0 to quantidade_players - 1) of list_coordinate_pixel;
type list_coordinates_shoots is array(0 to quantidade_players - 1) of list_coordinate_pixel;
end package;