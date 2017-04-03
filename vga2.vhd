--CS179j
--Kyle Chen
--output the horizontal sync for VGA
--and indicate when to output and the position on the screen
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity vga2 is
	port (
		clk : in STD_LOGIC ;
		Hcounter : out STD_lOGIC_VECTOR (9 downto 0);
		display		: out STD_LOGIC;
		VGA_HSYNC	: out STD_LOGIC
	);
end vga2;

architecture Behavioral of vga2 is

	type STATE is 
	(HpulseWidth, Hporch1, Hdisplay, Hporch2);
	
	signal Hstate : STATE := HpulseWidth;
	
	CONSTANT ONE 			: STD_lOGIC_VECTOR (9 downto 0) := "0000000001";
	CONSTANT FORTYEIGHT	: STD_lOGIC_VECTOR (9 downto 0) := "0000110000";	
	CONSTANT SIXTEEN	   : STD_lOGIC_VECTOR (9 downto 0) := "0000010000";	
	CONSTANT NINTYSIX	: STD_lOGIC_VECTOR (9 downto 0) := "0001100000";	
	CONSTANT SIXFORTY	: STD_lOGIC_VECTOR (9 downto 0) := "1010000000";	
	signal Hclkcounter : STD_lOGIC_VECTOR (9 downto 0) := "0000000001";
	
	
begin

	process(clk)

	

	begin
	--if (clk'event and clk = '0') then

	--end if;
	if (clk'event and clk = '1') then

			-----------------horizontal sync---------------
					case Hstate is
						
						when HpulseWidth =>
						
							display <= '0';
							VGA_HSYNC <= '0';	
							if (Hclkcounter >= NINTYSIX) then
								Hstate <= Hporch1;
								Hclkcounter <= ONE;
							else
								Hclkcounter <= Hclkcounter + ONE;
							end if;
			
						when Hporch1 =>
						
							display <= '0';
							VGA_HSYNC <= '1';
							if (Hclkcounter >= FORTYEIGHT) then
								Hstate <= Hdisplay;
								Hclkcounter <= ONE;
							else
								Hclkcounter <= Hclkcounter + ONE;
							end if;
		
---------------- display the image ---------------		
						when Hdisplay =>
							VGA_HSYNC <= '1';	
							display <= '1';
						
							if (Hclkcounter >= SIXFORTY) then
								Hstate <= Hporch2;
								Hclkcounter <= ONE;
							else
								Hclkcounter <= Hclkcounter + ONE;
							end if;
--------------------------------------------------			
						when Hporch2 =>
							VGA_HSYNC <= '1';

							display <= '0';
							if Hclkcounter >= SIXTEEN then
								Hstate <= HpulseWidth;
								Hclkcounter <= ONE;
							else
								Hclkcounter <= Hclkcounter + ONE;
							end if;

						when others =>
							VGA_HSYNC <= '0';
							Hstate <= HpulseWidth;
							display <= '0';
					
					end case;
					
					Hcounter <= Hclkcounter;

			-----------finish horizontal sync----------
	 	end if;
	end process;

end Behavioral;

