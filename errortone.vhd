LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY errortone is
	PORT (
		enabled : in std_logic;
		CLOCK_50 : in std_logic;
		I2C_SDAT : inout std_logic;
		I2C_SCLK, AUD_XCK : out std_logic;
		AUD_ADCDAT : in std_logic;
		AUD_DACDAT : out std_logic;
		AUD_ADCLRCK, AUD_DACLRCK, AUD_BCLK : in std_logic );
END errortone;


ARCHITECTURE Structural of errortone is

	SIGNAL initializer : std_logic := '1';
	SIGNAL	AudioIn, AudioOut : signed(15 downto 0);
	SIGNAL	SamClk : std_logic;
	SIGNAL	accum : signed(21 downto 0);
	
	COMPONENT AudioInterface is
	Generic ( SID : integer := 100 ); 
	Port (CLOCK_50 : in std_logic;
		init : in std_logic;

		I2C_SDAT : inout std_logic;
		I2C_SCLK, AudMclk : out std_logic;
		AUD_ADCDAT : in std_logic;
		AUD_DACDAT : out std_logic;
		AUD_ADCLRCK, AUD_DACLRCK, AUD_BCLK : in std_logic;
		
		SamClk : out std_logic;
		AudioIn : out signed(15 downto 0);
		AudioOut : in signed(15 downto 0));
	END COMPONENT;

BEGIN

--***********************************************************************************
-- You must enter the last five digits from the student number of one group member.
-- Ex: AudioInterface generic map ( SID => xxxxx ) - where xxxxx are the last 5 digits.
--
--***********************************************************************************
			assm: AudioInterface	generic map ( SID => 22222)
			PORT MAP( Clock_50 => CLOCK_50, AudMclk => AUD_XCK,	-- period is 80 ns ( 12.5 Mhz )
						init => initializer, 									-- +ve edge initiates I2C data
						I2C_Sclk => I2C_SCLK,
						I2C_Sdat => I2C_SDAT,
						AUD_BCLK => AUD_BCLK, AUD_ADCLRCK => AUD_ADCLRCK, AUD_DACLRCK => AUD_DACLRCK,
						AUD_ADCDAT => AUD_ADCDAT, AUD_DACDAT => AUD_DACDAT,
						AudioOut => AudioOut, AudioIn => AudioIn, SamClk => SamClk );
						
			process(enabled)
			begin
				if(rising_edge(enabled)) then
					initializer <= '0';
				end if;
			end process;
						
						
			process(SamClk)
			begin
				if(rising_edge(SamClk)) then
					accum <= accum + "000000001111111100000";
				else
					accum <= accum;
				end if;
			end process;

			AudioOut <= accum(21 downto 6) when enabled = '1' else (others  => '0');
	
	
	
END Structural;
