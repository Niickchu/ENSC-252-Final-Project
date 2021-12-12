library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.textio.all;
use std.env.finish;

entity clockcontrol_tb is
end clockcontrol_tb;

architecture sim of clockcontrol_tb is

    constant clk_hz : integer := 100e6;
    constant clk_period : time := 1 sec / clk_hz;

    signal clk : std_logic := '1';
    signal clk_out : std_logic;
    signal speed : std_logic_vector(1 downto 0) := "00";

begin

    clk <= not clk after clk_period / 2;

    DUT : entity work.clockcontrol
    port map (
        clk => clk,
        speed => speed,
        clk_out => clk_out
    );

    SEQUENCER_PROC : process
    begin
        wait for clk_period * 2;
    end process;

end architecture;