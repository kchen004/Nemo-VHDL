
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity update is
	Port (
		clk : in STD_LOGIC;
		hpos : in STD_LOGIC_VECTOR(9 downto 0); --when will horizontal refresh
		vpos : in STD_LOGIC_VECTOR (8 downto 0);
		MainGuyXpos : in STD_LOGIC_VECTOR (9 downto 0);
		MainGuyYpos : in STD_LOGIC_VECTOR (8 downto 0);
		Enemy1 : in STD_LOGIC_VECTOR (31 downto 0);
		Enemy2 : in STD_LOGIC_VECTOR (31 downto 0);
		Enemy3 : in STD_LOGIC_VECTOR (31 downto 0);
		Enemy4 : in STD_LOGIC_VECTOR (31 downto 0);
		Enemy5 : in STD_LOGIC_VECTOR (31 downto 0);
		Enemy6 : in STD_LOGIC_VECTOR (31 downto 0);
		Enemy7 : in STD_LOGIC_VECTOR (31 downto 0);
		Enemy8 : in STD_LOGIC_VECTOR (31 downto 0);
		r1		 : in std_logic_vector (23 downto 0);
		r2		 : in std_logic_vector (23 downto 0);
		r3		 : in std_logic_vector (23 downto 0);
		r4		 : in std_logic_vector (23 downto 0);
		rhit	: out std_logic_vector (2 downto 0);
		Ram1data : in STD_LOGIC_VECTOR (3 downto 0);
		Ram1address : out STD_LOGIC_VECTOR (11 downto 0);
		Ram2data : in STD_LOGIC_VECTOR (3 downto 0);
		Ram2address : out STD_LOGIC_VECTOR (11 downto 0);
		jellydie : out std_logic;
		data : out STD_LOGIC_VECTOR (3 downto 0);
		address : out STD_LOGIC_VECTOR (11 downto 0)
		
	

	);
end update;

architecture Behavioral of update is

	--signal main_guy : STD_LOGIC_VECTOR
	CONSTANT tenbit64 : STD_LOGIC_VECTOR (9 downto 0) := "0001000000";
	CONSTANT ninebit38 : STD_LOGIC_VECTOR (8 downto 0) := "000100110";
	CONSTANT tenbit150 : STD_LOGIC_VECTOR (9 downto 0) 	:= "0010010110";
	CONSTANT tenbit100: STD_LOGIC_VECTOR (9 downto 0) := "0001100100";
	CONSTANT tenbit200 : STD_LOGIC_VECTOR (9 downto 0) := "0011001000";
	CONSTANT tenbit20: STD_LOGIC_VECTOR (9 downto 0) := "0000010100";
	CONSTANT ninebit20 : STD_LOGIC_VECTOR (8 downto 0) := "000010100";
	--signal EnemyCount: STD_LOGIC_VECTOR (8 downto 0):= "000000000";
	
	
--

begin

	
	process (clk)
		variable collision_delay : integer := 0;
		variable life				 : std_logic_vector (7 downto 0) := "01100100";
		variable drawCount		: std_logic_vector (11 downto 0) := "000000000000";
	begin
	
		if clk'event and clk = '1' then
			data <= "0100";
			rhit <= "100";
			jellydie <= '0';
			address <= "00" & hpos(9 downto 0);
			
			--if life = "00000000" then
			--	data<= "0001";
			--else
			
			
