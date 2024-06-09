library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library spaceinvaders;
use spaceinvaders.tipagens.all;

entity playership is
port(
	reset: in std_logic;
	clock: in std_logic;
	player: in integer;
	movimento: in std_logic_vector(0 to 1);
	coord_player: out list_coordinates_players
);
end playership;

architecture behavior of playership is
	signal inicio: std_logic := '1';
	signal coord_player_initial: list_coordinates_players := ( (400, 328), (400, 528));
	signal coord_player_mov: list_coordinates_players := coord_player_initial;
begin
	--movimento(0) - esquerda
	--movimento(1) - direita
	mov_player: process(reset, clock)
		variable mov_size: integer := 2;
		variable mov_column: integer;
	begin
		IF reset = '0' THEN
			coord_player(player) <= coord_player_mov(player);
		ELSIF rising_edge(clock) THEN
				IF movimento(0) = '0' and movimento(1) = '1'  THEN
					mov_column := coord_player_mov(player)(1) - mov_size;
					IF mov_column < 0 THEN
						mov_column := 0;
					END IF;
					coord_player_mov(player)(1) <= mov_column;
				ELSIF movimento(0) = '1' and movimento(1) = '0' THEN
					mov_column := coord_player_mov(player)(1) + mov_size;
					IF mov_column > 611 THEN
						mov_column := 611;
					END IF;
					coord_player_mov(player)(1) <= mov_column;
				END IF;
		END IF;
		coord_player(player) <= coord_player_mov(player);
	end process mov_player;

end behavior;