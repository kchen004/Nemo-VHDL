
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--use ieee.math_real.all; -- for UNIFORM, TRUNC
--use ieee.numeric_std.all; -- for TO_UNSIGNED


entity enemy is
	port (
		clk 		: in  STD_LOGIC;
		jellydie : in std_logic;
		Enemy1out	: out STD_LOGIC_VECTOR (31 downto 0);
		Enemy2out	: out STD_LOGIC_VECTOR (31 downto 0);
		Enemy3out	: out STD_LOGIC_VECTOR (31 downto 0);
		Enemy4out	: out STD_LOGIC_VECTOR (31 downto 0);
		Enemy5out	: out STD_LOGIC_VECTOR (31 downto 0);
		Enemy6out	: out STD_LOGIC_VECTOR (31 downto 0);
		Enemy7out	: out STD_LOGIC_VECTOR (31 downto 0);
		Enemy8out	: out STD_LOGIC_VECTOR (31 downto 0)
	);
end enemy;

architecture Behavioral of enemy is
	
	signal enemy_create_timer1 : integer := 0; 
	signal threeBitRand1 : std_logic_vector (2 downto 0) := "010"; 
	signal threeBitRand2 : std_logic_vector (2 downto 0) := "001"; 
	signal tenBitRand : std_logic_vector (9 downto 0) := "0100101100"; 
	signal tenBitRand2 : std_logic_vector (9 downto 0):= "0101000100"; 
	signal oneBitRand : std_logic_vector (0 downto 0):= "1";
	signal sevenBitRand : std_logic_vector (6 downto 0) := "0100100";
	signal sevenBitRand2 : std_logic_vector (6 downto 0) := "0101101";

	--data contain the information about the enemy
	-- exist or not  			y direction   x speed 		y speed   		 x pos      y pos
	--"(31downto31)	0000 (26downto26)  (25downto23) (22downto20)   (19downto10) (9downto0)
	signal Enemy1 : STD_LOGIC_VECTOR (31 downto 0):= "00000011100000000000000011111000";
	signal Enemy2 : STD_LOGIC_VECTOR (31 downto 0):= "00000000000000000000000000001000";
	signal Enemy3 : STD_LOGIC_VECTOR (31 downto 0):= "00000000000000000000000000001000";
	signal Enemy4 : STD_LOGIC_VECTOR (31 downto 0):= "00000000000000000000000000001000";
	signal Enemy5 : STD_LOGIC_VECTOR (31 downto 0):= "00000000000000000000000000001000";
	signal Enemy6 : STD_LOGIC_VECTOR (31 downto 0):= "00000000000000000000000000001000";
	signal Enemy7 : STD_LOGIC_VECTOR (31 downto 0):= "00000000000000000000000000000111";
	signal Enemy8 : STD_LOGIC_VECTOR (31 downto 0):= "00000000000000000000000000001000";
	signal EnemyCount : STD_LOGIC_VECTOR (8 downto 0) := "000000000";

	
