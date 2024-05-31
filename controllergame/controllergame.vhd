library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.controllergame.all;
use spaceinvaders.tipagens.all;
package controllergame is
	component pixelgen is
	port(
		reset: in std_logic;
		clock: in std_logic;
		region: in std_logic;
		column_pixel: in integer;
		R: out std_logic;
		G: out std_logic;
		B: out std_logic
	);
	end component;
	component invaderships is
	port(
		reset: in std_logic;
		clock: in std_logic;
		pixel_invasores: out list_coordinates_invasores
	);
	
	end component;
	component desenhotela is
	port(
		reset: in std_logic;
		clock: in std_logic;
		region: in std_logic;
		row_pixel: in integer;
		column_pixel: in integer;
		coord_inv: in list_coordinates_invasores;
		coord_player: in list_coordinates_players;
		R: out std_logic;
		G: out std_logic;
		B: out std_logic
);
	end component;
	component playership is
	port (
		reset: in std_logic;
		clock: in std_logic;
		player: in integer;
		movimento: in std_logic_vector(0 to 1);
		coord_player: out list_coordinates_players
	
	);
	end component;
	

end package;