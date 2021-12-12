library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.definitions_package.all;

entity ASIP is
    port (
			pause : in std_logic;		--Pause button
     	  	clk : IN std_logic;			--System clock
			rst : IN std_logic;			--Soft Reset button
			hard_rst : IN std_logic;	--Hard Reset button
			stop_prog : IN std_logic;	--Stop button
    	    program : IN std_logic_vector(2 DOWNTO 0);	--program selection keys
    	    to_hex : out custArray2;					--Custom Array 2: 
    	    pce : out std_logic_vector(3 DOWNTO 0);		--Program execution counter
		  	error : out std_logic						--error 
    );
end ASIP;

architecture behaviour of ASIP is
    signal instSig : std_logic_vector (5 downto 0);
    signal toSegSig : custArray;
begin

	dataPath : entity work.datapath 
		port map(
			clk => clk, 			--system clock
			rst => rst, 			--reset button
			hard_rst => hard_rst, 	--Hard Reset Button
			stop_prog => stop_prog, --Stop button
			program => program, 	--program selection keys, sent from SMBD, sends to dataPath
			inst_out => instSig, 	--single instruction sent from the datapath, sends to control unit
			pce => pce				--program execution counter
		);

	controlUnit : entity  work.controlUnit 
		port map(
			clk => clk, 			--system clock
			rst => rst, 			--reset button
			hard_rst => hard_rst, 	--Hard Reset Button
			inst => instSig, 		--Instruction signal sent from datapath
			toSeg => toSegSig		--Instructions converted to 7 segment display std_logic_vectors, sent to IO_controller
		);

	IO_controller : entity work.IO_controller 
	port map(
			toSeg => toSegSig,		--7 segment display signal sent from the control unit
			to_hex => to_hex		--2d array of 7seg display vectors
		);

	error <= '1' when (instSig = "111111" and pause = '0') else '0';	--error case

end architecture;
