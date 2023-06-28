----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 12:20:25 AM
-- Design Name: 
-- Module Name: mac - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mac is
    Port ( clk : in STD_LOGIC;
           cntrl : in STD_LOGIC;
           input1 : in STD_LOGIC_VECTOR (7 downto 0);
           input2 : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (15 downto 0));
end mac;

architecture Behavioral of mac is

component multiplier
        Port ( a : in STD_LOGIC_VECTOR(7 downto 0);
       b : in STD_LOGIC_VECTOR(7 downto 0);
       c : out STD_LOGIC_VECTOR(15 downto 0));
end component;

component adder16bit
    Port ( x : in STD_LOGIC_VECTOR (15 downto 0);
           y : in STD_LOGIC_VECTOR (15 downto 0);
           cin : in STD_LOGIC;
           z : out STD_LOGIC_VECTOR (15 downto 0);
           cout : out STD_LOGIC);
end component;

component register16bit
        Port ( din : in STD_LOGIC_VECTOR (16 downto 0);
       dout : out STD_LOGIC_VECTOR (16 downto 0);
       we : in STD_LOGIC;
       clk : in std_logic);
end component;
signal a,b : std_logic_vector(7 downto 0);
signal c : std_logic_vector(15 downto 0);

signal x,y,z : std_logic_vector(15 downto 0);
signal cin,cout : std_logic;

signal din,dout : std_logic_vector(15 downto 0);
signal we,clk_reg : std_logic;

signal counter : integer range 0 to 128;
begin
UUT1 : multiplier port map (a=>a,b=>b,c=>c);
UUT2 : adder16bit port map (x=>x,y=>y,cin=>cin,z=>z,cout=>cout);
UUT3 : register16bit port map (din=>din,dout=>dout,we=>we,clk=>clk_reg);
--multiplier
process(input1,input2)
begin
a <= input1;
b <= input2;
--we <= '0';
end process;
--register
process(c,z)
begin 
    if cntrl = '1' then
        din <= c;
        we <= '1';
    else
        din <= z;
        we <= '1';
    end if;
end process;
--adder
process(z,dout)
begin
    if cntrl = '1' then
        x <= dout;
        y <= (others => '0');
        cin <= '0';
    else
        x <= dout;
        y <= z;
        cin <= '0';
    end if;
end process;
end Behavioral;