-------------------------------------draw all enemy----------------------------------------------
			if Enemy1 (31 downto 31) = "1" and Enemy1(19 downto 10) < (hpos + tenbit100)
				and (hpos + tenbit100) < (Enemy1(19 downto 10) + tenbit150) 	
				and Enemy1(9 downto 0) < (("0" & vpos) + tenbit100)
				and (("0" & vpos) + tenbit100) < (Enemy1(9 downto 0) + tenbit200) then
				data <= "0" & "000";
			end if;
			
			if Enemy2 (31 downto 31) = "1" and Enemy2(19 downto 10) < (hpos + tenbit100)
				and (hpos + tenbit100) < (Enemy2(19 downto 10) + tenbit150) 	
				and Enemy2(9 downto 0) < (("0" & vpos) + tenbit100)
				and (("0" & vpos) + tenbit100) < (Enemy2(9 downto 0) + tenbit200) then
				data <= "0" & "001";
			end if;
			
			if Enemy3 (31 downto 31) = "1" and Enemy3(19 downto 10) < (hpos + tenbit100)
				and (hpos + tenbit100) < (Enemy3(19 downto 10) + tenbit150) 	
				and Enemy3(9 downto 0) < (("0" & vpos) + tenbit100)
				and (("0" & vpos) + tenbit100) < (Enemy3(9 downto 0) + tenbit200) then
				data <= "0" & "010";
			end if;
			
			if Enemy4 (31 downto 31) = "1" and Enemy4(19 downto 10) < (hpos + tenbit100)
				and (hpos + tenbit100) < (Enemy4(19 downto 10) + tenbit150) 	
				and Enemy4(9 downto 0) < (("0" & vpos) + tenbit100)
				and (("0" & vpos) + tenbit100) < (Enemy4(9 downto 0) + tenbit200) then
				data <= "0" & "011";
			end if;
			
			if Enemy5 (31 downto 31) = "1" and Enemy5(19 downto 10) < (hpos + tenbit100)
				and (hpos + tenbit100) < (Enemy5(19 downto 10) + tenbit150) 	
				and Enemy5(9 downto 0) < (("0" & vpos) + tenbit100)
				and (("0" & vpos) + tenbit100) < (Enemy5(9 downto 0) + tenbit200) then
				data <= "0" & "100";
			end if;
			
			if Enemy6 (31 downto 31) = "1" and Enemy6(19 downto 10) < (hpos + tenbit100)
				and (hpos + tenbit100) < (Enemy6(19 downto 10) + tenbit150) 	
				and Enemy6(9 downto 0) < (("0" & vpos) + tenbit100)
				and (("0" & vpos) + tenbit100) < (Enemy6(9 downto 0) + tenbit200) then
				data <= "0" & "101";
			end if;
			
			if Enemy7 (31 downto 31) = "1" and Enemy7(19 downto 10) < (hpos + tenbit100)
				and (hpos + tenbit100) < (Enemy7(19 downto 10) + tenbit150) 	
				and Enemy7(9 downto 0) < (("0" & vpos) + tenbit100)
				and (("0" & vpos) + tenbit100) < (Enemy7(9 downto 0) + tenbit200) then
				data <= "0" & "110";
			end if;
			
			if Enemy8 (31 downto 31) = "1" and Enemy8(19 downto 10) < (hpos + tenbit100)
				and (hpos + tenbit100) < (Enemy8(19 downto 10) + tenbit150) 	
				and Enemy8(9 downto 0) < (("0" & vpos) + tenbit100)
				and (("0" & vpos) + tenbit100) < (Enemy8(9 downto 0) + tenbit200) then				
				data <= "0" & "111";
			end if;
			
			
