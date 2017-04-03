--CS179j
--Kyle Chen
library IEEE ;
use IEEE.STD_LOGIC_1164.all ;
use IEEE.STD_LOGIC_ARITH.all ;

entity TestBench_enemy is
end TestBench_enemy ;

architecture NSy_enemy of TestBench_enemy is

  constant ZERO_16 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0') ;

  component enemy is
    port(
		clk 		: in  STD_LOGIC;
		indata	: in STD_LOGIC_VECTOR (31 downto 0);
		address : out STD_LOGIC_VECTOR (8 downto 0);
		outdata	: out STD_LOGIC_VECTOR (31 downto 0);
		writeEnable : out STD_LOGIC
        ) ;
  end component ;
  
  component enemy_ram is
    Port ( 
				clk 	: in  	std_logic;

				portA_address 	: in 		std_logic_vector(8 downto 0);
				portA_dataIn  	: in  	std_logic_vector(31 downto 0);
				portA_dataOut  : out 	std_logic_vector(31 downto 0);
				portA_write		: in		std_logic;
				
				portB_address 	: in 		std_logic_vector(8 downto 0);
				portB_data  	: out  	std_logic_vector(31 downto 0)
		
			  );
end component;

  signal clk : STD_LOGIC := '0' ;
  signal indata	: STD_LOGIC_VECTOR (31 downto 0);
  signal address :  STD_LOGIC_VECTOR (8 downto 0);
  signal outdata	:  STD_LOGIC_VECTOR (31 downto 0);
  signal writeEnable :  STD_LOGIC;
	
  signal dummy1 : std_logic_vector (8 downto 0);
	signal dummy2 : std_logic_vector (31 downto 0);

begin

  TL : enemy port map (clk, indata, address, outdata, writeEnable) ;
  TL1 : enemy_ram port map (clk, address, outdata, indata, writeEnable, dummy1, dummy2  );
  clk <= not clk after 1 ns ;
--  rst <= '0' after 20 ns ;

end NSy_enemy ;

configuration TB_CFG of TestBench_enemy is
  for NSy_enemy 
  end for ;
end TB_CFG ;

