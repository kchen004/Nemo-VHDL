----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:22:38 02/01/2007 
-- Design Name: 
-- Module Name:    vga - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity vga is
	port (
		clk : in STD_LOGIC ;
		rst : in STD_LOGIC;
		
		VGA_RED 		: out STD_LOGIC;
		VGA_GREEN	: out STD_LOGIC;
		VGA_BLUE		: out STD_LOGIC;
		
		VGA_HSYNC	: out STD_LOGIC;
		VGA_VSYNC	: out STD_LOGIC
	);
end vga;

architecture Behavioral of vga is

	type STATE is 
	(HpulseWidth, Hporch1, Hdisplay, Hporch2,
	 VpulseWidth, Vporch1, Vdisplay, Vporch2);
	
	signal Hstate : STATE := HpulseWidth;
	signal Vstate : STATE := VpulseWidth;
	--Hstate <= HpulseWidth;
	--Vstate <= VpulseWidth;
	
	
begin

	process(clk, rst)
	variable Hclkcounter : integer := 1;
	variable Vclkcounter : integer := 1;

	begin
		if (rst = '1') then
			Vclkcounter := 0;
			Hclkcounter := 0;
			VGA_RED <= '1';
			VGA_GREEN <= '1';
			VGA_BLUE <= '1';
			Vstate <= VpulseWidth;
			Hstate <= HpulseWidth;
			
		elsif (clk'event and clk = '1') then
------------------- vertical sync----------------------
			case Vstate is
			
				when VpulseWidth =>
					VGA_VSYNC <= '0';
					VGA_HSYNC <= '0';
				
					if (Vclkcounter >= 1600 ) then
						Vstate <= Vporch1;
						Vclkcounter := 0;
					end if;
		
				when Vporch1 =>
					VGA_VSYNC <= '1';
					VGA_HSYNC <= '0';
					if (Vclkcounter >= 23200) then
						Vstate <= Vdisplay;
						Vclkcounter := 0;
					
					end if;
				
				when Vdisplay =>
					VGA_VSYNC <= '1';
					if (Vclkcounter >= 384000) then
						Vstate <= Vporch2;
						Vclkcounter := 0;
					end if;
				
			-----------------horizontal sync---------------
					case Hstate is
						
						when HpulseWidth =>
							VGA_HSYNC <= '0';	
							if (Hclkcounter >= 96) then
								Hstate <= Hporch1;
								Hclkcounter := 0;
							end if;
			
						when Hporch1 =>
							VGA_HSYNC <= '1';
							if (Hclkcounter >= 48) then
								Hstate <= Hdisplay;
								Hclkcounter := 0;
							end if;
		
---------------- display the image ---------------		
						when Hdisplay =>
							VGA_HSYNC <= '1';	
							if (Hclkcounter > 300) then
							VGA_RED <= '0';
							VGA_GREEN <= '1';
							VGA_BLUE <= '0';	
							else
								VGA_RED <= '1';
								VGA_GREEN <= '1';
								VGA_BLUE <= '0';	
							end if;
						
							if (Hclkcounter >= 640) then
								Hstate <= Hporch2;
								Hclkcounter := 0;
							end if;
--------------------------------------------------			
						when Hporch2 =>
							VGA_HSYNC <= '1';
							if (Hclkcounter >= 16) then
								Hstate <= HpulseWidth;
								Hclkcounter := 0;
							end if;

						when others =>
							VGA_HSYNC <= '0';
					
					end case;
		
					Hclkcounter := Hclkcounter + 1;
			-----------finish horizontal sync----------
	
				when Vporch2 =>
					VGA_VSYNC <= '1';
					VGA_HSYNC <= '0';
					if (Vclkcounter >= 8000) then
						Vstate <= VpulseWidth;
						Vclkcounter := 0;
					end if;
				
				when others =>
					VGA_VSYNC <= '0';
					VGA_HSYNC <= '0';
					VGA_RED <= '0';
					VGA_GREEN <= '0';
					VGA_BLUE <= '0';	
					Vstate <= VpulseWidth;
					Hstate <= HpulseWidth;
				
			end case;
		
			Vclkcounter := Vclkcounter + 1;
------------------finish vertical sync----------------
		end if;
	end process;
end Behavioral;

