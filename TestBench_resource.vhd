--CS179j
--Kyle Chen
library IEEE ;
use IEEE.STD_LOGIC_1164.all ;
use IEEE.STD_LOGIC_ARITH.all ;

entity TestBench_resource is
end TestBench_resource ;

architecture NSy_resource of TestBench_resource is

  constant ZERO_16 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0') ;
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
  
	
	component update is
	port (
		clk 			: in STD_LOGIC;
		hpos 			: in STD_LOGIC_VECTOR(9 downto 0); --when will horizontal refresh
		vpos 			: in STD_LOGIC_VECTOR (8 downto 0);
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
		address 		: out STD_LOGIC_VECTOR (11 downto 0);
		data 		: out STD_LOGIC_VECTOR (3 downto 0)

	);
	end component;

  signal clk : STD_LOGIC := '0' ;
  signal e1	: STD_LOGIC_VECTOR (31 downto 0);
  signal e2	: STD_LOGIC_VECTOR (31 downto 0);
  signal e3	: STD_LOGIC_VECTOR (31 downto 0);
  signal e4	: STD_LOGIC_VECTOR (31 downto 0);
  signal e5	: STD_LOGIC_VECTOR (31 downto 0);
  signal e6	: STD_LOGIC_VECTOR (31 downto 0);
  signal e7	: STD_LOGIC_VECTOR (31 downto 0);
  signal e8	: STD_LOGIC_VECTOR (31 downto 0);
  signal hpos : std_logic_vector (9 downto 0);
  signal ypos : std_logic_vector (8 downto 0);
  signal mx : std_logic_vector (9 downto 0);
  signal my : std_logic_vector (8 downto 0);
  signal add : std_logic_vector (11 downto 0);
  signal data : std_logic_vector (3 downto 0);
	signal r1 : STD_LOGIC_VECTOR (23 downto 0):= "000000101000000111100000";
	signal r2 : STD_LOGIC_VECTOR (23 downto 0):= "000000101000000111100000";
	signal r3 : STD_LOGIC_VECTOR (23 downto 0):= "000000101000000111100000";
	signal r4 : STD_LOGIC_VECTOR (23 downto 0):= "000000101000000111100000";
	signal rhit : STD_LOGIC_VECTOR (2 downto 0);
	

begin
	
  TL : resource port map (clk, rhit, r1,r2,r3,r4) ;
  TL1 : update port map (clk, hpos, ypos, mx, my, e1, e2,e3,e4,e5,e6,e7,e8, r1, r2,r3,r4, rhit, add, data  );
  clk <= not clk after 1 ns ;
--  rst <= '0' after 20 ns ;

end NSy_resource ;

configuration TB_CFGr of TestBench_resource is
  for NSy_resource
  end for ;
end TB_CFGr ;

