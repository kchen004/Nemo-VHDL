--CS179j
--Kyle Chen

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.all;

--**************************************************************************--

entity clock_divider is 
	port(
             clk : in STD_LOGIC;
             out_clk : out STD_LOGIC);
end clock_divider;

--**************************************************************************--

architecture arch of clock_divider is
 
	--how much need to divide, divided by 2 and - 1
 --  constant X : UNSIGNED (0 downto 0) := "0" ;
			
	signal temp : STD_LOGIC := '0';
--	signal counter : UNSIGNED (0 downto 0):= "0";
begin	
	--counter <= "0";
	process(clk)
	begin
		--out_clk <= clk;
		if( clk'event and clk = '1' ) then

		--	if( counter = X) then
			
			--	counter <= "0";
				out_clk <= temp;
				temp <= not temp;
		--	else
				
	--			counter <= counter + "1";
		--	end if;
		end if;
	end process;
end arch;



