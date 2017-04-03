--CS179j
--Kyle Chen
library IEEE ;
use IEEE.STD_LOGIC_1164.all ;
use IEEE.STD_LOGIC_ARITH.all ;

entity TestBench is
end TestBench ;

architecture NSy of TestBench is

  constant ZERO_16 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0') ;

  component game is
    port(
		clk : in STD_LOGIC ;
		arrowU : in STD_LOGIC;
		arrowD : in STD_LOGIC;
		arrowL : in STD_LOGIC;
		arrowR : in STD_LOGIC;
		VGA_RED 		: out STD_LOGIC;
		VGA_GREEN	: out STD_LOGIC;
		VGA_BLUE		: out STD_LOGIC;
		
		VGA_HSYNC	: out STD_LOGIC;
		VGA_VSYNC	: out STD_LOGIC
        ) ;
  end component ;

  signal clk : STD_LOGIC := '0' ;
  signal VGA_RED 		: STD_LOGIC;
  signal VGA_GREEN	: STD_LOGIC;
  signal VGA_BLUE		: STD_LOGIC;	
  signal VGA_HSYNC	: STD_LOGIC;
	signal VGA_VSYNC	: STD_LOGIC;
	signal arr1 : std_logic := '0';
	signal arr2 : std_logic := '0';
	signal arr3 : std_logic := '0';
	signal arr4 : std_logic := '0';

begin

  TL : game port map (clk, arr1, arr2, arr3, arr4, VGA_RED, VGA_GREEN, VGA_BLUE, VGA_HSYNC, VGA_VSYNC) ;

  clk <= not clk after 1 ns ;
--  rst <= '0' after 20 ns ;

end NSy ;

configuration TB_CFG of TestBench is
  for NSy 
  end for ;
end TB_CFG ;

