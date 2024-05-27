library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisorclock is
port(
	clk: in std_logic;
	clkout: out std_logic
);
end divisorclock;


architecture divisor of divisorclock is
	signal clockaux: std_logic;
begin
	clock: process
		variable cont: integer := 0;
		variable descida: boolean := false;
	begin
		wait until rising_edge(clk);
		cont := cont + 1;
		if(cont = 2 ) then
			clockaux <= not clockaux;
			cont := 0;
		end if;
	end process clock;
	clkout <= clockaux;
end divisor;