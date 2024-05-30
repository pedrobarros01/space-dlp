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

begin
	--200 = linha e 300 = coluna
	invasor: process(reset, clock)
	begin
		IF reset = '0' THEN
			pixel_invasores <= ((200, 300), (200, 350), (200, 400));
		ELSIF rising_edge(clock) THEN
			pixel_invasores <= ((200, 300), (200, 350), (200, 400));
		END IF;
	end process invasor;

end behavior;