--------------------------------------draw rescources----------------------------------------
			if (r1 (23 downto 23) = "1" and ("0" & r1(17 downto 9)) < hpos
				and hpos < (("0" & r1(17 downto 9)) + tenbit20)	
				and r1(8 downto 0) < vpos and vpos < (r1(8 downto 0) + ninebit20)) then
				if r1(22) = '1' then 
					--heart
					Ram1address <= "100110000000" + (hpos - ("0" & r1(17 downto 9))) 
										+ ( "0000010100"* ("0" & (vpos - r1(8 downto 0))));
					if Ram1data(3) = '0' then
						data <= Ram1data;
					end if;
				else
					--!
					Ram1address <= "101101000000" + (hpos - ("0" & r1(17 downto 9))) 
										+ ( "0000010100"* ("0" & (vpos - r1(8 downto 0))));
					if Ram1data(3) = '0' then
						data <= Ram1data;
					end if;
				end if;
		

				
			elsif	(r2 (23 downto 23) = "1" and ("0" & r2(17 downto 9)) < hpos
				and hpos < (("0" & r2(17 downto 9)) + tenbit20)	
				and r2(8 downto 0) < vpos and vpos < (r2(8 downto 0) + ninebit20)) then
				if r2(22) = '1' then
					--heart
					Ram1address <= "110100000010" + (hpos - ("0" & r2(17 downto 9))) 
										+ ( "0000010100"* ("0" & (vpos - r2(8 downto 0))));
					if Ram1data(3) = '0' then
						data <= Ram1data;
					end if;
				else
					--!
					Ram1address <= "101101000000" + (hpos - ("0" & r2(17 downto 9))) 
										+ ( "0000010100"* ("0" & (vpos - r2(8 downto 0))));
					if Ram1data(3) = '0' then
						data <= Ram1data;
					end if;
				end if;	
				
			elsif (r3 (23 downto 23) = "1" and ("0" & r3(17 downto 9)) < hpos
				and hpos < (("0" & r3(17 downto 9)) + tenbit20)	
				and r3(8 downto 0) < vpos and vpos < (r3(8 downto 0) + ninebit20)) then
				if r3(22) = '1' then
					--heart
					Ram1address <= "110100000010" + (hpos - ("0" & r3(17 downto 9))) 
									+ ( "0000010100"* ("0" & (vpos - r3(8 downto 0))));
					if Ram1data(3) = '0' then
						data <= Ram1data;
					end if;
				else
					--!
					Ram1address <= "101101000000" + (hpos - ("0" & r3(17 downto 9))) 
										+ ( "0000010100"* ("0" & (vpos - r3(8 downto 0))));
					if Ram1data(3) = '0' then
						data <= Ram1data;
					end if;	
				end if;
				
			elsif (r4 (23 downto 23) = "1" and ("0" & r4(17 downto 9)) < hpos
				and hpos < (("0" & r4(17 downto 9)) + tenbit20)	
				and r4(8 downto 0) < vpos and vpos < (r4(8 downto 0) + ninebit20)) then	
				if r4(22) = '1' then
					--heart
					Ram1address <= "100110000000" + (hpos - ("0" & r4(17 downto 9))) 
									+ ( "0000010100"* ("0" & (vpos - r4(8 downto 0))));
					if Ram1data(3) = '0' then
						data <= Ram1data;
					end if;
				else
					--!
					Ram1address <= "101101000000" + (hpos - ("0" & r4(17 downto 9))) 
										+ ( "0000010100"* ("0" & (vpos - r4(8 downto 0))));
					if Ram1data(3) = '0' then
						data <= Ram1data;
					end if;
				end if;
				
			end if;
			
