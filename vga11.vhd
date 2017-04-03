--CS179j
--Kyle Chen

--output the vertical sync for VGA
--and indicate when to output and the position on the screen
--make sure clk is control by Hsync output
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity vga1 is
	port (
		clk : in STD_LOGIC ;
		Vcounter : out STD_lOGIC_VECTOR (8 downto 0);
		display		: out STD_LOGIC;
		VGA_VSYNC	: out STD_LOGIC
	);
end vga1;

architecture Behavioral of vga1 is

	type STATE is 
	(VpulseWidth, Vporch1, Vdisplay, Vporch2);
	
	
	signal Vstate : STATE := VpulseWidth;
	
	CONSTANT ONE 			: STD_lOGIC_VECTOR (8 downto 0) := "000000001";
	CONSTANT TWO 			: STD_lOGIC_VECTOR (8 downto 0) := "000000010";	
	CONSTANT TWENTYNINE : STD_lOGIC_VECTOR (8 downto 0) := "000011101";	
	CONSTANT TEN 			: STD_lOGIC_VECTOR (8 downto 0) := "000001010";	
	CONSTANT FOUREIGHTY : STD_lOGIC_VECTOR(8 downto 0) := "111100000";	
	signal Vclkcounter : STD_lOGIC_VECTOR (8 downto 0):= "000000001";
	
	
begin
	
	--Vclkcounter <= ONE;
	process(clk)
--	variable  integer := 1;

	begin

		if (clk'event and clk = '1') then
------------------- vertical sync----------------------
			case Vstate is
			
				when VpulseWidth =>
					VGA_VSYNC <= '0';
				display <= '0';
					if (Vclkcounter >= TWO ) then
						Vstate <= Vporch1;
						Vclkcounter <= ONE;
					else
						Vclkcounter <= Vclkcounter + ONE;
					end if;
		
				when Vporch1 =>
					VGA_VSYNC <= '1';
					display <= '0';
					if (Vclkcounter >= TWENTYNINE) then 
						Vstate <= Vdisplay;
						Vclkcounter <= ONE;
					else
						Vclkcounter <= Vclkcounter + ONE;
					end if;
				
				when Vdisplay =>
					VGA_VSYNC <= '1';
					display <= '1';
					if (Vclkcounter >= FOUREIGHTY) then
						Vstate <= Vporch2;
						Vclkcounter <= ONE;
					else
						Vclkcounter <= Vclkcounter + ONE;
					end if;
	
	
				when Vporch2 =>
					VGA_VSYNC <= '1';
					display <= '0';
					if (Vclkcounter >= TEN) then
						Vstate <= VpulseWidth;
						Vclkcounter <= ONE;
					else
						Vclkcounter <= Vclkcounter + ONE;
					end if;
				
				when others =>
					VGA_VSYNC <= '0';
					Vstate <= VpulseWidth;
					display <= '0';
				
			end case;
			Vcounter <= Vclkcounter;
			
------------------finish vertical sync----------------
		end if;
	end process;
end Behavioral;

