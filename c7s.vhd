library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity c7s is
    generic(n : integer := 13);
    port (
        D : in std_logic_vector(4 downto 0);
        Y : out std_logic_vector(6 downto 0)
    );
end c7s;

architecture cust_seg of c7s is
begin

-------------------------------------------------
-- process(D)
-- On rising edges, when instructions are sent in
-- from the ASIP, the 7 segment display equivalent
-- is created and sent back to the ASIP, for use
-- in displaying the images
-------------------------------------------------

    process(D)
        begin
            case D is
                when "00000" => 
                    Y <= "1111111";  -- all off
                when "00001" =>
                    Y <= "1111000";  -- 7 or left snake head
                when "00010" =>
                    Y <= "1001000";  -- Tall n or snake body
                when "00011" =>
                    Y <= "1000111";	 -- L or left snake tail
                when "00100" =>
                    Y <= "1110001";  -- Right snake tail
                when "00101" =>
                    Y <= "1001110";	 -- Right snake head
                when "00110" =>
                    Y <= "0111111";	 -- fly position 6
                when "00111" =>
                    Y <= "1011111";	 -- fly position 5
                when "01000" =>
                    Y <= "1111110";	 -- fly position 0
                when "01001" =>
                    Y <= "1111101";	 -- fly position 1
                when "01010" =>
                    Y <= "1101111";	 -- fly position 4
                when "01011" =>
                    Y <= "1110111";	 -- fly position 3
                when "01100" =>
                    Y <= "1111011";	 -- fly position 2
                when "01101" =>
                    Y <= "0000011";	 -- B
                when "01110" =>
                    Y <= "1001111";	 -- I
                when "01111" =>
                    Y <= "1001000";	 -- N
                when "10000" =>
                    Y <= "0010000";	 -- G
                when "10001" =>
                    Y <= "1000000";	 -- O
				when "10010" =>
					Y <= "0000011";	 -- b
				when "10011" =>
					Y <= "0101111";	 -- r
                when others =>
                    Y <= "1111111";	 -- default, all off
            end case;
    end process;

end architecture;