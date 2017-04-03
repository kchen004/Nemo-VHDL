
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Ram1 is
    Port ( 
				clock 	: in  	std_logic;
		--		reset 	: in  	std_logic;
				address1 	: in 		std_logic_vector(11 downto 0);
				data1 	: in  	std_logic_vector(3 downto 0)

		
			  );
end Ram1;

architecture Behavioral of Ram1 is

component RAMB16_S4_S4 is
generic( 	INIT_00 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_01 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_02 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_03 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_04 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_05 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_06 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_07 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_08 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_09 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_0A : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_0B : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_0C : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_0D : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_0E : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_0F : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_10 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_11 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_12 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_13 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_14 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_15 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_16 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_17 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_18 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_19 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_1A : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_1B : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_1C : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_1D : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_1E : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_1F : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_20 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_21 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_22 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_23 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_24 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_25 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_26 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_27 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_28 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_29 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_2A : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_2B : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_2C : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_2D : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_2E : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_2F : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_30 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_31 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_32 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_33 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_34 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_35 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_36 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_37 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_38 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_39 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_3A : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_3B : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_3C : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_3D : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_3E : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
				INIT_3F : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000"
				);
port(
		WEA  : in std_logic;
		ENA  : in std_logic;
		SSRA : in std_logic;
		CLKA : in std_logic;
		ADDRA: in std_logic_vector(11 downto 0);
		DIA  : in std_logic_vector(3 downto 0);
		DOA  : out std_logic_vector(3 downto 0);
		
		WEB  : in std_logic;
		ENB  : in std_logic;
		SSRB : in std_logic;
		CLKB : in std_logic;
		ADDRB: in std_logic_vector(11 downto 0);
		DIB  : in std_logic_vector(3 downto 0);
		DOB  : out std_logic_vector(3 downto 0)
		);
end component;

signal dummy : std_logic_vector( 3 downto 0);

	begin
		MEM: RAMB16_S4_S4
		generic map(

		--Marlin1 
      INIT_00 => X"8888888888888888888888883313331535888888888888888888888888888888",
      INIT_01 => X"8888888888888888888888833311011555888888888888888888888888888888",
      INIT_02 => X"8888888888888888888888330044444055888888888888888888888888888888",
      INIT_03 => X"8888888888888888888815444444444415588888888888888888888888888888",
      INIT_04 => X"8888888888888888888844444444444440588888888888888888888888888888",
      INIT_05 => X"8888888888888888831444444444444444058888888888888888888888888888",
      INIT_06 => X"8888888888888888815444444444444444558888888888888888888888888888",
      INIT_07 => X"8888888888888883154444444444444444057888888888888888888888888888",
      INIT_08 => X"8888888888888813334444444444444444058888888888888888888888888888",
      INIT_09 => X"8888888888881377734444444444444444058888888888888888888888888888",
      INIT_0A => X"8888888888813553000344444444444445555888888888888888888888888888",
      INIT_0B => X"8888888881544444533354444444444413355338888888888888888888888888",
      INIT_0C => X"8888883154444444453335444444444433335555555888888888888888888888",
      INIT_0D => X"8888833344444444444533544444444403334444455558888888888888888888",
      INIT_0E => X"8888885444444444444433354444444401333444444415555888888888888888",
      INIT_0F=> X"8888855444444444444441335444444013333044444445555888888888888888",
      INIT_10 => X"8881155444444444444440335444440133333004444444455888888888888888",
      INIT_11 => X"8887350444455544444440335444440133333305544444455888888888888888",
      INIT_12 => X"3888353444007754444444133444401333333305555444441588888888311118",
      INIT_13 => X"8888334445007775444444133444413333333305555544453388888311805448",
      INIT_14 => X"8888344443537775444444533444433333333355555554453888800055444448",
		INIT_15 => X"8885444477777735444444533541333333333355555555330008544444444448",
      INIT_16 => X"8885444445777775444444033144133333333350555553333354444444444448",
      INIT_17 => X"8885444444577754444444413144133333335445055553333344444444444448",
      INIT_18 => X"8884444444444444444445513144433333154444505553333314444444444448",
      INIT_19 => X"8884444444444444444444413144433335544444450551333314444444444448",
      INIT_1A => X"8884444444444444444444413144401444444444445055133344444444444448",
		INIT_1B => X"8883444444444444444444453144444444444444444055133344545454444448",
      INIT_1C => X"8885400004444454444444453154444444444444444055133335455555444448",
      INIT_1D => X"8885440000005444444444553415544444444444444405513333555555444448",
      INIT_1E => X"8888544444444444444444413555554444444444444405513333055555444448",
      INIT_1F => X"8888844444454545454545513554545444444444444050513313155555444448",
      INIT_20 => X"8888884444545454445454455135050554444444445055053333154555544448",
      INIT_21 => X"8888885444454445444455533555555554444444445050513333154545444444",
      INIT_22 => X"8888888883355335533333335555545454444444450550511311115454444448",
      INIT_23 => X"8888888888813583335354454554554555444444505050501110018818814448",
      INIT_24 => X"8888888888888885454545454454545453444445450505011188818881888811",
      INIT_25 => X"8888888888888888888855555188854545455558853888888888888888888888",
		

		INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
		INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      
		
		INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000")
				port map (
						WEA => '0',				-- I never need to write to A, just read from it
						ENA  => '1',			-- Always enable A for reading
						SSRA => '0',			-- set to 0
						CLKA => clock,			-- take the clock coming from the top level
						ADDRA => address1,			-- address comes in from rgb_reader
						DIA  => "0111",
						DOA  => data1, 
						
						WEB => '0',				
						ENB  => '0',
						SSRB => '0',
						CLKB => clock,
						ADDRB => "000000000000",
						DIB  => "0111",
						DOB  => dummy
				);					
				
end Behavioral;