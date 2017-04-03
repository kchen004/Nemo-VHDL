--CS179j
--Kyle Chen
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity game is
	port (

		arrowU : in STD_LOGIC;
		arrowD : in STD_LOGIC;
		arrowL : in STD_LOGIC;
		arrowR : in STD_LOGIC;
		VGA_RED 		: out STD_LOGIC;
		VGA_GREEN	: out STD_LOGIC;
		VGA_BLUE		: out STD_LOGIC;
		
		VGA_HSYNC	: out STD_LOGIC;
		VGA_VSYNC	: out STD_LOGIC;
		
			reset:	    in std_logic;
					clock : in STD_LOGIC ;
			psxdata:	in std_logic;
			psxatt:	    out std_logic;
			psxclk:	    out std_logic;
			psxcmd:	    out std_logic;
			psxack:	    in std_logic;

			leds:	    out std_logic_vector(7 downto 0)
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
		jellydie : in std_logic;
		Enemy1out	: out STD_LOGIC_VECTOR (31 downto 0);
		Enemy2out	: out STD_LOGIC_VECTOR (31 downto 0);
		Enemy3out	: out STD_LOGIC_VECTOR (31 downto 0);
		Enemy4out	: out STD_LOGIC_VECTOR (31 downto 0);
		Enemy5out	: out STD_LOGIC_VECTOR (31 downto 0);
		Enemy6out	: out STD_LOGIC_VECTOR (31 downto 0);
		Enemy7out	: out STD_LOGIC_VECTOR (31 downto 0);
		Enemy8out	: out STD_LOGIC_VECTOR (31 downto 0)

	
	);
	end component;
	
	component resource is
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
end component;


component Ram1 is
    Port ( 
				clock 	: in  	std_logic;
		--		reset 	: in  	std_logic;
				address1 	: in 		std_logic_vector(11 downto 0);
				data1 	: out  	std_logic_vector(3 downto 0)

		
			  );
end component;


component Ram2 is
    Port ( 
				clock 	: in  	std_logic;
				address 	: in 		std_logic_vector(11 downto 0);
				data  	: out  	std_logic_vector(3 downto 0)
		
			  );
end component;


component psx is
	port (
	    reset:	in std_logic;
	    clock:	in std_logic;
	    psxdata:	    in std_logic;
	    psxatt:	out std_logic;
	    psxclk:	out std_logic;
	    psxcmd:	out std_logic;
	    psxack:	in std_logic;

	    btn_up:	out std_logic;
	    btn_down:	    out std_logic;
	    btn_left:	    out std_logic;
	    btn_right:	out std_logic;
	    btn_select:	out std_logic;
	    btn_start:	out std_logic;
	    btn_triangle:   out std_logic;
	    btn_x:	out std_logic;
	    btn_square:	out std_logic;
	    btn_circle:	out std_logic;
	    btn_l1:	out std_logic;
	    btn_l2:	out std_logic;
	    btn_r1:	out std_logic;
	    btn_r2:	out std_logic
	);
    end component;
--	component enemy is
--	port (
--		clk 		: in  STD_LOGIC;
--		indata	: in STD_LOGIC_VECTOR (31 downto 0);
--		address : out STD_LOGIC_VECTOR (8 downto 0);
--		outdata	: out STD_LOGIC_VECTOR (31 downto 0);
--		writeEnable : out STD_LOGIC
--	);
--	end component;
--	
--	component enemy_ram is
--   port ( 
--				clk 	: in  	std_logic;
--
--				portA_address 	: in 		std_logic_vector(8 downto 0);
--				portA_dataIn  	: in  	std_logic_vector(31 downto 0);
--				portA_dataOut  : out 	std_logic_vector(31 downto 0);
--				portA_write		: in		std_logic;
--				
--				portB_address 	: in 		std_logic_vector(8 downto 0);
--				portB_data  	: out  	std_logic_vector(31 downto 0)
--		
--		
--	);
--	end component;
	
	
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
--	signal Enemy_A_addr : std_logic_vector (8 downto 0);
--	signal Enemy_A_dataIn : STD_LOGIC_VECTOR (31 downto 0);
--	signal Enemy_A_dataOut : STD_LOGIC_VECTOR (31 downto 0);
--	signal Enemy_A_write : STD_LOGIC;
--	signal Enemy_B_addr : STD_LOGIC_VECTOR (8 downto 0);
--	signal Enemy_B_data : STD_LOGIC_VECTOR (31 downto 0);
	signal Enemy1 : std_logic_vector (31 downto 0);
	signal Enemy2 : std_logic_vector (31 downto 0);
	signal Enemy3 : std_logic_vector (31 downto 0);
	signal Enemy4 : std_logic_vector (31 downto 0);
	signal Enemy5 : std_logic_vector (31 downto 0);
	signal Enemy6 : std_logic_vector (31 downto 0);
	signal Enemy7 : std_logic_vector (31 downto 0);
	signal Enemy8 : std_logic_vector (31 downto 0);
	signal r1	  : std_logic_vector (23 downto 0);
	signal r2	  : std_logic_vector (23 downto 0);
	signal r3	  : std_logic_vector (23 downto 0);
	signal r4	  : std_logic_vector (23 downto 0);
	signal rhit	  : std_logic_vector (2 downto 0);
	signal Ram1address : std_logic_vector (11 downto 0);	
	signal Ram1data : std_logic_vector(3 downto 0);
	signal Ram2address : std_logic_vector (11 downto 0);
	signal Ram2data : std_logic_vector(3 downto 0);
	signal jellydie : std_logic;
	signal btn_up1 : std_logic;
	signal btn_down1 : std_logic;
	signal btn_left1 : std_logic;
	signal btn_right1 : std_logic;

