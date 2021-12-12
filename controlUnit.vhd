library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.definitions_package.all;

entity controlUnit is
    generic (n: integer := 20);
    port (
        clk : IN std_logic;     --system clock, reset and hard reset buttons
        rst: IN std_logic;
        hard_rst : IN std_logic;
        inst : IN std_logic_vector(5 downto 0); --instructions sent from the scheduler
        toSeg : OUT custArray                   -- 5x7 std_logic_vector for instruction value (d)
    );
end controlUnit;

architecture behaviour of controlUnit is
    signal Qout : intArray;
begin

-------------------------------------------------
-- process(clk)
-- On rising edges, when instructions are sent in
-- from the scheduler, the integer instruction
-- equivalent is created, and sent to the ASIP
-------------------------------------------------

    process(clk)
        begin
            if(rising_edge(clk)) then
                case inst is
                    when "000000" =>
                        Qout <= (0,0,0,0,0,0,0,0);  --All off
                    when "000001" =>
                        Qout <= (0,0,0,0,0,0,0,1);  --Begin Snake Left
                    when "000010" =>
                        Qout <= (0,0,0,0,0,0,1,2); 
                    when "000011" =>
                        Qout <= (0,0,0,0,0,1,2,2); 
                    when "000100" =>
                        Qout <= (0,0,0,0,1,2,2,3); 
                    when "000101" =>
                        Qout <= (0,0,0,1,2,2,3,0); 
                    when "000110" =>
                        Qout <= (0,0,1,2,2,3,0,0); 
                    when "000111" =>
                        Qout <= (0,1,2,2,3,0,0,0); 
                    when "001000" =>
                        Qout <= (1,2,2,3,0,0,0,0); 
                    when "001001" =>
                        Qout <= (2,2,3,0,0,0,0,0); 
                    when "001010" =>
                        Qout <= (2,3,0,0,0,0,0,0); 
                    when "001011" =>
                        Qout <= (3,0,0,0,0,0,0,0);   --End Snake Left
                    when "001100" =>
                        Qout <= (5,0,0,0,0,0,0,0);   --Begin Snake Right
                    when "001101" =>
                        Qout <= (2,5,0,0,0,0,0,0); 
                    when "001110" =>
                        Qout <= (2,2,5,0,0,0,0,0);     
                    when "001111" =>
                        Qout <= (4,2,2,5,0,0,0,0);
                    when "010000" =>        
                        Qout <= (0,4,2,2,5,0,0,0);
                    when "010001" =>
                        Qout <= (0,0,4,2,2,5,0,0);
                    when "010010" =>
                        Qout <= (0,0,0,4,2,2,5,0);
                    when "010011" =>
                        Qout <= (0,0,0,0,4,2,2,5);
                    when "010100" =>
                        Qout <= (0,0,0,0,0,4,2,2);
                    when "010101" =>
                        Qout <= (0,0,0,0,0,0,4,2);
                    when "010110" =>
                        Qout <= (0,0,0,0,0,0,0,4);   --End Snake Right
                    when "010111" =>
                        Qout <= (0,0,0,0,0,0,0,6);   --Begin Fly in Hex0
                    when "011000" =>
                        Qout <= (0,0,0,0,0,0,0,7);
                    when "011001" =>
                        Qout <= (0,0,0,0,0,0,0,8);
                    when "011010" =>
                        Qout <= (0,0,0,0,0,0,0,9);
                    when "011011" =>
                        Qout <= (0,0,0,0,0,0,0,10);
                    when "011100" =>
                        Qout <= (0,0,0,0,0,0,0,11);
                    when "011101" =>
                        Qout <= (0,0,0,0,0,0,0,12);   --End Fly in Hex0
                    when "011110" =>
                        Qout <= (0,0,0,0,0,0,0,13);   --Begin scrolling Message "bing bong"
                    when "011111" =>
                        Qout <= (0,0,0,0,0,0,13,14);
                    when "100000" =>   
                        Qout <= (0,0,0,0,0,13,14,15);        
                    when "100001" =>
                        Qout <= (0,0,0,0,13,14,15,16);
                    when "100010" =>
                        Qout <= (0,0,0,13,14,15,16,0);
                    when "100011" =>
                        Qout <= (0,0,13,14,15,16,0,13);
                    when "100100" =>
                        Qout <= (0,13,14,15,16,0,13,17);
                    when "100101" =>
                        Qout <= (13,14,15,16,0,13,17,15);
                    when "100110" =>
                        Qout <= (14,15,16,0,13,17,15,16);
                    when "100111" =>
                        Qout <= (15,16,0,13,17,15,16,0);
                    when "101000" =>
                        Qout <= (16,0,13,17,15,16,0,0);
                    when "101001" =>
                        Qout <= (0,13,17,15,16,0,0,0);
                    when "101010" =>
                        Qout <= (13,17,15,16,0,0,0,0);
                    when "101011" =>
                        Qout <= (17,15,16,0,0,0,0,0);
                    when "101100" =>
                        Qout <= (15,16,0,0,0,0,0,0);
                    when "101101" =>
                        Qout <= (16,0,0,0,0,0,0,0);  --End scrolling Message "bing bong"
                    when "101110" =>
                        Qout <= (0,0,0,0,0,0,6,0);   --Begin Fly in Hex1
                    when "101111" =>
                        Qout <= (0,0,0,0,0,0,7,0);
                    when "110000" =>
                        Qout <= (0,0,0,0,0,0,8,0);
                    when "110001" =>
                        Qout <= (0,0,0,0,0,0,9,0);
                    when "110010" =>
                        Qout <= (0,0,0,0,0,0,10,0);
                    when "110011" =>
                        Qout <= (0,0,0,0,0,0,11,0);
                    when "110100" =>
                        Qout <= (0,0,0,0,0,0,12,0);   --End Fly in Hex1
                    when "111111" =>
                        Qout <= (0,0,0,0,0,18,19,19); --Error message "brr"
                    when others =>
                        Qout <= (0,0,0,0,0,0,0,0);    --Default, all off
                end case;
                else
						Qout <= Qout;
            end if;
    end process;
	 
	 toSeg <= ( 
            std_logic_vector(to_unsigned (Qout(0), 5)), --each integer in the Qout array is converted to
            std_logic_vector(to_unsigned (Qout(1), 5)), --its binary equivalent, and sent through
            std_logic_vector(to_unsigned (Qout(2), 5)), --toSeg (5x7), which is used for sending instructions
            std_logic_vector(to_unsigned (Qout(3), 5)),
            std_logic_vector(to_unsigned (Qout(4), 5)), 
            std_logic_vector(to_unsigned (Qout(5), 5)), 
            std_logic_vector(to_unsigned (Qout(6), 5)), 
            std_logic_vector(to_unsigned (Qout(7), 5))
                );

end architecture;