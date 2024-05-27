library ieee;
use ieee.std_logic_1164.all;


entity pixelgen is
port(
	reset: in std_logic;
	clock: in std_logic;
	region: in std_logic;
	column_pixel: in integer;
	r: out std_logic_vector(3 downto 0);
	g: out std_logic_vector(3 downto 0);
	b: out std_logic_vector(3 downto 0)
);
end pixelgen;

architecture behavior of pixelgen is
	signal Raux: std_logic_vector(3 downto 0);
	signal Gaux: std_logic_vector(3 downto 0);
	signal Baux: std_logic_vector(3 downto 0);
	

begin
	Raux <= "1110" when column_pixel >= 0 and column_pixel < 200 ELSE
			  "0000";
	Gaux <= "1110" when column_pixel >= 200 and column_pixel < 400 ELSE
			  "0000";
	Baux <= "1110" when column_pixel >= 400 and column_pixel <= 639 ELSE
			  "0000";
	

	gerador: process(reset, clock)
	begin
		IF reset = '0' THEN
			r <= "0000";
			g <= "0000";
			b <= "0000";
		ELSIF rising_edge(clock) THEN
			IF(region = '1') THEN
				r <= Raux;
				g <= Gaux;
				b <= Baux;
			END IF;
		
		END IF;
	end process gerador;

end behavior;