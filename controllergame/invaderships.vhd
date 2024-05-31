library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.tipagens.all;


entity invaderships is
port(
	reset: in std_logic;
	clock: in std_logic;
	pixel_invasores: out list_coordinates_invasores
);
end invaderships;

architecture behavior of invaderships is
	signal pixel_invasores_inicial: list_coordinates_invasores := (
	(200, 16), (200, 58), (200, 100), (200, 142), (200, 184), (200, 226), (200, 268), (200, 310), (200, 352), (200, 394), (200, 436), (200, 478), (200, 520), (200, 562), (200, 604),
	(220, 16), (220, 58), (220, 100), (220, 142), (220, 184), (220, 226), (220, 268), (220, 310), (220, 352), (220, 394), (220, 436), (220, 478), (220, 520), (220, 562), (220, 604),
	(240, 16), (240, 58), (240, 100), (240, 142), (240, 184), (240, 226), (240, 268), (240, 310), (240, 352), (240, 394), (240, 436), (240, 478), (240, 520), (240, 562), (240, 604)
	);

begin
	--200 = linha e 300 = coluna
	invasor: process(reset, clock)
	begin
		IF reset = '0' THEN
			pixel_invasores <= pixel_invasores_inicial;
		ELSIF rising_edge(clock) THEN
			pixel_invasores <= pixel_invasores_inicial;
		END IF;
	end process invasor;

end behavior;