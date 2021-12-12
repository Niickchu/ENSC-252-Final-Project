LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.definitions_package.ALL;

ENTITY sched IS
	PORT (
		clk : IN std_logic;
		rst : IN std_logic;
		hard_rst : IN std_logic;
		stop_prog : IN std_logic;
		program : IN std_logic_vector(2 DOWNTO 0);
		inst_out : OUT std_logic_vector(5 DOWNTO 0);
		pce : OUT std_logic
	);
END sched;

ARCHITECTURE createinst OF sched IS
	TYPE main_types IS (idle, snakel, snaker, fly, word, error);
	SIGNAL main_state : main_types := idle;
	SIGNAL sstate : instructions := none;
	SIGNAL temp_out : INTEGER := 0;
	SIGNAL finished : std_logic := '0';
	SIGNAL flying : std_logic := '0';
BEGIN
	PROCESS (clk)
	BEGIN
		IF (hard_rst = '1' OR rst = '1') THEN
			main_state <= idle;
			sstate <= none;
			temp_out <= 0;
		ELSIF (stop_prog = '1' AND flying = '1') THEN
			flying <= '0';
			main_state <= idle;
			sstate <= none;
			temp_out <= 0;
		ELSIF (rising_edge(clk)) THEN
			CASE main_state IS
				WHEN idle => 
					finished <= '0';
					temp_out <= 0;
					IF (program = "000") THEN
						temp_out <= 0;
						main_state <= idle;
						sstate <= none;
					ELSIF (program = "001") THEN
						main_state <= snakel;
						sstate <= a1;
					ELSIF (program = "010") THEN
						main_state <= snaker;
						sstate <= b1;
					ELSIF (program = "011") THEN
						main_state <= fly;
						sstate <= c1;
					ELSIF (program = "100") THEN
						main_state <= word;
						sstate <= d1;
					ELSE
						main_state <= error;
					END IF;
				WHEN snakel => 
					CASE sstate IS
						WHEN a1 => sstate <= a2;
						temp_out <= 1;
						WHEN a2 => sstate <= a3;
						temp_out <= 2;
						WHEN a3 => sstate <= a4;
						temp_out <= 3;
						WHEN a4 => sstate <= a5;
						temp_out <= 4;
						WHEN a5 => sstate <= a6;
						temp_out <= 5;
						WHEN a6 => sstate <= a7;
						temp_out <= 6;
						WHEN a7 => sstate <= a8;
						temp_out <= 7;
						WHEN a8 => sstate <= a9;
						temp_out <= 8;
						WHEN a9 => sstate <= a10;
						temp_out <= 9;
						WHEN a10 => sstate <= a11;
						temp_out <= 10;
						WHEN a11 => sstate <= done;
						temp_out <= 11;
						WHEN done => 
							main_state <= idle;
							sstate <= none;
							temp_out <= 0;
							finished <= '1';
						WHEN OTHERS => temp_out <= 63;
						sstate <= none;
				END CASE;
				WHEN snaker => 
					CASE sstate IS
						WHEN b1 => sstate <= b2;
						temp_out <= 12;
						WHEN b2 => sstate <= b3;
						temp_out <= 13;
						WHEN b3 => sstate <= b4;
						temp_out <= 14;
						WHEN b4 => sstate <= b5;
						temp_out <= 15;
						WHEN b5 => sstate <= b6;
						temp_out <= 16;
						WHEN b6 => sstate <= b7;
						temp_out <= 17;
						WHEN b7 => sstate <= b8;
						temp_out <= 18;
						WHEN b8 => sstate <= b9;
						temp_out <= 19;
						WHEN b9 => sstate <= b10;
						temp_out <= 20;
						WHEN b10 => sstate <= b11;
						temp_out <= 21;
						WHEN b11 => sstate <= done;
						temp_out <= 22;
						WHEN done => 
							main_state <= idle;
							sstate <= none;
							temp_out <= 0;
							finished <= '1';
						WHEN OTHERS => temp_out <= 63;
						sstate <= none;
				END CASE;
				WHEN fly => 
					flying <= '1';
					CASE sstate IS
						WHEN c1 => 
							temp_out <= 23;
							sstate <= c2;
							finished <= '0';
						WHEN c2 => 
							temp_out <= 24;
							sstate <= c3;
						WHEN c3 => 
							temp_out <= 25;
							sstate <= c4;
						WHEN c4 => 
							temp_out <= 26;
							sstate <= c5;
						WHEN c5 => 
							temp_out <= 27;
							sstate <= c6;
						WHEN c6 => 
							temp_out <= 28;
							sstate <= c7;
						WHEN c7 => 
							temp_out <= 29;
							sstate <= c8;
						WHEN c8 => 
							temp_out <= 46;
							sstate <= c9;
						WHEN c9 => 
							temp_out <= 47;
							sstate <= c10;
						WHEN c10 => 
							temp_out <= 48;
							sstate <= c11;
						WHEN c11 => 
							temp_out <= 49;
							sstate <= c12;
						WHEN c12 => 
							temp_out <= 50;
							sstate <= c13;
						WHEN c13 => 
							temp_out <= 51;
							sstate <= c14;
						WHEN c14 => 
							temp_out <= 52;
							sstate <= c1;
							finished <= '1';
						WHEN done => 
							main_state <= idle;
							sstate <= none;
							temp_out <= 0;
							finished <= '1';
						WHEN OTHERS => temp_out <= 63;
						sstate <= none;
				END CASE;
				WHEN word => 
					CASE sstate IS
						WHEN d1 => 
							temp_out <= 30;
							sstate <= d2;
						WHEN d2 => 
							temp_out <= 31;
							sstate <= d3;
						WHEN d3 => 
							temp_out <= 32;
							sstate <= d4;
						WHEN d4 => 
							temp_out <= 33;
							sstate <= d5;
						WHEN d5 => 
							temp_out <= 34;
							sstate <= d6;
						WHEN d6 => 
							temp_out <= 35;
							sstate <= d7;
						WHEN d7 => 
							temp_out <= 36;
							sstate <= d8;
						WHEN d8 => 
							temp_out <= 37;
							sstate <= d9;
						WHEN d9 => 
							temp_out <= 38;
							sstate <= d10;
						WHEN d10 => 
							temp_out <= 39;
							sstate <= d11;
						WHEN d11 => 
							temp_out <= 40;
							sstate <= d12;
						WHEN d12 => 
							temp_out <= 41;
							sstate <= d13;
						WHEN d13 => 
							temp_out <= 42;
							sstate <= d14;
						WHEN d14 => 
							temp_out <= 43;
							sstate <= d15;
						WHEN d15 => 
							temp_out <= 44;
							sstate <= d16;
						WHEN d16 => 
							temp_out <= 45;
							sstate <= done;
						WHEN done => 
							main_state <= idle;
							sstate <= none;
							temp_out <= 0;
							finished <= '1';
						WHEN OTHERS => temp_out <= 63;
						sstate <= none;
				END CASE;
				WHEN error => temp_out <= 63;
				main_state <= idle;
				WHEN OTHERS => main_state <= idle;
				sstate <= none;
			END CASE;

		ELSE
			main_state <= main_state;
			sstate <= sstate;
			temp_out <= temp_out;
		END IF;
	END PROCESS;

	pce <= finished;
	inst_out <= std_logic_vector(to_unsigned(temp_out, inst_out'length));
END createinst;