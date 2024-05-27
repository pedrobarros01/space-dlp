library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.controllergame.all;

package controllergame is
	component pixelgen is
	port(
		reset: in std_logic;
		clock: in std_logic;
		region: in std_logic;
		column_pixel: in integer;
		r: out std_logic_vector(3 downto 0);
		g: out std_logic_vector(3 downto 0);
		b: out std_logic_vector(3 downto 0)
	);
	end component;

end package;