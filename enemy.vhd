
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--use ieee.math_real.all; -- for UNIFORM, TRUNC
--use ieee.numeric_std.all; -- for TO_UNSIGNED


entity enemy is
	port (
		clk 		: in  STD_LOGIC;
		indata	: in STD_LOGIC_VECTOR (31 downto 0);
		address : out STD_LOGIC_VECTOR (8 downto 0);
		outdata	: out STD_LOGIC_VECTOR (31 downto 0);
		writeEnable : out STD_LOGIC
	);
end enemy;

architecture Behavioral of enemy is
	type STATE is 
	(reset_address, enemy_update, address_update, waitstate, waitstate2);
	
	signal e_state : STATE := reset_address;
	signal dataTemp : std_logic_vector (31 downto 0) := "00000000000000000000000000000000";
	signal addrTemp : std_logic_vector (8 downto 0) := "000000000";
	signal enemy_create_timer1 : integer := 0; 
	
	signal waitTimer1 : integer := 0;
	signal threeBitRand1 : std_logic_vector (2 downto 0) := "001";
	signal threeBitRand2 : std_logic_vector (2 downto 0) := "001";
	signal tenBitRand : std_logic_vector (9 downto 0) := "0100101100";
	signal nineBitRand : std_logic_vector (8 downto 0):= "010100010";
	signal oneBitRand : std_logic_vector (0 downto 0):= "1";
	
begin
	process(clk)
		variable enemy_create_timer : integer := 0; 

	variable waitTimer : integer := 0;
	variable delay : integer := 0;
	variable create_count : integer := 0;
	
	begin
	

		if clk'event and clk = '1' then

			waitTimer := waitTimer + 1;
			enemy_create_timer := enemy_create_timer + 1;
		
	
			
			case e_state is
				when reset_address =>
				
					addrTemp <= "000000000";
	
					--put a if statement to wait to access memory
					if waitTimer > 416800 then
						e_state <= enemy_update;
						waitTimer := 0;
						
					end if;
						
				--data contain the information about the enemy
				-- exist or not  			y direction   x speed 		y speed   		 x pos      y pos
				--"(31downto31)	00000 (25downto25)  (24downto22) (21downto19)   (18downto9) (8downto0)
				when enemy_update =>
					if indata(31 downto 31) = "1" then	--this enemy is already exist, update it
						delay := delay + 1;
						
						if delay > 5 then
							delay := 0;
						if indata(25 downto 25) = "1" then 
							dataTemp <= indata(31 downto 19) & 
							("0000000" & indata(24 downto 22) + indata(18 downto 9)) &
							(("000000" & indata(21 downto 19)) + indata(8 downto 0));
						else 
							dataTemp <= indata(31 downto 19) & 
							("0000000" & indata(24 downto 22) + indata(18 downto 9)) &
							(indata(8 downto 0) - ("000000" & indata(21 downto 19)));
						end if;
						end if;
						
						--need to delete after gone out of the screen!
						if indata(18 downto 9) > "1010000000" or indata(8 downto 0) > "111100000" then
								dataTemp <= "00000000000000000000000000000000";
						end if;
					
					-- this enemy isn't exist, create it
					else
						if enemy_create_timer > 300 and create_count = 0 then 
							create_count := create_count + 1;
							dataTemp <= "100000" & oneBitRand & threeBitRand1 & threeBitRand2 & "0000000000" & nineBitRand; 
						elsif enemy_create_timer > 300 and create_count = 1 then 
							create_count := create_count + 1;
							dataTemp <= "100000" & oneBitRand & threeBitRand1 & threeBitRand2 & tenBitRand & "000000000";
						elsif enemy_create_timer > 300 and create_count = 2 then 
							enemy_create_timer := 0;
							create_count := 0;
							dataTemp <= "100000" & oneBitRand & threeBitRand1 & threeBitRand2 & tenBitRand & "111100000";
						end if;
					
					end if;
					
					
					writeEnable <= '1';
					e_state <= address_update;

			
				when address_update =>
					outdata <= dataTemp;
					addrTemp <= addrTemp + "000000001";
					writeEnable <= '0';
					e_state <= waitstate;
				when waitstate =>
						e_state <= waitstate2;
				when waitstate2 =>
					if addrTemp > "000000111" then  --only have 8 enemy at max
						e_state <= reset_address;
					else
						e_state <= enemy_update;
					end if;
					
				when others =>
					e_state <= reset_address;
				end case;
				
					 enemy_create_timer1 <= enemy_create_timer;   
				waitTimer1 <= waitTimer;
				address <= addrTemp;
		end if;
	end process;
	
end Behavioral;

