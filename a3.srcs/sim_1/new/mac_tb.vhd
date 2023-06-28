----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 08:47:21 PM
-- Design Name: 
-- Module Name: mac_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mac_tb is
--  Port ( );
end mac_tb;

architecture Behavioral of mac_tb is
component mac 
    Port ( clk : in STD_LOGIC;
           cntrl : in STD_LOGIC;
           input1 : in STD_LOGIC_VECTOR (7 downto 0);
           input2 : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (15 downto 0));
end component;
signal clk,cntrl : std_logic := '1'; 
signal input1,input2 : std_logic_vector(7 downto 0); 
signal output : std_logic_vector (15 downto 0);
begin
UUT : mac port map (clk=>clk,cntrl=>cntrl,input1=>input1,input2=>input2,output=>output);
clk <= not clk after 5 ns;
cntrl <= '1';
input1 <= "0000001";
input2 <= "0000011";
end Behavioral;
