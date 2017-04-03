
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--use ieee.math_real.all; -- for UNIFORM, TRUNC
--use ieee.numeric_std.all; -- for TO_UNSIGNED


entity resource is
	port (
		clk 		: in  STD_LOGIC;
		rhit		: in std_logic_vector (2 downto 0);
	--	address : out STD_LOGIC_VECTOR (8 downto 0);
		r1out	: out STD_LOGIC_VECTOR (23 downto 0);
		r2out	: out STD_LOGIC_VECTOR (23 downto 0);
		r3out	: out STD_LOGIC_VECTOR (23 downto 0);
		r4out	: out STD_LOGIC_VECTOR (23 downto 0)
	

	--	writeEnable : out STD_LOGIC
	);
end resource;

architecture Behavioral of resource is

	signal create_timer1 : std_logic_vector(15 downto 0) := "1001010011100110"; 
	
	--signal waitTimer1 : integer := 0; 
	signal fourBitRand : std_logic_vector (3 downto 0) := "1001"; 
	signal nineBitRand : std_logic_vector (8 downto 0) := "100101100"; 
	signal nineBitRand2 : std_logic_vector (8 downto 0):= "001000100"; 
	signal oneBitRand : std_logic_vector (0 downto 0):= "1";

	--data contain the information about the resource
	-- exist or not   type		     timer 		   x pos       y pos
	--"(23downto23)  (22downto22)  (21downto18) (17downto9) (8downto0) 
	signal r1 : STD_LOGIC_VECTOR (23 downto 0):= "000000101000000111100000";
	signal r2 : STD_LOGIC_VECTOR (23 downto 0):= "000000101000000111100000";
	signal r3 : STD_LOGIC_VECTOR (23 downto 0):= "000000101000000111100000";
	signal r4 : STD_LOGIC_VECTOR (23 downto 0):= "000000101000000111100000";

begin
	process(clk)
	variable dataTemp : std_logic_vector (23 downto 0) := "000000000000000000000000";
	variable create_timer : integer := 0; 
	variable r_count : std_logic_vector (1 downto 0) := "00";
	variable delay : integer := 0;

	variable rcount : std_logic_vector (1 downto 0);
	
	begin

		if clk'event and clk = '1' then
			--setup random values
			nineBitRand <= nineBitRand(7 downto 0) & (nineBitRand(8) xnor nineBitRand(0) xnor nineBitRand(1));
			nineBitRand2 <= nineBitRand2(7 downto 0) & (nineBitRand2(8) xnor nineBitRand2(0) xnor nineBitRand2(1));
			oneBitRand <= nineBitRand (3 downto 3) xnor nineBitRand2(3 downto 3);
			fourBitRand <= fourBitRand(2 downto 0) & (fourBitRand(2) xnor fourBitRand(0) xnor fourBitRand(1));
			
			
		
		
			if delay > 12500000 then
				delay := 0;
				
				--assign which resource to update
				if r_count = "00" then
					dataTemp := r1;
				elsif r_count = "01" then
					dataTemp := r2;
				elsif r_count = "10" then
					dataTemp := r3;
				elsif r_count = "11" then
					dataTemp := r4;
				end if;
			
				--check if resource exist
				if dataTemp(23 downto 23) = "1" then
					--check timer, time up, reset the resource
					if dataTemp(21 downto 18) < "0001" then
						dataTemp := "000000000000000000000000";
					--time not up, count down
					else
						dataTemp := dataTemp(23 downto 22) & (dataTemp(21 downto 18) - "0001") &
						dataTemp(17 downto 0);
					end if;	
				
				--doesn't exist, create it
				else
					--check the time in between resource creation
					if create_timer > 5 then 
					--check limits, between where the resource is going to pop up...
					if nineBitRand > "101000000"  or nineBitRand2 > "111100000" or fourBitRand > "1010" then
						dataTemp := "000000000000000000000000";
					else
						dataTemp := "1" & oneBitRand & fourBitRand & (nineBitRand + "101000000") & nineBitRand2;
						create_timer := 0;
					end if;
				end if;
			end if;
			
			if r_count = "00" then
				r1 <= dataTemp;
				r1out <= dataTemp;
			elsif r_count = "01" then
				r2 <= dataTemp;
				r2out <= dataTemp;
			elsif r_count = "10" then
				r3 <= dataTemp;
				r3out <= dataTemp;
			elsif r_count = "11" then
				r4 <= dataTemp;
				r4out <= dataTemp;
			end if;
			
			r_count := r_count + "01";
			create_timer := create_timer + 1;
			end if;
			
			delay := delay + 1;
		

			--collision 
			if rhit = "000" then
				r1 <= "000000000000000000000000";
				r1out <= "000000000000000000000000";
			elsif rhit = "001" then
				r2 <= "000000000000000000000000";
				r2out <= "000000000000000000000000";
			elsif rhit = "010" then
				r3 <= "000000000000000000000000";
				r3out <= "000000000000000000000000";
			elsif rhit = "011" then
				r4 <= "000000000000000000000000";	
				r4out <= "000000000000000000000000";				
			end if;
			end if;
			--r1out <= "101111100101100100001100";
--		end if;
	end process;
	
	
end Behavioral;

