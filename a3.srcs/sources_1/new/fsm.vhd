----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 12:41:53 AM
-- Design Name: 
-- Module Name: fsm - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm is
    Port ( clk : in std_logic;
           done : out std_logic;
           reset : in std_logic );
end fsm;

architecture Behavioral of fsm is

--mac
component mac
    Port ( clk : in STD_LOGIC;
           cntrl : in STD_LOGIC;
           input1 : in STD_LOGIC_VECTOR (7 downto 0);
           input2 : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (15 downto 0));
end component;

--reg8bit
component register8bit
    Port ( clk : in STD_LOGIC;
           we : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (7 downto 0);
           dout : out STD_LOGIC_VECTOR (7 downto 0));
end component;
--reg16bit
component register16bit
    Port ( clk : in STD_LOGIC;
           we : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (15 downto 0);
           dout : out STD_LOGIC_VECTOR (15 downto 0));
end component;
--rom1
component dist_mem_gen_0
    port (
    a : in STD_LOGIC_VECTOR ( 13 downto 0 );
    clk : in std_logic;
    spo : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
end component;
--rom2
component dist_mem_gen_2
    port (
    a : in STD_LOGIC_VECTOR ( 13 downto 0 );
    clk : in std_logic;
    spo : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
end component;
--ram
component dist_mem_gen_1
    port (
    a : in STD_LOGIC_VECTOR ( 13 downto 0 );
    clk : in STD_LOGIC;
    d : in STD_LOGIC_VECTOR ( 15 downto 0 );
    spo : out STD_LOGIC_VECTOR (15 downto 0 );
    we : in STD_LOGIC
  );
end component;

--addr for rom and ram
signal addr1,addr2,addr_ram : std_logic_vector(13 downto 0):= (others =>
'0');
--outputs of roms,mac inputs,8bit registers
signal spo_1,spo_2,reg8_o1,reg8_o2,input1,input2 : std_logic_vector(7
downto 0);
--signal cntrl : std_logic:='1';
--write input for ram,registers
signal reg8_we1,reg8_we2,reg16_we,ram_we : std_logic:='0';
--output of mac,16bit register,ram
signal output,reg16_dout,spo_ram : std_logic_vector(15 downto 0);
--counters
signal product_count, row_count, ram_row_count, ram_col_count : integer
range 0 to 128:=0;
--bit counter
signal total_count : integer range 0 to 16384:=0;
signal row_change,ram_row_change : std_logic;
signal first_product,first_write : std_logic:='1';
--state declaration
type state_type is (rom_state,mac_state,ram_state,complete);
signal curr_state : state_type := rom_state;
signal next_state : state_type := rom_state;
begin

UUT1 : dist_mem_gen_0 port map (a=>addr1,clk=>clk,spo=>spo_1);
UUT2 : dist_mem_gen_2 port map (a=>addr2,clk=>clk,spo=>spo_2);
UUT3 : dist_mem_gen_1 port map (a=>addr_ram,clk=>clk,d=>reg16_dout,spo=>spo_ram,we=>ram_we);
UUT4 : register8bit port map (clk=>clk,we=>reg8_we1,din=>spo_1,dout=>reg8_o1);
UUT5 : register8bit port map (clk=>clk,we=>reg8_we2,din=>spo_2,dout=>reg8_o2);
UUT6 : register16bit port map (clk=>clk,we=>reg16_we,din=>output,dout=>reg16_dout);
UUT7 : mac port map (clk=>clk,cntrl=>first_product,input1=>reg8_o1,input2=>reg8_o2,output=>output);

process(clk,reset)
begin
    if reset = '1' then
        curr_state <= rom_state;
    elsif rising_edge(clk) then
        curr_state <= next_state;
    end if;
end process;

--process(row_count)
--begin
--if row_change = '1' then
--    addr1 <= CONV_STD_LOGIC_VECTOR(row_count,addr1'length);
--end if;
--end process;

--process(ram_row_count)
--begin
--if ram_row_change = '1' then
--    addr_ram <= CONV_STD_LOGIC_VECTOR(ram_row_count,addr_ram'length);
--end if;
--end process;

process(curr_state)
begin
    next_state <= curr_state;
    case curr_state is
        when rom_state =>
            if total_count = 16384 then
                total_count <= 0;
                first_product <= '1';
                row_count <= row_count + 1;
                row_change <= '1';
                addr2 <= (others => '0');
                addr1 <= CONV_STD_LOGIC_VECTOR(row_count,addr1'length);
            end if;

            if product_count = 128 then
                product_count <= 0;
                addr1 <= CONV_STD_LOGIC_VECTOR(row_count,addr1'length);
                addr2 <= addr2 + "00000000000001";
                first_product <= '1';
            end if;

            if first_product = '1' then
                addr1 <= addr1;
                addr2 <= addr2;
                first_product <= '0';
                product_count <= product_count + 1;
                total_count <= total_count + 1;
                row_change <= '0';
            else
                addr1 <= addr1 + "00000010000000";
                addr2 <= addr2 + "00000000000001";
                product_count <= product_count + 1;
                total_count <= total_count + 1;
            end if;
        next_state <= mac_state;
        when mac_state =>
            reg8_we1 <= '1';
            reg8_we2 <= '1';
            if product_count = 128 then
                next_state <= ram_state;
            else
                next_state <= rom_state;
            end if;
        when ram_state =>
            if ram_col_count = 128 then
                ram_col_count <= 0;
                ram_row_count <= ram_row_count + 1;
                ram_row_change <= '1';
                addr_ram <= CONV_STD_LOGIC_VECTOR(ram_row_count,addr_ram'length);
                first_write <= '1';
            end if;

            if first_write = '1' then
                addr_ram <= addr_ram;
                first_write <= '0';
                ram_col_count <= ram_col_count + 1;
                ram_row_change <= '0';
            else
                addr_ram <= addr_ram + "00000010000000";
                ram_col_count <= ram_col_count + 1;
            end if;



--            if first_write = '1' then
--                addr_ram <=CONV_STD_LOGIC_VECTOR(ram_row_count,addr_ram'length);
--                first_write <= '0';
--                ram_row_change <= '0';
--            else
--                if ram_col_count = 128 then
--                    ram_row_count <= ram_row_count + 1;
--                    ram_col_count <= 0;
--                    ram_row_change <= '1';
--                    first_write <= '1';
--                else
--                    addr_ram <= addr_ram + "00000010000000";
--                    ram_col_count <= ram_col_count + 1;
--                    ram_row_change <= '0';
--                end if;
--            end if;
                ram_we <= '1';
                if ram_row_count = 128 then
                    next_state <= complete;
                else
                    next_state <= rom_state;
                end if;
        when complete =>
            done <= '1';
    end case;
end process;
end Behavioral;
