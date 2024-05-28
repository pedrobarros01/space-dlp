library ieee;
use ieee.std_logic_1164.all;


entity pixelgen is
port(
	reset: in std_logic;
	clock: in std_logic;
	region: in std_logic;
	column_pixel: in integer;
	R: out std_logic;
	G: out std_logic;
	B: out std_logic
);
end pixelgen;

architecture behavior of pixelgen is
	SIGNAL RGBp : STD_LOGIC_VECTOR(2 DOWNTO 0); -- Valor atual do pixel
	SIGNAL RGBn : STD_LOGIC_VECTOR(2 DOWNTO 0);

begin
	 R <= RGBp(2) AND region;
    G <= RGBp(1) AND region;
    B <= RGBp(0) AND region;
	 --80x80
	RGBn <= "000" WHEN column_pixel = 0 ELSE -- Preto (Coluna = 0)
                "001" WHEN column_pixel = 60 ELSE -- Azul (Coluna = 100)
                "010" WHEN column_pixel = 120 ELSE -- Verde (Coluna = 200)
                "011" WHEN column_pixel = 180 ELSE -- Ciano (Coluna = 300)
                "100" WHEN column_pixel = 240 ELSE -- Vermelho (Coluna = 400)
                "101" WHEN column_pixel = 300 ELSE -- Magenta (Coluna = 500)
                "110" WHEN column_pixel = 360 ELSE -- Amarelo (Coluna = 600)
                "111" WHEN column_pixel = 420 ELSE -- Branco (Coluna = 700)
                RGBp; --Último valor definido

	gerador: process(reset, clock)
	begin
		IF reset = '0' THEN
			RGBp <= (others => '0');
		ELSIF rising_edge(clock) THEN
			RGBp <= RGBn;	
		END IF;
	end process gerador;

end behavior;