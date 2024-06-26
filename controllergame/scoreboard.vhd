library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library spaceinvaders;
use spaceinvaders.tipagens.all;

entity scoreboard is
port(
	reset: in std_logic;
	clock: in std_logic;
	tiro_players_collision: in std_logic_vector(0 to quantidade_players - 1);
	powerup_players: in list_powerup_player;
	estado_jogo: in states_game;
	score_player_one: out integer;
	score_player_two: out integer;
	score_segment_player_one: out list_display_player_score;
	score_Segment_player_two: out list_display_player_score
);
end scoreboard;

architecture behavior of scoreboard is
	
begin
	score_player_one_proc: process(reset, clock)
		variable score: integer := 0;
		variable digit_dec: std_logic_vector(0 to 3) := "0000";
		variable digit_uni: std_logic_vector(0 to 3) := "0000";
	begin
		IF reset = '0' THEN
			digit_dec := "0000";
			digit_uni := "0000";
			score := 0;
		ELSIF rising_edge(clock) THEN
		 IF estado_jogo = GAMERSTART THEN
			IF tiro_players_collision(0) = '1' THEN
					score := score + 1 + powerup_players(0);
			END IF;
			digit_dec := std_logic_vector(to_unsigned(score / 10, 4));
			digit_uni := std_logic_vector(to_unsigned(score mod 10, 4));
		 END IF;
		END IF;
		score_player_one <= score;
		score_segment_player_one(0) <= digit_dec;
		score_segment_player_one(1) <= digit_uni;
	end process score_player_one_proc;
	
	score_player_two_proc: process(reset, clock)
		variable score: integer := 0;
		variable digit_dec: std_logic_vector(0 to 3) := "0000";
		variable digit_uni: std_logic_vector(0 to 3) := "0000";
	begin
		IF reset = '0' THEN
			digit_dec := "0000";
			digit_uni := "0000";
			score := 0;
		ELSIF rising_edge(clock) THEN
			IF estado_jogo = GAMERSTART THEN
				IF tiro_players_collision(1) = '1' THEN
						score := score + 1 + powerup_players(1);
				END IF;
				digit_dec := std_logic_vector(to_unsigned(score / 10, 4));
				digit_uni := std_logic_vector(to_unsigned(score mod 10, 4));
			END IF;		
		END IF;
		score_player_two <= score;
		score_Segment_player_two(0) <= digit_dec;
		score_Segment_player_two(1) <= digit_uni;
	end process score_player_two_proc;

end behavior;