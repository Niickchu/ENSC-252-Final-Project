library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.definitions_package.all;

use std.textio.all;
use std.env.finish;

entity controlUnit_tb is
end controlUnit_tb;

architecture sim of controlUnit_tb is

    constant clk_hz : integer := 100e6;
    constant clk_period : time := 1 sec / clk_hz;

    signal clk : std_logic := '1';
    signal rst : std_logic := '1';
    signal hard : std_logic := '0';
    signal instruction : std_logic_vector(5 downto 0) := "001001";
    signal output : custArray;

begin

    clk <= not clk after clk_period / 2;

    DUT : entity work.controlUnit
    port map (
        clk => clk,
        rst => rst,
        hard_rst => hard,
        inst => instruction,
        toSeg => output
    );

    SEQUENCER_PROC : process
    begin
        wait for clk_period * 2;
    end process;

end architecture;