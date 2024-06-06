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
	coord_shoot: in list_coordinates_shoots;
	life_invasores: in list_invasores_life;
	shoot_turn: in std_logic_vector(0 to quantidade_players - 1);
	shot_turn_inv: in  std_logic_vector(0 to quantidade_invasores - 1) := "000000000000000000000000000000000000000";
	coord_shot_inv: in list_coordinates_shoots_invasores;
	sorteio_invasor: in list_invasores_shoots_drawing;
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
		
		variable inv_row_shoot: integer;
		variable inv_column_shoot: integer;
		variable inv_row_shoot_aux: integer;
		variable inv_column_shoot_aux: integer;
		variable active_sprite_shoot: std_logic;
		
		variable inv_row_shoot_inv: integer;
		variable inv_column_shoot_inv: integer;
		variable inv_row_shoot_aux_inv: integer;
		variable inv_column_shoot_aux_inv: integer;
		variable active_sprite_shoot_inv: std_logic;
		variable invasor: integer;
		variable shoot_turn_invasor: std_logic;
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
						IF active_sprite = '1' and life_invasores(invasor) = 1 THEN
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
			FOR shoot in 0 to quantidade_players - 1 loop
				IF shoot = 0 and shoot_turn(shoot) = '1' THEN
					inv_row_shoot := coord_shoot(shoot)(0);
					inv_column_shoot := coord_shoot(shoot)(1);
					IF((row_pixel >= inv_row_shoot and row_pixel < inv_row_shoot + limit_row_sprite_shoot) 
						and 
						(column_pixel >= inv_column_shoot and column_pixel < inv_column_shoot + limit_column_sprite_shoot)
					) THEN
						inv_row_shoot_aux := row_pixel - inv_row_shoot;
						inv_column_shoot_aux := column_pixel - inv_column_shoot;
						active_sprite_shoot := sprite_shoot(inv_row_shoot_aux)(inv_column_shoot_aux);
						IF active_sprite_shoot = '1' THEN
							RGBp <= "010";
						ELSE
							RGBp <= "000";
						END IF;
					END IF;
				END IF;
			end loop;
			
			FOR ind in 0 to 12 loop
				invasor := sorteio_invasor(ind);
				IF invasor /= -1 THEN
					shoot_turn_invasor := shot_turn_inv(invasor);
					IF shoot_turn_invasor = '1' and life_invasores(invasor) = 1 THEN
						inv_row_shoot_inv := coord_shot_inv(ind)(0);
						inv_column_shoot_inv := coord_shot_inv(ind)(1);
						IF (
						( row_pixel >= inv_row_shoot_inv and row_pixel < inv_row_shoot_inv + limit_row_sprite_shoot ) 
						and 
						(column_pixel >= inv_column_shoot_inv and column_pixel < inv_column_shoot_inv + limit_column_sprite_shoot)) THEN
							inv_row_shoot_aux_inv := row_pixel - inv_row_shoot_inv;
							inv_column_shoot_aux_inv := column_pixel - inv_column_shoot_inv;
							active_sprite_shoot_inv := sprite_shoot(inv_row_shoot_aux_inv)(inv_column_shoot_aux_inv);
							IF active_sprite_shoot_inv = '1' THEN
								RGBp <= "100";
							ELSE
								RGBp <= "000";
							END IF;
						END IF;
					END IF;
				END IF;
			end loop;
		END IF;
	end process desenho;


end behavior;