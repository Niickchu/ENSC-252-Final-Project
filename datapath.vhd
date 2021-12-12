library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity datapath is
	PORT (
		clk : IN std_logic;
		rst : IN std_logic;
		hard_rst : IN std_logic;
		stop_prog : IN std_logic;
		program : IN std_logic_vector(2 DOWNTO 0);
		inst_out : OUT std_logic_vector(5 DOWNTO 0);
		pce : OUT std_logic_vector(3 downto 0)
	);
end datapath;

architecture instandcount of datapath is
	signal counter : unsigned(3 downto 0) := "0000";
	signal finished : std_logic;
begin

	scheduler : entity work.sched 
		port map(
			clk => clk, 
			rst => rst, 
			hard_rst => hard_rst, 
			stop_prog => stop_prog, 
			program => program, 
			inst_out => inst_out, 
			pce => finished
		);
	
	process(finished, clk)
	begin
		if(hard_rst = '1') then
			counter <= "0000";
		elsif(rising_edge(finished)) then
			counter <= counter + 1;
		else
			counter <= counter;
		end if;
	end process;

	pce <= std_logic_vector(counter);
	
end;