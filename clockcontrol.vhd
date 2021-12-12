library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clockcontrol is
    generic(n : integer := 20);
    port (
        clk : in std_logic;
        speed : in std_logic_vector(1 downto 0);
		  pause : in std_logic;
        clk_out : out std_logic
    );
end clockcontrol;

architecture speedselect of clockcontrol is
signal temp_clk : unsigned(n downto 0) := (others => '0');
signal incr : unsigned(2 downto 0);

begin
    process(speed)
    begin
        if(speed = "00") then
            incr <= "010";
        elsif(speed = "01") then
            incr <= "100";
        elsif(speed = "10") then
            incr <= "111";
        elsif(speed = "11") then
            incr <= "001";
        end if;
    end process;

    process(clk)
        begin
			if(pause = '1') then
					temp_clk <= temp_clk;
            elsif(rising_edge(clk)) then
                temp_clk <= temp_clk + incr;
            end if;
    end process;

    clk_out <= temp_clk(n);

end architecture;