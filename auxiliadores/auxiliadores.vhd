library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.auxiliadores.all;

package auxiliadores is
	component divisorclock is
	port(
		clk: in std_logic;
		clkout: out std_logic
	);
	end component;

end package;