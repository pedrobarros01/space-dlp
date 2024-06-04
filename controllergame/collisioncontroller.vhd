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
	life_invasores: out list_invasores_life;
	colidiu: out std_logic
);
end collisioncontroller;


architecture behavior of collisioncontroller is
    signal colidiu_aux: std_logic := '0';
    signal life_invasores_initial: list_invasores_life := (1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                                                           1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                                                           1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                                                           1, 1, 1, 1, 1, 1, 1, 1, 1);
    signal life_invasores_aux: list_invasores_life := life_invasores_initial;
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
				if shoot_turn(0) = '1' then
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
									life_invasores_aux(invasor) <= 0;
							  else
									life_invasores_aux(invasor) <= 1;
							  end if;
						 end if;
					end loop;
					colidiu <= local_colidiu;
					life_invasores <= life_invasores_aux;
				end if;
            
        end if;
    end process collisor_shot_player_one_inv;
end behavior;
