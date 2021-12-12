library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.textio.all;
use std.env.finish;

entity c7s_tb is
end c7s_tb;

architecture sim of c7s_tb is
    COMPONENT c7s IS --the component we would like to test
	generic(n : integer := 13);
    port (
        D : in integer range 0 to n;
        Y : out std_logic_vector(6 downto 0)
    );
	END COMPONENT;

    constant clk_hz : integer := 100e6;
    constant clk_period : time := 1 sec / clk_hz;

    signal Dtb : integer range 0 to 13 := 0;
    signal Ytb : std_logic_vector(6 downto 0) := "1111111";

begin
    DUT : c7s
    port map (D => Dtb, Y => Ytb);

    Dtb <= Dtb + 1 after clk_period / 2;

end architecture;