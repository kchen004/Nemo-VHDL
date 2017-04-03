library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity main_guy is
	port (
		clk : in STD_LOGIC ;

		arrowUp : in STD_LOGIC;
		arrowDown : in STD_LOGIC;
		arrowLeft : in STD_LOGIC;
		arrowRight : in STD_LOGIC;
		
		xpos : out STD_LOGIC_VECTOR (9 downto 0);
		ypos : out STD_LOGIC_VECTOR (8 downto 0)
	
		
	);
end main_guy;

architecture Behavioral of main_guy is

	signal v : STD_lOGIC_VECTOR (8 downto 0) := "100101100";
	signal h : STD_lOGIC_VECTOR (9 downto 0) := "0100101100";

	
begin
	process (clk)
	variable counter : integer := 0;
	begin
		if clk'event and clk = '1' then
			counter := counter + 1;
			if counter > 416800 then
				counter := 0;
				if arrowUp = '1' and v > "000000001" then
					v <= v - "000000001";
				end if;
				
				if arrowDown = '1' and v < "110111000" then --440
					v <= v + "000000001";
				end if;
				
				if arrowLeft = '1' and h > "0000000001" then
					h <= h - "0000000001";
				end if;
				
				if arrowRight = '1' and h < "1001011000" then --600
					h <= h + "0000000001";
				end if;
				
			end if;
		end if;
		xpos <= h;
		ypos <= v;
	end process;
	
end Behavioral;




