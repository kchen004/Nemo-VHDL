
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity randomGenerator is
	port (
		--clk in : std_logic;
		random out : std_logic_vector (31 downto 0)
	}

end randomGenerator;

architecture Behavioral of randomGenerator is
	signal x1 : std_logic_vector (15 downto 0) := "1100100100110010";

begin
	random <= x1;
	process (x1)
	begin
		x1 <= x1(14 downto 0) & (x1(15) xnor x1(0) xnor x1(1));
	end process;

end Behavioral;