------------------------------------------draw marlin-------------------------------------------
			address <= "00" & hpos(9 downto 0);
			if MainGuyXpos < hpos     and hpos < MainGuyXpos + tenbit64
				and MainGuyYpos < vpos and vpos < MainGuyYpos + ninebit38 then
					Ram1address <= (hpos - MainGuyXpos) 
									+ ( "0001000000"* ("0" & (vpos - MainGuyYpos)));
					
					if Ram1data(3) = '0' then
						data <= Ram1data;
					end if;
						
				if collision_delay > 416800 then
				
					--check collision with enemy
					if (Enemy1 (31 downto 31) = "1" and Enemy1(19 downto 10) < (hpos + tenbit100)
						and (hpos + tenbit100) < (Enemy1(19 downto 10) + tenbit150) 	
						and Enemy1(9 downto 0) < (("0" & vpos) + tenbit100)
						and (("0" & vpos) + tenbit100) < (Enemy1(9 downto 0) + tenbit200) )or 
						( Enemy2 (31 downto 31) = "1" and Enemy2(19 downto 10) < (hpos + tenbit100)
						and (hpos + tenbit100) < (Enemy2(19 downto 10) + tenbit150) 	
						and Enemy2(9 downto 0) < (("0" & vpos) + tenbit100)
						and (("0" & vpos) + tenbit100) < (Enemy2(9 downto 0) + tenbit200)) or
						(Enemy3 (31 downto 31) = "1" and Enemy3(19 downto 10) < (hpos + tenbit100)
						and (hpos + tenbit100) < (Enemy3(19 downto 10) + tenbit150) 	
						and Enemy3(9 downto 0) < (("0" & vpos) + tenbit100)
						and (("0" & vpos) + tenbit100) < (Enemy3(9 downto 0) + tenbit200)) or 
						(Enemy4 (31 downto 31) = "1" and Enemy4(19 downto 10) < (hpos + tenbit100)
						and (hpos + tenbit100) < (Enemy4(19 downto 10) + tenbit150) 	
						and Enemy4(9 downto 0) < (("0" & vpos) + tenbit100)
						and (("0" & vpos) + tenbit100) < (Enemy4(9 downto 0) + tenbit200)) or 
						(Enemy5 (31 downto 31) = "1" and Enemy5(19 downto 10) < (hpos + tenbit100)
						and (hpos + tenbit100) < (Enemy5(19 downto 10) + tenbit150) 	
						and Enemy5(9 downto 0) < (("0" & vpos) + tenbit100)
						and (("0" & vpos) + tenbit100) < (Enemy5(9 downto 0) + tenbit200)) or
						(Enemy6 (31 downto 31) = "1" and Enemy6(19 downto 10) < (hpos + tenbit100)
						and (hpos + tenbit100) < (Enemy6(19 downto 10) + tenbit150) 	
						and Enemy6(9 downto 0) < (("0" & vpos) + tenbit100)
						and (("0" & vpos) + tenbit100) < (Enemy6(9 downto 0) + tenbit200)) or
						(Enemy7 (31 downto 31) = "1" and Enemy7(19 downto 10) < (hpos + tenbit100)
						and (hpos + tenbit100) < (Enemy7(19 downto 10) + tenbit150) 	
						and Enemy7(9 downto 0) < (("0" & vpos) + tenbit100)
						and (("0" & vpos) + tenbit100) < (Enemy7(9 downto 0) + tenbit200)) or
						(Enemy8 (31 downto 31) = "1" and Enemy8(19 downto 10) < (hpos + tenbit100)
						and (hpos + tenbit100) < (Enemy8(19 downto 10) + tenbit150) 	
						and Enemy8(9 downto 0) < (("0" & vpos) + tenbit100)
						and (("0" & vpos) + tenbit100) < (Enemy8(9 downto 0) + tenbit200)) then
							life := life - "00000001";
					end if;
		
					--check collision with rescources
					if (r1 (23 downto 23) = "1" and ("0" & r1(17 downto 9)) < hpos
						and hpos < (("0" & r1(17 downto 9)) + tenbit20)	
						and r1(8 downto 0) < vpos and vpos < (r1(8 downto 0) + ninebit20)) then
						if r1(22) = '1' then
							life := life + "00001010"; --heart
						else
							jellydie <= '1';
						end if;
						rhit <= "000";
					elsif	(r2 (23 downto 23) = "1" and ("0" & r2(17 downto 9)) < hpos
						and hpos < (("0" & r2(17 downto 9)) + tenbit20)	
						and r2(8 downto 0) < vpos and vpos < (r2(8 downto 0) + ninebit20)) then
						if r2(22) = '1' then
							life := life + "00001010"; --heart
						else
							jellydie <= '1';
						end if;
						rhit <= "001";
					elsif (r3 (23 downto 23) = "1" and ("0" & r3(17 downto 9)) < hpos
						and hpos < (("0" & r3(17 downto 9)) + tenbit20)	
						and r3(8 downto 0) < vpos and vpos < (r3(8 downto 0) + ninebit20)) then
						if r3(22) = '1' then
							life := life + "00001010"; --heart
						else
							jellydie <= '1';
						end if;
						rhit <= "010";
					elsif (r4 (23 downto 23) = "1" and ("0" & r4(17 downto 9)) < hpos
						and hpos < (("0" & r4(17 downto 9)) + tenbit20)	
						and r4(8 downto 0) < vpos and vpos < (r4(8 downto 0) + ninebit20)) then	
						if r4(22) = '1' then
							life := life + "00001010"; --heart
						else
							jellydie <= '1';
						end if;
						rhit <= "011";
					
					end if;
				end if;
			end if;
				
			collision_delay := collision_delay + 1;
		end if;
	--end if;	

	end process;
end Behavioral;

