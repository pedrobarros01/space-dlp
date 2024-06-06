library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.tipagens.all;


entity shotcontroller is
port(
	reset: in std_logic;
	clock: in std_logic;
	tiro: in std_logic_vector(0 to quantidade_players - 1);
	tiro_vez: inout std_logic_vector(0 to quantidade_players - 1);
	coord_players: in list_coordinates_players;
	coord_shot: inout list_coordinates_shoots;
	tiro_collision: in std_logic_vector(0 to quantidade_players - 1)
);
end shotcontroller;
architecture behavior of shotcontroller is
	signal tiro_vez_aux: std_logic_vector(0 to quantidade_players - 1) := "00";
	signal coord_shot_aux: list_coordinates_shoots;
begin
	shot: process(reset, clock)
		variable linha_tiro: integer;
		variable coluna_tiro: integer;
	begin
		IF reset = '0' THEN
			coord_shot_aux <= ((coord_players(0)(0) - 11, coord_players(0)(1) + 16), (coord_players(1)(0) - 11, coord_players(1)(1) + 16));
			tiro_vez <= "00";
		ELSIF rising_edge(clock) THEN
			
			IF(tiro_vez(0) = '1') THEN
				tiro_vez_aux(0) <= '1';
				coord_shot_aux(0) <= coord_shot(0);
			ELSIF(tiro_vez(0) = '0' AND tiro(0) = '0' ) THEN
				tiro_vez_aux(0) <= '1';
				coord_shot_aux(0) <= (coord_players(0)(0) - 11, coord_players(0)(1) + 16);
			END IF;
			
			
			IF(tiro_vez(1) = '0' AND tiro(1) = '1') THEN
				tiro_vez_aux(1) <= '1';
				coord_shot_aux(1) <= (coord_players(1)(0) - 11, coord_players(1)(1) + 16);
			ELSE
				tiro_vez_aux(1) <= '1';
				coord_shot_aux(1) <= coord_shot(1);
			END IF;
			
			IF tiro_vez_aux(0) = '1' THEN
				IF(coord_shot_aux(0)(0) <= 10) THEN
					tiro_vez_aux(0) <= '0';
				ELSE
					linha_tiro := coord_shot_aux(0)(0) - 2;
					coluna_tiro := coord_shot_aux(0)(1);
					coord_shot_aux(0) <= (linha_tiro, coluna_tiro);
				END IF;
				IF(tiro_collision(0) = '1') THEN
					tiro_vez_aux(0) <= '0';
					coord_shot_aux(0) <= (coord_players(0)(0) - 11, coord_players(0)(1) + 16);
				end if;
			END IF;
			
			IF tiro_vez_aux(1) = '1' THEN
				IF(coord_shot_aux(1)(0) <= 10 ) THEN
					tiro_vez_aux(1) <= '0';
				ELSE
					linha_tiro := coord_shot_aux(1)(0) - 2;
					coluna_tiro := coord_shot_aux(1)(1);
					coord_shot_aux(1) <= (linha_tiro, coluna_tiro);
				END IF;
				IF(tiro_collision(1) = '1') THEN
					tiro_vez_aux(1) <= '0';
					coord_shot_aux(1) <= (coord_players(1)(0) - 11, coord_players(1)(1) + 16);
				end if;
			END IF;
		END IF;
		coord_shot <= coord_shot_aux;
		tiro_vez <= tiro_vez_aux;
		
	end process shot;

end behavior;