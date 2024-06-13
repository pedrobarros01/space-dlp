library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.tipagens.all;

entity hudgame is
port(
	reset: in std_logic;
	clock: in std_logic;
	life_players: in list_life_players;
	estado_jogo: in states_game;
	coord_life_player_one: out list_coordinates_life;
	coord_life_player_two: out list_coordinates_life
);
end hudgame;

architecture behavior of hudgame is
	signal cood_initial_life_player_one: list_coordinates_life := ((10, 30), (10, 72), (10, 114), (10, 156), (10, 198), (10, 240), (10, 282), (10, 324) ,(10, 366));
	signal cood_initial_life_player_two: list_coordinates_life := ((40, 30), (40, 72), (40, 114), (40, 156), (40, 198), (40, 240), (40, 282), (40, 324) ,(40, 366));
	signal cood_life_player_one: list_coordinates_life := cood_initial_life_player_one;
	signal cood_life_player_two: list_coordinates_life := cood_initial_life_player_two;
begin
	life_p_one: process(reset, clock)
	begin
		IF reset = '0' THEN
			cood_life_player_one <= cood_initial_life_player_one;
		ELSIF rising_edge(clock) THEN
			IF estado_jogo = GAMERSTART THEN
				IF life_players(0) = 8 THEN
					cood_life_player_one(8) <= (-1, -1);
				ELSIF life_players(0) = 7 THEN
					cood_life_player_one(7) <= (-1, -1);
				ELSIF life_players(0) = 6 THEN
					cood_life_player_one(6) <= (-1, -1);
				ELSIF life_players(0) = 5 THEN
					cood_life_player_one(5) <= (-1, -1);
				ELSIF life_players(0) = 4 THEN 
					cood_life_player_one(4) <= (-1, -1);
				ELSIF life_players(0) = 3 THEN 
					cood_life_player_one(3) <= (-1, -1);
				ELSIF life_players(0) = 2 THEN
					cood_life_player_one(2) <= (-1, -1);
				ELSIF life_players(0) = 1 THEN
					cood_life_player_one(1) <= (-1, -1);
				ELSIF life_players(0) = 0 THEN
					cood_life_player_one(0) <= (-1, -1);
				END IF;
				coord_life_player_one <= cood_life_player_one;
			END IF;
			
		END IF;
	end process life_p_one;
	
	life_p_two: process(reset, clock)
	begin
		IF reset = '0' THEN
			cood_life_player_two <= cood_initial_life_player_two;
		ELSIF rising_edge(clock) THEN
			IF estado_jogo = GAMERSTART THEN
				IF life_players(1) = 8 THEN
					cood_life_player_two(8) <= (-1, -1);
				ELSIF life_players(1) = 7 THEN
					cood_life_player_two(7) <= (-1, -1);
				ELSIF life_players(1) = 6 THEN
					cood_life_player_two(6) <= (-1, -1);
				ELSIF life_players(1) = 5 THEN
					cood_life_player_two(5) <= (-1, -1);
				ELSIF life_players(1) = 4 THEN 
					cood_life_player_two(4) <= (-1, -1);
				ELSIF life_players(1) = 3 THEN 
					cood_life_player_two(3) <= (-1, -1);
				ELSIF life_players(1) = 2 THEN
					cood_life_player_two(2) <= (-1, -1);
				ELSIF life_players(1) = 1 THEN
					cood_life_player_two(1) <= (-1, -1);
				ELSIF life_players(1) = 0 THEN
					cood_life_player_two(0) <= (-1, -1);
				END IF;
				coord_life_player_two <= cood_life_player_two;
			END IF;		
		END IF;
	end process life_p_two;
end behavior;