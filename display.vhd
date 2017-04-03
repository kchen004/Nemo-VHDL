--CS179j
--Kyle Chen
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity Display is
	port (
		clk : in STD_LOGIC ;
		vdisplay : in STD_LOGIC;
		hdisplay : in STD_LOGIC;
	--	vertical : in STD_lOGIC_VECTOR (8 downto 0);
		horizontal : in STD_lOGIC_VECTOR (9 downto 0);
		
		input : in STD_LOGIC_VECTOR (3 downto 0);
		
		address : out STD_LOGIC_VECTOR(11 downto 0);
		VGA_RED 		: out STD_LOGIC;
		VGA_GREEN	: out STD_LOGIC;
		VGA_BLUE		: out STD_LOGIC
	);
end Display;

architecture Behavioral of Display is

	
begin
	--signal zeros : STD_LOGIC_VECTOR (1 downto 0);
	address <= "00" & horizontal(9 downto 0);
	
	process (clk)
	begin
		if clk'event and clk = '1' then
			if vdisplay = '1' and hdisplay = '1' then
				
				VGA_RED <= input(0);
				VGA_GREEN <= input(1);
				VGA_BLUE <= input (2);

			else
				VGA_RED <= '0';
				VGA_GREEN <= '0';
				VGA_BLUE <= '0';
			end if;
		
		end if;
		end process;
end Behavioral;