begin

	VGA_HSYNC <= VGA_H;
	leds(7) <= btn_up1 ;
	leds(6) <= btn_down1 ;
	leds(5) <= btn_left1 ;
	leds(4) <= btn_right1 ;

	horizontal 		: vga2 port map(clocklink, hcounter, hdisplay, VGA_H); 

	vertical 		: vga1 port map(VGA_H, vcounter, vdisplay, VGA_VSYNC); 

	clock_divider1 : clock_divider port map(clock, clocklink);

	display1 		: Display port map (clock, vdisplay, hdisplay, hcounter , display_data, display_address,
									 VGA_RED, VGA_GREEN,VGA_BLUE);
									
	screen1 			: screen port map (clock, update_address, display_address, update_data, display_data);

--	update1			: update port map (clk, hcounter, vcounter, MainGuyXpos, MainGuyYpos, 
--									 Enemy_B_data, Enemy_B_addr, update_address, update_data  );

	update1			: update port map (clock, hcounter, vcounter, MainGuyXpos, MainGuyYpos, 
									 Enemy1, Enemy2, Enemy3, Enemy4, Enemy5, Enemy6, Enemy7, Enemy8,
									 r1, r2, r3, r4, rhit, Ram1data, Ram1address,Ram2data, Ram2address,  
									 jellydie, update_data,update_address  );
									 
	main_guy1		: main_guy port map (clock, btn_up1, btn_down1, btn_left1, btn_right1, MainGuyXpos, MainGuyYpos);
	
	jellyfish			: enemy port map (clock, jellydie,Enemy1, Enemy2, Enemy3, Enemy4, Enemy5, Enemy6, Enemy7, Enemy8);

	resource1		: resource port map (clock, rhit, r1, r2, r3, r4);

	Ram11				: Ram1 port map (clock, Ram1address, Ram1data);
	Ram21				: Ram2 port map (clock, Ram2address, Ram2data);
--	enemy1			: enemy port map (clk, Enemy_A_dataOut, Enemy_A_addr, Enemy_A_dataIn, Enemy_A_write);
	
--enemy_ram1 		: enemy_ram port map (clk, Enemy_A_addr, Enemy_A_dataIn, Enemy_A_dataOut, Enemy_A_write, Enemy_B_addr, Enemy_B_data);
	U_psx: psx port map(
						reset 		=>	   reset,
						clock 		=>	   clock,
						psxdata 		=>		psxdata,
						psxatt 		=>	   psxatt,
						psxclk 		=>	   psxclk,
						psxcmd 		=>	   psxcmd,
						psxack 		=>	   psxack,

						btn_up 		=>	   btn_up1,
						btn_down 	=>		btn_down1,
						btn_left	=>		btn_left1,
						btn_right 	=>	   btn_right1,

						btn_select 	=>	   open,
						btn_start 	=>	   open,

						btn_triangle =>	leds(3),
						btn_x 		=>	   leds(2),
						btn_square 	=>	   leds(1),
						btn_circle 	=>	   leds(0),

						btn_l1 		=>	    open,
						btn_l2 		=>	    open,
						btn_r1 		=>	    open,
						btn_r2 		=>	    open
    );
end Behavioral;