library ieee;
use ieee.std_logic_1164.all;

library spaceinvaders;
use spaceinvaders.tipagens.all;


entity display is 
port(
	number: in std_logic_vector(0 to 3);
	pins_display: out std_logic_vector(0 to 6)
);
end display;

architecture behavior of display is

begin
	with number select
			pins_display <= "0000001" when "0000",
					 "1001111" when "0001",
					 "0010010" when "0010",
					 "0000110" when "0011",
					 "1001100" when "0100",
					 "0100100" when "0101",
					 "0100000" when "0110",
					 "0001111" when "0111",
					 "0000000" when "1000",
					 "0001100" when "1001",
					 "1111110" when others;

end behavior;