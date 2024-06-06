library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity clockdivideronehertz is
port(
	clk: in std_logic;
	reset: in std_logic;
	clkout: out std_logic
);
end clockdivideronehertz;

architecture behavior of clockdivideronehertz is
	signal count: integer := 1;
	signal temp: std_logic := '0';

begin
	process(reset, clk)
	begin
		IF reset = '0' THEN
			count <= 1;
			temp <= '0';
		ELSIF rising_edge(clk) THEN
			count <= count + 1;
			IF count = 1666666 THEN
				temp <= not temp;
				count <= 1;
			END IF;
		END IF;
		clkout <= temp;
	end process;

end behavior;