begin
	process(clk)
	
	variable dataTemp : std_logic_vector (31 downto 0) := "00000000000000000000000000000000";
	variable enemy_create_timer : integer := 0; 
	variable create_next : integer := 0;
	variable delay : integer := 0;
	
	begin

		if clk'event and clk = '1' then
			
			--setup random values
			threeBitRand1 <= sevenBitRand (6 downto 4);
			threeBitRand2 <= "00" & sevenBitRand2(3 downto 3);
			tenBitRand <= tenBitRand(8 downto 0) & (tenBitRand(9) xnor tenBitRand(0) xnor tenBitRand(1));
			tenBitRand2 <= tenBitRand2(8 downto 0) & (tenBitRand2(9) xnor tenBitRand2(0) xnor tenBitRand2(1));
			oneBitRand <= sevenBitRand (3 downto 3) xnor sevenBitRand2(3 downto 3);
			sevenBitRand <= sevenBitRand(5 downto 0) & (sevenBitRand(6) xnor sevenBitRand(0) xnor sevenBitRand(1));
			sevenBitRand2 <= sevenBitRand2(5 downto 0) & (sevenBitRand2(6) xnor sevenBitRand2(0) xnor sevenBitRand2(1));
			
			enemy_create_timer := enemy_create_timer + 1;
							
			if EnemyCount = "000000000" then
				dataTemp := Enemy1;
			elsif EnemyCount = "000000001" then
				dataTemp := Enemy2;
			elsif EnemyCount = "000000010" then
				dataTemp := Enemy3;
			elsif EnemyCount = "000000011" then
				dataTemp := Enemy4;
			elsif EnemyCount = "000000100" then
				dataTemp := Enemy5;
			elsif EnemyCount = "000000101" then
				dataTemp := Enemy6;
			elsif EnemyCount = "000000110" then
				dataTemp := Enemy7;
			elsif EnemyCount = "000000111" then
				dataTemp := Enemy8;
			end if;
		


			if dataTemp(31 downto 31) = "1" then	--this enemy is already exist, update it
				delay := delay + 1;
						
				if delay > 104200 then
					delay := 0;
					EnemyCount <= EnemyCount + "000000001";
					
					if dataTemp(26 downto 26) = "1" then 
						dataTemp := dataTemp(31 downto 20) & 
									(dataTemp(19 downto 10) - ("0000000" & dataTemp(25 downto 23)) ) &
									(dataTemp(9 downto 0) + ("0000000" & dataTemp(22 downto 20))  );
					else 
						dataTemp := dataTemp(31 downto 20) & 
								(dataTemp(19 downto 10) - ("0000000" & dataTemp(25 downto 23))) &
								(dataTemp(9 downto 0) - ("0000000" & dataTemp(22 downto 20)));
					end if;
				end if;
						
				--need to delete after gone out of the screen!
				if dataTemp(19 downto 10) = "0000000000"  then
					dataTemp := "00000000000000000000000000000000";
				end if;
					
				-- this enemy isn't exist, create it
			else
				--check limits of where enemy is created
				if threeBitRand1 < "01" or tenBitRand < "1001000100" 
					or tenBitRand2 > "0111100000" or tenBitRand2 < "0001100100"  
					or	threeBitRand1 > "110"then
					dataTemp := dataTemp;
					
				else
					if enemy_create_timer > 300  and create_next = 0 then 
						create_next := 1;
						dataTemp := "10000" & oneBitRand & threeBitRand1 & threeBitRand2 & "1011100100" & tenBitRand2; 
					elsif enemy_create_timer > 300 and create_next = 1 then 
						create_next := 2;
						dataTemp := "10000" & "1" & threeBitRand1 & threeBitRand2 & tenBitRand & "0000000000";
					elsif enemy_create_timer > 300 and create_next = 2 then 
						create_next := 0;
						enemy_create_timer := 0;
						dataTemp := "10000" & "0" & threeBitRand1 & threeBitRand2 & tenBitRand & "1001000100";
					end if;
				end if;
				
			end if;
			
			if EnemyCount = "000000000" then
				Enemy1 <= dataTemp;
				Enemy1out <= dataTemp;
			elsif EnemyCount = "000000001" then
				Enemy2 <= dataTemp;
				Enemy2out <= dataTemp;
			elsif EnemyCount = "000000010" then
				 Enemy3 <= dataTemp;
				 Enemy3out <= dataTemp;
			elsif EnemyCount = "000000011" then
				Enemy4 <= dataTemp;
				Enemy4out <= dataTemp;
			elsif EnemyCount = "000000100" then
				Enemy5 <= dataTemp;
				Enemy5out <= dataTemp;
			elsif EnemyCount = "000000101" then
				Enemy6 <= dataTemp;
				Enemy6out <= dataTemp;
			elsif EnemyCount = "000000110" then
				Enemy7 <=  dataTemp;
				Enemy7out <= dataTemp;
			elsif EnemyCount = "000000111" then
				Enemy8 <= dataTemp;
				Enemy8out <= dataTemp;
			elsif EnemyCount = "000001000" then
				EnemyCount <= "000000000";
			end if;
			
		if jellydie = '1' then
				Enemy1 <= "00000000000000000000000000000000";				
				Enemy1out  <= "00000000000000000000000000000000";	
				Enemy2 <= "00000000000000000000000000000000";	
				Enemy2out  <= "00000000000000000000000000000000";	
				Enemy3  <= "00000000000000000000000000000000";	
				Enemy3out  <= "00000000000000000000000000000000";	
				Enemy4 <= "00000000000000000000000000000000";	
				Enemy4out <= "00000000000000000000000000000000";	
				Enemy5 <= "00000000000000000000000000000000";	
				Enemy5out  <= "00000000000000000000000000000000";	
				Enemy6 <= "00000000000000000000000000000000";	
				Enemy6out  <= "00000000000000000000000000000000";	
				Enemy7out <= "00000000000000000000000000000000";	
				Enemy8  <= "00000000000000000000000000000000";	
				Enemy8out  <= "00000000000000000000000000000000";	
			end if;
		end if;
	
	end process;
	
	
end Behavioral;

