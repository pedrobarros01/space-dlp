library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.auxiliadores.all;

package auxiliadores is
	component divisorclock is
	port(
		clk: in std_logic;
		reset: in std_logic;
		clkout: out std_logic
	);
	end component;
	component clockdivideronehertz is
	port(
		clk: in std_logic;
		reset: in std_logic;
		clkout: out std_logic
	);
	end component;
	component display is
	port(
		number: in std_logic_vector(0 to 3);
		pins_display: out std_logic_vector(0 to 6)
	);
	end component;
end package;