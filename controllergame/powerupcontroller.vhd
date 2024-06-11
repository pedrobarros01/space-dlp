library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.tipagens.all;

entity powerupcontroller is
port(
	reset: in std_logic;
	clock: in std_logic;
	tiro_players_collision: in std_logic_vector(0 to quantidade_players - 1);
	powerup_players: out list_powerup_player

);
end powerupcontroller;

architecture behavior of powerupcontroller is
	signal powerup_players_aux: list_powerup_player := (0,0);
begin
	powerup_player_one:  process(reset, clock)
		variable inimigos_derrotados: integer := 1;
	begin
		IF reset = '0' THEN
			powerup_players_aux(0) <= 0;
		ELSIF rising_edge(clock) THEN
			IF tiro_players_collision(0) = '1' THEN
				inimigos_derrotados := inimigos_derrotados + 1;	
				powerup_players_aux(0) <= 0;
			END IF;
			IF inimigos_derrotados = 5 THEN
				powerup_players_aux(0) <= 1;
				inimigos_derrotados := 1;
			END IF;
		END IF;
		powerup_players(0) <= powerup_players_aux(0);
	end process powerup_player_one;

	
	
	powerup_player_two:  process(reset, clock)
		variable inimigos_derrotados: integer := 1;
	begin
		IF reset = '0' THEN
			powerup_players_aux(1) <= 0;
		ELSIF rising_edge(clock) THEN
			IF tiro_players_collision(1) = '1' THEN
				inimigos_derrotados := inimigos_derrotados + 1;
				powerup_players_aux(1) <= 0;
			END IF;
			IF inimigos_derrotados = 5 THEN
				powerup_players_aux(1) <= 1;
				inimigos_derrotados := 1;
			END IF;
		END IF;
		powerup_players(1) <= powerup_players_aux(1);
	end process powerup_player_two;
end behavior; 