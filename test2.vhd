--CS179j
--Kyle Chen
library IEEE ;
use IEEE.STD_LOGIC_1164.all ;
use IEEE.STD_LOGIC_ARITH.all ;

entity TestBench is
end TestBench ;

architecture NSy2 of TestBench is

  constant ZERO_16 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0') ;
  
  component vga2 is
	port(
		clk : in STD_LOGIC ;
		Hcounter : out UNSIGNED (9 downto 0);
		display		: out STD_LOGIC;
		VGA_HSYNC	: out STD_LOGIC
		);
  end component ;


  signal clk : STD_LOGIC := '0' ;
signal		Hcounter :  UNSIGNED (9 downto 0);
 signal rst : STD_LOGIC := '1' ;
 
		
   signal VGA_HSYNC	: STD_LOGIC;


begin

  TL : vga2 port map (clk, Hcounter, rst, VGA_HSYNC) ;

  clk <= not clk after 10 ns ;
  rst <= '0' after 20 ns ;

end NSy2 ;

configuration TB_CFG2 of TestBench is
  for NSy2 
  end for ;
end TB_CFG2 ;

