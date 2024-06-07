library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.tipagens.all;

entity collisioncontroller is
port(
	reset: in std_logic;
	clock: in std_logic;
	coord_inv: in list_coordinates_invasores;
	coord_shoot: in list_coordinates_shoots;
	shoot_turn: in std_logic_vector(0 to quantidade_players - 1);
	shot_turn_inv: in std_logic_vector(0 to quantidade_invasores - 1);
	sorteio_invasor: in list_invasores_shoots_drawing;
	coord_player: in list_coordinates_players;
	coord_shot_inv: in list_coordinates_shoots_invasores;
	life_invasores: out list_invasores_life;
	life_players: out list_life_players; 
	tiro_collision: out std_logic_vector(0 to quantidade_players - 1);
	tiro_collision_inv: out std_logic_vector(0 to quantidade_players - 1)
	
);
end collisioncontroller;


architecture behavior of collisioncontroller is
    signal colidiu_aux: std_logic := '0';
    signal life_invasores_initial: list_invasores_life := (1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                                                           1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                                                           1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                                                           1, 1, 1, 1, 1, 1, 1, 1, 1);
    signal life_invasores_aux: list_invasores_life := life_invasores_initial;
	 signal tiro_vez_aux: std_logic_vector(0 to quantidade_players - 1);
	 signal tiro_collision_aux: std_logic_vector(0 to quantidade_players - 1) := "00";
	 signal tiro_collision_aux_inv: std_logic_vector(0 to quantidade_players - 1) := "00";
	 signal life_player_initial: list_life_players := (9, 9);
	 signal life_player_aux: list_life_players := life_player_initial;
begin
    collisor_shot_player_one_inv: process(reset, clock)
		  variable player: integer := 0;
        variable linha_tiro_player: integer;
        variable coluna_tiro_player: integer;
        variable linha_invasor: integer;
        variable coluna_invasor: integer;
        variable linha: integer;
        variable coluna: integer;
        variable sprite_collide: std_logic;
        variable local_colidiu: std_logic := '0';
    begin    
        if reset = '0' then
            life_invasores <= life_invasores_initial;
        elsif rising_edge(clock) then
				tiro_vez_aux <= shoot_turn;
				if tiro_vez_aux(0) = '1' then
					tiro_collision_aux(0) <= '0';
					local_colidiu := '0';
					linha_tiro_player := coord_shoot(0)(0);
					coluna_tiro_player := coord_shoot(0)(1);
					for invasor in 0 to quantidade_invasores - 1 loop
						 if local_colidiu = '0' and life_invasores_aux(invasor) = 1 then
							  linha_invasor := coord_inv(invasor)(0);
							  coluna_invasor := coord_inv(invasor)(1);
							  if (linha_tiro_player >= linha_invasor and linha_tiro_player < linha_invasor + limit_row_sprite_enemies) and
								  (coluna_tiro_player >= coluna_invasor and coluna_tiro_player < coluna_invasor + limit_column_sprite_enemies) then
									local_colidiu := '1';
									tiro_collision_aux(0) <= '1';
									life_invasores_aux(invasor) <= 0;
							  else
									life_invasores_aux(invasor) <= 1;
							  end if;
						 end if;
					end loop;
				 else
					tiro_collision_aux(0) <= '0';
				end if;
        end if;
		  tiro_collision <= tiro_collision_aux;
		  life_invasores <= life_invasores_aux;
    end process collisor_shot_player_one_inv;
	 
	 collisor_shot_inv_player_one: process(reset, clock)
		variable tiro_vez_inv_aux: std_logic_vector(0 to quantidade_invasores - 1);
		variable linha_tiro_inv: integer;
		variable coluna_tiro_inv: integer;
		variable linha_tiro_inv_aux: integer;
		variable coluna_tiro_inv_aux: integer;
		variable linha_player: integer;
		variable coluna_player: integer;
		variable colidiu: std_logic;
		variable invasor: integer;
		variable life: integer:= 9;
	 begin
	 
		IF reset = '0' THEN
			life_player_aux <= (9,9);
			tiro_collision_aux_inv <= "00";
		ELSIF rising_edge(clock) THEN
			tiro_vez_inv_aux := shot_turn_inv;
			colidiu := '0';
			FOR ind in 0 to 12 loop
				invasor := sorteio_invasor(ind);
				IF invasor /= -1  and colidiu = '0' then
					IF tiro_vez_inv_aux(invasor) = '1' and colidiu = '0' THEN
						linha_tiro_inv := coord_shot_inv(ind)(0);
						coluna_tiro_inv := coord_shot_inv(ind)(1);
						linha_player := coord_player(0)(0);
						coluna_player := coord_player(0)(1);
						IF( 
						(linha_tiro_inv >= linha_player and linha_tiro_inv < linha_player + limit_row_sprite_player) 
						and 
						(coluna_tiro_inv >= coluna_player and coluna_tiro_inv < coluna_player + limit_column_sprite_player) 
						and
						colidiu = '0'
						and 
						life > 0
						) THEN
							colidiu := '1';
							tiro_collision_aux_inv(0) <= '1';
							life := life - 1;
						END IF;
					ELSE
						life := life;
						tiro_collision_aux_inv(0) <= '0';
					END IF;
				ELSE
					life := life;
					tiro_collision_aux_inv(0) <= '0';
				end if;
			end loop;
			life_player_aux(0) <= life;
		END IF;
			life_players <= life_player_aux;
			tiro_collision_inv <= tiro_collision_aux_inv;
	 end process collisor_shot_inv_player_one;
	 
	 
	 
end behavior;
