library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.definitions_package.all;

entity IO_controller is
    port (
        toSeg : in custArray;   -- 5x7 std_logic_vector for instruction value (d)
        to_hex : out custArray2 -- 8x7 std_logic_vector array for hex input
    );
end IO_controller;

architecture behaviour of IO_controller is
    signal s0,s1,s2,s3,s4,s5,s6,s7 : std_logic_vector (6 downto 0);
begin

hex0:   entity work.c7s port map(D => toSeg(0), Y => s0); --c7s takes in std_logic_vectors of datawidth 7
hex1:   entity work.c7s port map(D => toSeg(1), Y => s1); --the input comes from toSeg, which comes from
hex2:   entity work.c7s port map(D => toSeg(2), Y => s2); --the datapath
hex3:   entity work.c7s port map(D => toSeg(3), Y => s3); 
hex4:   entity work.c7s port map(D => toSeg(4), Y => s4); --The output is sent to to_hex, which is sent to
hex5:   entity work.c7s port map(D => toSeg(5), Y => s5); --to the ASIP to be used in the SMDB
hex6:   entity work.c7s port map(D => toSeg(6), Y => s6);
hex7:   entity work.c7s port map(D => toSeg(7), Y => s7);

to_hex <= (s0,s1,s2,s3,s4,s5,s6,s7);    

end architecture;