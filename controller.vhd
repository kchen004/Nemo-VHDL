--
-- Playstation Controller Interface
-- for digital controllers only
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity psx is
    port (
	reset:	    in std_logic;
	clock:	    in std_logic;
	psxdata:	in std_logic;
	psxatt:	    out std_logic;
	psxclk:	    out std_logic;
	psxcmd:	    out std_logic;
	psxack:	    in std_logic;

	btn_up:	    out std_logic;
	btn_down:	out std_logic;
	btn_left:	out std_logic;
	btn_right:  out std_logic;
	btn_select: out std_logic;
	btn_start:  out std_logic;
	btn_triangle:	out std_logic;
	btn_x:	    out std_logic;
	btn_square: out std_logic;
	btn_circle: out std_logic;
	btn_l1:	    out std_logic;
	btn_l2:	    out std_logic;
	btn_r1:	    out std_logic;
	btn_r2:	    out std_logic
    );
end psx;

architecture bhv of psx is
    signal clock250khz: std_logic := '0';
begin
    -- Assumes a 50Mhz clock
    process (reset, clock)
	variable count: integer := 0;
    begin
	if (reset = '1') then
	    count := 0;
	    clock250khz <= '0';
	elsif (clock = '1' and clock'event) then
	    -- count = 50 corresponds to 250khz
	    if (count = 50) then
		clock250khz <= not clock250khz;
		count := 0;
	    else
		count := count + 1;
	    end if;
	end if;
    end process;

    -- PSX controller protocol
    -- based on information at http://www.gamesx.com/controldata/psxcont/psxcont.htm
    process (reset, clock250khz)
	type states is (Init0, Init1, Send42, 
	    Get5AH, GetKey1, GetKey2, ProcessKey2, Wait1ms,
	    Send_Init, Send_Send, Send_Read,
	    Send_WaitAck1D, Send_WaitAck1U);
    
	variable state: states := Init0;
	variable retState: states := Init0;
	variable sendData: std_logic_vector(7 downto 0) := (others => '0');
	variable readData: std_logic_vector(7 downto 0) := (others => '0');
	variable length: std_logic_vector(7 downto 0) := (others => '0');
	variable bitNum: integer := 0;
	variable byteNum: integer := 0;
	variable waitAck: std_logic := '0';
	variable count: integer;
    begin
	if (reset = '1') then
	    psxatt <= '1';
	    psxclk <= '1';
	    psxcmd <= '1';

	    btn_up <= '0';
	    btn_down <= '0';
	    btn_left <= '0';
	    btn_right <= '0';
	    btn_select <= '0';
	    btn_start <= '0';
	    btn_triangle <= '0';
	    btn_circle <= '0';
	    btn_x <= '0';
	    btn_square <= '0';
	    btn_l1 <= '0';
	    btn_l2 <= '0';
	    btn_r1 <= '0';
	    btn_r2 <= '0';
	
	    state := Init0;

	elsif (clock250khz = '1' and clock250khz'event) then
	    case state is
	    when Init0 =>
		psxatt <= '1'; psxclk <= '1'; psxcmd <= '1';
		state := Init1;
		
	    -- Bring att line low and send 0x01
	    when Init1 =>
		psxatt <= '0'; psxclk <= '1'; psxcmd <= '1';
		sendData := x"01";
		waitAck := '1';
		retState := Send42;
		state := Send_Init;

	    -- Send 0x42
	    -- Controller responds with 1-byte header which we'll ignore
	    -- since this component is written for digital controllers only.
	    when Send42 =>
		psxatt <= '0'; psxclk <= '1'; psxcmd <= '0';
		sendData := x"42";
		retState := Get5AH;
		waitAck := '1';
		state := Send_Init;

	    -- Send 0x00
	    -- Controller responds with 0x5A
	    when Get5AH =>
		psxatt <= '0'; psxclk <= '1'; psxcmd <= '0';
		sendData := x"00";
		retState := GetKey1;
		waitAck := '1';
		state := Send_Init;

	    -- Send 0x00
	    -- Controller responds with first key status byte
	    when GetKey1 =>
		psxatt <= '0'; psxclk <= '1'; psxcmd <= '0';
		sendData := x"00";
		retState := GetKey2;
		waitAck := '1';
		state := Send_Init;

	    -- Send 0x00
	    -- Controller responds with second key status byte
	    -- Also parse results from first key status byte
	    when GetKey2 =>
		psxatt <= '0'; psxclk <= '1'; psxcmd <= '0';
		sendData := x"00";
		retState := ProcessKey2;
		waitAck := '0';

		btn_left <= not readData(0);
		btn_down <= not readData(1);
		btn_right <= not readData(2);
		btn_up <= not readData(3);
		btn_start <= not readData(4);
		btn_select <= not readData(7);

		state := Send_Init;

	    -- Parse results from second key status byte
	    when ProcessKey2 =>
		psxatt <= '1'; psxclk <= '1'; psxcmd <= '1';

		btn_square <= not readData(0);
		btn_x <= not readData(1);
		btn_circle <= not readData(2);
		btn_triangle <= not readData(3);
		btn_r1 <= not readData(4);    
		btn_l1 <= not readData(5);
		btn_r2 <= not readData(6);
		btn_l2 <= not readData(7);

		count := 0;
		state := Wait1ms;

	    -- Wait a bit to save power (this isn't too necessary)
	    when Wait1ms =>
		psxatt <= '1'; psxclk <= '1'; psxcmd <= '1';
		count := count + 1;
		if (count = 250) then
		    state := Init0;
		else
		    state := Wait1ms;
		end if;

	    -- Read/write "subroutine"
	    -- Transmit byte from sendData and store received byte in readData
	    -- Return to retState
	    -- Data is sent to controller on falling edge of psxclk
	    -- Data is read from controller on rising edge of psxclk
	    when Send_Init =>
		psxatt <= '0'; psxclk <= '1';
		psxcmd <= sendData(0);
		readData := x"00";
		bitNum := 0;
		state := Send_Send;
	    when Send_Send =>
		psxatt <= '0'; psxcmd <= sendData(0); psxclk <= '0';
		bitNum := bitNum + 1;
		state := Send_Read;
	    when Send_Read =>
		psxatt <= '0'; psxcmd <= sendData(0); psxclk <= '1';
		sendData := '0' & sendData(7 downto 1); -- shift right 1
		readData := readData(6 downto 0) & psxdata; -- shift left 1

		if (bitNum = 8) then
		    if (waitAck = '1') then
			state := Send_WaitAck1D;
		    else
			state := retState;
		    end if;
		else
		    state := Send_Send;
		end if;
	    when Send_WaitAck1D =>
		if (psxack = '0') then
		    state := Send_WaitAck1U;
		else
		    state := Send_WaitAck1D;
		end if;
	    when Send_WaitAck1U =>
		if (psxack = '1') then
		    state := retState;
		else
		    state := Send_WaitAck1U;
		end if;

	    end case;
	end if;
    end process;
end bhv;
