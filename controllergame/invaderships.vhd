library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.tipagens.all;


entity invaderships is
port(
	reset: in std_logic;
	clock: in std_logic;
	estado_jogo: in states_game;
	mov_inv_vez: inout std_logic;
	mov_esq_dir: inout std_logic;
	state_desce: inout std_logic;
	pixel_invasores: inout list_coordinates_invasores
);
end invaderships;

architecture behavior of invaderships is
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
			state_desce <= '0';
		ELSIF rising_edge(clock) THEN
		  IF estado_jogo = GAMERSTART THEN
				IF mov_inv_vez = '0' THEN
					pixel_invasores <= pixel_invasores_inicial;
					state_desce <= '0';
					mov_esq_dir <= '0';
					mov_inv_vez <= '1';
				END IF;
		  END IF;
			
		END IF;
	end process invasor;

end behavior;