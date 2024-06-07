library ieee;
use ieee.std_logic_1164.all;


library spaceinvaders;
use spaceinvaders.tipagens.all;

entity shotinvasorcontroller is
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
end shotinvasorcontroller;

architecture behavior of shotinvasorcontroller is
	signal cont_item: integer := 0;
	signal sorteio_ind_invasor_aux: list_invasores_shoots_drawing;
	signal sorteio_ind_invasor: list_invasores_shoots_drawing;
	
begin
	sorteio: process(reset, clock)
		variable sorteio_list: list_invasores_shoots_drawing := (-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1);
		variable sorteio_items: integer:= 13;
		variable i: integer := 0;
		variable cont_item_aux: integer := 1;
		variable sorteado: integer := 0;
		variable item: integer;
		
	begin
		
		IF reset = '0' THEN
			sorteio_list := (-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1);
			cont_item_aux := 0;
		ELSIF rising_edge(clock) THEN
			IF shot_turn_inv = "000000000000000000000000000000000000000" THEN
				i := 0;
				cont_item_aux := 0;
				sorteio_list := (-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1);
				FOR inv in 0 to quantidade_invasores - 1 LOOP
					if inv >= 0 and inv < 13 and i < 13 then
						if life_invasores(inv + 13) = 0 and life_invasores(inv + 26) = 0 and life_invasores(inv) = 1 then
							sorteado := 1;
						else
							sorteado := 0;
						end if;
					elsif inv >= 13 and inv < 26  and i < 13 then
						if life_invasores(inv + 13) = 0 and life_invasores(inv) = 1 then
							sorteado := 1;
						else
							sorteado := 0;
						end if;
					elsif inv >= 26  and i < 13 then
						if life_invasores(inv) = 1 then
							sorteado := 1;
						else
							sorteado := 0;
						end if;
					end if;
					if sorteado = 1 and i < 13 then
						sorteio_list(i) := inv;
						i := i + 1;
					end if;
					cont_item_aux := cont_item_aux + 1;
				END LOOP;
				sorteio_ind_invasor_aux <= sorteio_list;
			ELSE
				cont_item_aux := 38;
			END IF;
		END IF;
		sorteio_ind_invasor <= sorteio_ind_invasor_aux;
		cont_item <= cont_item_aux;
		sorteio_invasor <= sorteio_ind_invasor_aux;
	end process sorteio;
	movshoots: process(reset, clock)
		variable shots_turn_inv: std_logic_vector(0 to quantidade_invasores - 1);
		variable shots_inv_inds: list_invasores_shoots_drawing;
		variable invasor: integer;
		variable coord_shots_inv_aux: list_coordinates_shoots_invasores;
		variable linha_inv: integer;
		variable coluna_inv: integer;
		
	begin
		IF reset = '0' THEN
			shots_turn_inv := "000000000000000000000000000000000000000";
		ELSIF rising_edge(clock) THEN
			shots_turn_inv := shot_turn_inv;
			shots_inv_inds := sorteio_ind_invasor;
				IF shots_turn_inv = "000000000000000000000000000000000000000" THEN
					FOR ind in 0 to 12 loop
						invasor := shots_inv_inds(ind);
						IF invasor /= -1 THEN
							linha_inv := coord_inv(invasor)(0);
							coluna_inv := coord_inv(invasor)(1);
							coord_shots_inv_aux(ind) := (linha_inv + 8, coluna_inv + 12);
							shots_turn_inv(invasor) := '1';
						ELSE
							coord_shots_inv_aux(ind) := (-1, -1);
							shots_turn_inv(invasor) := '0';
						END IF;
					end loop;
				ELSE
					FOR ind in 0 to 12 loop
						invasor := shots_inv_inds(ind);
						
						IF invasor /= -1 THEN
							linha_inv := coord_shots_inv_aux(ind)(0);
							coluna_inv := coord_shots_inv_aux(ind)(1);
							IF linha_inv >= 460 THEN
								coord_shots_inv_aux(ind)(0) := linha_inv;
								coord_shots_inv_aux(ind)(1) := coluna_inv;
								shots_turn_inv := "000000000000000000000000000000000000000";
							ELSE
								linha_inv := linha_inv + 2;
								coord_shots_inv_aux(ind)(0) := linha_inv;
								coord_shots_inv_aux(ind)(1) := coluna_inv;
								shots_turn_inv(invasor) := '1';
							END IF;
						ELSE
							coord_shots_inv_aux(ind) := (-1, -1);
							shots_turn_inv := "000000000000000000000000000000000000000";
						END IF;
					end loop;
					IF tiro_collision(0) = '1' THEN
						shots_turn_inv := "000000000000000000000000000000000000000";
					END IF;
					IF tiro_collision_inv(0) = '1' THEN
						shots_turn_inv := "000000000000000000000000000000000000000";
					END IF;
				END IF;
			shot_turn_inv <= shots_turn_inv;
			coord_shot_inv <= coord_shots_inv_aux;
		END IF;
	end process movshoots;

end behavior;