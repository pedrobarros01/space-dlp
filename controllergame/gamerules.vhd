library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.tipagens.all;

entity gamerules is
port(
	reset: in std_logic;
	clock: in std_logic;
	life_invasores: in list_invasores_life;
	life_players: in list_life_players;
	score_player_one: in integer;
	score_player_two: in integer;
	player_win: out integer;
	estado_jogo: out states_game
);
end gamerules;

architecture behavior of gamerules is
	signal state_rule_one: states_game;
	signal state_rule_two: states_game;
	signal player_win_aux: integer;
begin
	estado_jogo <= GAMEROVER when state_rule_two = GAMEROVER ELSE
						GAMERSTART when state_rule_two = GAMERSTART and state_rule_one = GAMERSTART ELSE
						PLAYEROVER;
	rule_kill_all_enemys: process(reset, clock)
	variable enemys_dieds: integer := 0;
	variable player_won: integer;
	begin
		IF reset = '0' THEN
		
		ELSIF rising_edge(clock) THEN
			enemys_dieds := 37;
			FOR inv in 0 to quantidade_invasores - 1 LOOP
				IF life_invasores(inv) = 0 THEN
					enemys_dieds := enemys_dieds + 1;
				END IF;
			END LOOP;
			IF enemys_dieds = 38 THEN
				IF score_player_one > score_player_two THEN
					player_won := 0;
				ELSE
					player_won := 1;
				END IF;
				player_win_aux  <= player_won;
				state_rule_one <= PLAYEROVER;
			ELSE
				player_win_aux  <= -1;
				state_rule_one <= GAMERSTART;
			END IF;
		END IF;
		player_win <= player_win_aux;
	end process rule_kill_all_enemys;
	rule_two_player_died: process(reset, clock)
	begin
		IF reset = '0' THEN
			
		ELSIF rising_edge(clock) THEN
			IF life_players(0) <= 0  and life_players(1) <= 0 THEN
				state_rule_two <= GAMEROVER;
			ELSE
				state_rule_two <= GAMERSTART;
			end if;
		END IF;
	end process rule_two_player_died;

end behavior;