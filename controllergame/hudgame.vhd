library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.tipagens.all;

entity hudgame is
port(
	reset: in std_logic;
	clock: in std_logic;
	life_players: in list_life_players;
	coord_life: out list_coordinates_life
);
end hudgame;

architecture behavior of hudgame is
	signal cood_initial_life_player_one: list_coordinates_life := ((30, 30), (30, 72), (30, 114), (30, 156), (30, 198), (30, 240), (30, 282), (30, 324) ,(30, 366));
	signal cood_life_player_one: list_coordinates_life := cood_initial_life_player_one;
begin
	life: process(reset, clock)
	begin
		IF reset = '0' THEN
		cood_life_player_one <= cood_initial_life_player_one;
		ELSIF rising_edge(clock) THEN
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
			coord_life <= cood_life_player_one;
		END IF;
	end process life;
end behavior;