LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

package definitions_package is

type intArray is array(7 downto 0) of integer range 0 to 19;        --integer array. Used for making code more readable
type custArray is array(7 downto 0) of std_logic_vector(4 downto 0);    -- 5x7 std_logic_vector for instruction value (d)
type custArray2 is array(7 downto 0) of std_logic_vector(6 downto 0);   -- 8x7 std_logic_vector array for hex input

type instructions is (none, error, done,
                    a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11,
                    b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11,
                    c1, c2, c3, c4, c5, c6, c7,	c8, c9, c10, c11, c12, c13, c14,
                    d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16);

end package definitions_package;

package body definitions_package is
end package body definitions_package;
