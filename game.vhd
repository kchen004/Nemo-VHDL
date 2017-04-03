--CS179j
--Kyle Chen
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity game is
	port (
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
	);
end game;

architecture Behavioral of game is

  component vga1 is
	port(
		clk 			: in STD_LOGIC ;
		Vcounter 	: out STD_lOGIC_VECTOR (8 downto 0);
		display		: out STD_LOGIC;
		VGA_VSYNC	: out STD_LOGIC
		);
  end component ;

  component vga2 is
	port(
		clk 			: in STD_LOGIC ;
		Hcounter 	: out STD_lOGIC_VECTOR (9 downto 0);
		display		: out STD_LOGIC;
		VGA_HSYNC	: out STD_LOGIC
		);
  end component ;
  
  component clock_divider is
	port(
       clk 			: in STD_LOGIC;
       out_clk 	: out STD_LOGIC
		 );
	end component;

   component Display is
	port (
		clk 			: in STD_LOGIC ;
		vdisplay 	: in STD_LOGIC;
		hdisplay 	: in STD_LOGIC;
		--vertical	: in STD_lOGIC_VECTOR (8 downto 0);
		horizontal 	: in STD_lOGIC_VECTOR (9 downto 0);
		
		input 		: in STD_LOGIC_VECTOR (3 downto 0);
		
		address 		: out STD_LOGIC_VECTOR(11 downto 0);
		VGA_RED 		: out STD_LOGIC;
		VGA_GREEN	: out STD_LOGIC;
		VGA_BLUE		: out STD_LOGIC
	);
	end component;

	component screen is
	port (
		clock 		: in  	std_logic;
	--	reset 		: in  	std_logic;
		update_address 	: in 		std_logic_vector(11 downto 0);
		display_address 	: in 		std_logic_vector(11 downto 0);
		update_data : in  	std_logic_vector(3 downto 0);
		display_data : out  	std_logic_vector(3 downto 0)
		
	);
	end component;
	
	component update is
	port (
		clk 			: in STD_LOGIC;
		hpos 			: in STD_LOGIC_VECTOR(9 downto 0); --when will horizontal refresh
		vpos 			: in STD_LOGIC_VECTOR (8 downto 0);
		MainGuyXpos : in STD_LOGIC_VECTOR (9 downto 0);
		MainGuyYpos : in STD_LOGIC_VECTOR (8 downto 0);
		EnemyRam_data : in STD_LOGIC_VECTOR (31 downto 0);
		EnemyRam_addr : out STD_LOGIC_VECTOR (8 downto 0);
		address 		: out STD_LOGIC_VECTOR (11 downto 0);
		data 		: out STD_LOGIC_VECTOR (3 downto 0)

	);
	end component;
	
	component main_guy is
	port (
		clk : in STD_LOGIC ;

		arrowUp : in STD_LOGIC;
		arrowDown : in STD_LOGIC;
		arrowLeft : in STD_LOGIC;
		arrowRight : in STD_LOGIC;
		
		xpos : out STD_LOGIC_VECTOR (9 downto 0);
		ypos : out STD_LOGIC_VECTOR (8 downto 0)
		
	);
	end component;
	
	component enemy is
	port (
		clk 		: in  STD_LOGIC;
		indata	: in STD_LOGIC_VECTOR (31 downto 0);
		address : out STD_LOGIC_VECTOR (8 downto 0);
		outdata	: out STD_LOGIC_VECTOR (31 downto 0);
		writeEnable : out STD_LOGIC
	);
	end component;
	
	component enemy_ram is
   port ( 
				clk 	: in  	std_logic;

				portA_address 	: in 		std_logic_vector(8 downto 0);
				portA_dataIn  	: in  	std_logic_vector(31 downto 0);
				portA_dataOut  : out  	std_logic_vector(31 downto 0);
				portA_write		: in		std_logic;
				
				portB_address 	: in 		std_logic_vector(8 downto 0);
				portB_data  	: out  	std_logic_vector(31 downto 0)
		
	);
	end component;
	
	
	signal clocklink 	: STD_LOGIC;
	signal VGA_H 		: STD_LOGIC;
	signal vdisplay 	: STD_LOGIC;
	signal hdisplay 	: STD_LOGIC;
	signal hcounter 	: STD_lOGIC_VECTOR (9 downto 0);
	signal vcounter 	: STD_lOGIC_VECTOR (8 downto 0);
	signal update_address : STD_LOGIC_VECTOR ( 11 downto 0);
	signal update_data : STD_LOGIC_VECTOR (3 downto 0);
	signal display_address : STD_LOGIC_VECTOR ( 11 downto 0);
	signal display_data : STD_LOGIC_VECTOR (3 downto 0);
	signal MainGuyXpos  : STD_LOGIC_VECTOR (9 downto 0);
	signal MainGuyYpos  : STD_LOGIC_VECTOR (8 downto 0);
	signal Enemy_A_addr : std_logic_vector (8 downto 0);
	signal Enemy_A_dataIn : STD_LOGIC_VECTOR (31 downto 0);
	signal Enemy_A_dataOut : STD_LOGIC_VECTOR (31 downto 0);
	signal Enemy_A_write : STD_LOGIC;
	signal Enemy_B_addr : STD_LOGIC_VECTOR (8 downto 0);
	signal Enemy_B_data : STD_LOGIC_VECTOR (31 downto 0);
	
begin
	VGA_HSYNC <= VGA_H;

	horizontal 		: vga2 port map(clocklink, hcounter, hdisplay, VGA_H); 

	vertical 		: vga1 port map(VGA_H, vcounter, vdisplay, VGA_VSYNC); 

	clock_divider1 : clock_divider port map(clk, clocklink);

	display1 		: Display port map (clk, vdisplay, hdisplay, hcounter , display_data, display_address,
									 VGA_RED, VGA_GREEN,VGA_BLUE);
									
	screen1 			: screen port map (clk, update_address, display_address, update_data, display_data);

	update1			: update port map (clk, hcounter, vcounter, MainGuyXpos, MainGuyYpos, 
									 Enemy_B_data, Enemy_B_addr, update_address, update_data  );

	main_guy1		: main_guy port map (clk, arrowU, arrowD, arrowL, arrowR, MainGuyXpos, MainGuyYpos);

	enemy1			: enemy port map (clk, Enemy_A_dataIn, Enemy_A_addr, Enemy_A_dataOut, Enemy_A_write);

	enemy_ram1 		: enemy_ram port map (clk, Enemy_A_addr, Enemy_A_dataIn, Enemy_A_dataOut, 
									Enemy_A_write, Enemy_B_addr, Enemy_B_data);

end Behavioral;