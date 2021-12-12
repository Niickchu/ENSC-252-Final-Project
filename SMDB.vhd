library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE work.definitions_package.ALL;


entity SMDB is
	port(CLOCK_50 : in std_logic;
			SW : in std_logic_vector(17 downto 0);
			KEY : in std_logic_vector(3 downto 0);
			HEX0 : out std_logic_vector(6 downto 0);
			HEX1 : out std_logic_vector(6 downto 0);
			HEX2 : out std_logic_vector(6 downto 0);
			HEX3 : out std_logic_vector(6 downto 0);
			HEX4 : out std_logic_vector(6 downto 0);
			HEX5 : out std_logic_vector(6 downto 0);
			HEX6 : out std_logic_vector(6 downto 0);
			HEX7 : out std_logic_vector(6 downto 0);
			LEDG : out std_logic_vector(3 downto 0);
			LEDR : out std_logic_vector(3 downto 0);
			I2C_SDAT : inout std_logic;
			I2C_SCLK, AUD_XCK : out std_logic;
			AUD_ADCDAT : in std_logic;
			AUD_DACDAT : out std_logic;
			AUD_ADCLRCK, AUD_DACLRCK, AUD_BCLK : in std_logic
			);
end SMDB;

architecture scrollingmessage of SMDB is

signal temp_clk : std_logic;
signal hex_displays : custArray2;
signal hard_rst : std_logic;
signal rst : std_logic;
signal pause : std_logic;
signal stop_prog : std_logic;
signal error_out : std_logic;

begin

	clock_controller : entity work.clockcontrol generic map(23) port map(clk => CLOCK_50, speed => SW(17 downto 16), pause => pause, clk_out => temp_clk);
	debounce_pause : entity work.debouncer generic map(4) port map(CLOCK_50, pause, SW(15), pause);
		
	debounce_hrst : entity work.debouncer generic map(4) port map(CLOCK_50, SW(3), SW(4), hard_rst);
	debounce_rst : entity work.debouncer generic map(4) port map(CLOCK_50, SW(3), SW(3), rst);
	debounce_stop_prog : entity work.debouncer generic map(4) port map(CLOCK_50, SW(3), KEY(1), stop_prog);
	
	
	asip : entity work.ASIP port map(pause, clk => temp_clk, rst => rst, hard_rst => hard_rst, stop_prog => not stop_prog, program => SW(2 downto 0), to_hex => hex_displays, pce => LEDG, error => error_out);
	
	error_gen : entity work.errortone port map(error_out, CLOCK_50, I2C_SDAT, I2C_SCLK, AUD_XCK, AUD_ADCDAT, AUD_DACDAT, AUD_ADCLRCK, AUD_DACLRCK, AUD_BCLK);
	
	
	HEX0 <= hex_displays(0);
	HEX1 <= hex_displays(1);
	HEX2 <= hex_displays(2);
	HEX3 <= hex_displays(3);
	HEX4 <= hex_displays(4);
	HEX5 <= hex_displays(5);
	HEX6 <= hex_displays(6);
	HEX7 <= hex_displays(7);
	
	
end scrollingmessage;
		