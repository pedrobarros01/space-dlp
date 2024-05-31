library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.tipagens.all;

entity desenhotela is
port(
	reset: in std_logic;
	clock: in std_logic;
	region: in std_logic;
	row_pixel: in integer;
	column_pixel: in integer;
	coord_inv: in list_coordinates_invasores;
	coord_player: in list_coordinates_players;
	R: out std_logic;
	G: out std_logic;
	B: out std_logic
);
end desenhotela;

architecture behavior of desenhotela is
	SIGNAL RGBp : STD_LOGIC_VECTOR(2 DOWNTO 0); 
begin
	R <= RGBp(2) and region;
	G <= RGBp(1) and region;
	B <= RGBp(0) and region;
	desenho: process(reset, clock)
		variable inv_row: integer;
		variable inv_column: integer;
		variable active_sprite: std_logic;
		variable inv_row_aux: integer;
		variable inv_column_aux: integer;
		
		variable inv_row_player: integer;
		variable inv_column_player: integer;
		variable inv_row_player_aux: integer;
		variable inv_column_player_aux: integer;
		variable active_sprite_player: std_logic;
	begin
		IF reset = '0' THEN
			RGBp <= "000";
		ELSIF rising_edge(clock) THEN
			FOR invasor in 0 to quantidade_invasores - 1 loop
					inv_row := coord_inv(invasor)(0);
					inv_column := coord_inv(invasor)(1);
					IF (
					(row_pixel >= inv_row and row_pixel < inv_row + limit_row_sprite_enemies) 
					and 
					(column_pixel >= inv_column and column_pixel < inv_column + limit_column_sprite_enemies)
					)THEN
						inv_row_aux := row_pixel - inv_row;
						inv_column_aux:= column_pixel - inv_column;
						active_sprite := sprite_inv(inv_row_aux)(inv_column_aux);
						IF active_sprite = '1' THEN
							RGBp <= "100";
						ELSE
							RGBp <= "000";
						END IF;
					END IF;
			end loop;
			FOR player in 0 to quantidade_players - 1 loop
				IF player = 0 THEN
					inv_row_player := coord_player(player)(0);
					inv_column_player := coord_player(player)(1);
					IF( 
						(row_pixel >= inv_row_player and row_pixel < inv_row_player + limit_row_sprite_player) 
						and 
						(column_pixel >= inv_column_player and column_pixel < inv_column_player + limit_column_sprite_player) 
					) THEN
						inv_row_player_aux := row_pixel - inv_row_player;
						inv_column_player_aux := column_pixel - inv_column_player;
						active_sprite_player := sprite_player(inv_row_player_aux)(inv_column_player_aux);
						IF active_sprite_player = '1' THEN
								RGBp <= "010";
							ELSE
								RGBp <= "000";
							END IF;
					END IF;
				END IF;
			end loop;
		END IF;
	end process desenho;


end behavior;