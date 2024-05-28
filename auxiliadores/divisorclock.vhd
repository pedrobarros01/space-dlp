library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisorclock is
port(
	clk: in std_logic;
	reset: in std_logic;
	clkout: out std_logic
);
end divisorclock;


architecture divisor of divisorclock is
	signal clockaux: std_logic;
begin

	process ( clk, reset)
	begin
		if ( reset = '0' ) then
			clkout	<=	'0';
		elsif rising_edge (clk) then
			clockaux <=	not (clockaux);
		end if;
		clkout <= clockaux;
	end process;
	
end divisor;