library ieee;
use ieee.std_logic_1164.all;


package tipagens is
constant dimension: integer := 2;
constant quantidade_invasores: integer := 3;
constant limit_column_sprite: integer := 8;
constant limit_row_sprite: integer := 16;
type sprite_array is array(0 to limit_row_sprite - 1) of std_logic_vector(0 to limit_column_sprite - 1);
constant sprite_inv: sprite_array := (  
	"00000000",
   "00000000", 
   "00000000", 
   "00000000", 
   "00000000", 
   "00000000", 
   "00000000", 
   "00000000", 
   "11111110", --  *******
   "11111110", --  *******
   "11111110", --  *******
   "11111110", --  *******
   "00000000",
   "00000000", 
   "00000000",
   "00000000");
type list_coordinate_pixel is array(0 to dimension - 1) of integer;
type list_coordinates_invasores is array(0 to quantidade_invasores - 1) of list_coordinate_pixel;
end package;