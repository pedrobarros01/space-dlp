library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.tipagens.all;


entity invaderships is
port(
	reset: in std_logic;
	clock: in std_logic;
	estado_jogo: in states_game;
	pixel_invasores: inout list_coordinates_invasores
);
end invaderships;

architecture behavior of invaderships is
	signal mov_esq_dir: std_logic := '0';
	signal mov_inv_vez: std_logic := '0';
	signal pixel_invasores_inicial: list_coordinates_invasores := (
	(200, 58), (200, 100), (200, 142), (200, 184), (200, 226), (200, 268), (200, 310), (200, 352), (200, 394), (200, 436), (200, 478), (200, 520), (200, 562),
	(220, 58), (220, 100), (220, 142), (220, 184), (220, 226), (220, 268), (220, 310), (220, 352), (220, 394), (220, 436), (220, 478), (220, 520), (220, 562), 
	(240, 58), (240, 100), (240, 142), (240, 184), (240, 226), (240, 268), (240, 310), (240, 352), (240, 394), (240, 436), (240, 478), (240, 520), (240, 562)
	);
	signal pixel_invasores_aux: list_coordinates_invasores;
begin
	--200 = linha e 300 = coluna
	-- mov_esq_dir = '0' -> esquerda/ mov_esq_dir = '1' -> direita
	invasor: process(reset, clock)
		variable inv_row: integer;
		variable inv_column: integer;
		
	begin
		IF reset = '0' THEN
			pixel_invasores <= pixel_invasores_inicial;
			mov_inv_vez <= '0';
			mov_esq_dir <= '0';
		ELSIF rising_edge(clock) THEN
		  IF estado_jogo = GAMERSTART THEN
			IF mov_inv_vez = '0' THEN
				pixel_invasores_aux <= pixel_invasores_inicial;
				mov_inv_vez <= '1';
			ELSIF pixel_invasores_aux(26)(0) >= 350 	THEN
				pixel_invasores_aux <= pixel_invasores_inicial;
				mov_esq_dir <= '0';
			ELSE
				pixel_invasores_aux <= pixel_invasores;
				FOR inv_ind_col in 0 to quantidade_invasores - 1 loop
					IF mov_esq_dir = '0' THEN
							IF(pixel_invasores_aux(0)(1) > 4 )  THEN
								inv_column := pixel_invasores_aux(inv_ind_col)(1) - 3;						
								inv_row := pixel_invasores_aux(inv_ind_col)(0);
							ELSE
								inv_column := pixel_invasores_aux(inv_ind_col)(1);
								inv_row := pixel_invasores_aux(inv_ind_col)(0) + 10;
								mov_esq_dir <= not mov_esq_dir;
							END IF;
					ELSE
							IF(pixel_invasores_aux(12)(1) < 607 ) THEN
								inv_column := pixel_invasores_aux(inv_ind_col)(1) + 3;	
								inv_row := pixel_invasores_aux(inv_ind_col)(0);
							ELSE
								inv_column := pixel_invasores_aux(inv_ind_col)(1);
								inv_row := pixel_invasores_aux(inv_ind_col)(0) + 10;
								mov_esq_dir <= not mov_esq_dir;
							END IF;	
					END IF;
					pixel_invasores_aux(inv_ind_col)(1) <= inv_column;
					pixel_invasores_aux(inv_ind_col)(0) <= inv_row;
				end loop;
			END IF;
			pixel_invasores <= pixel_invasores_aux;
		  END IF;
		END IF;
	end process invasor;

end behavior;