----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 07:23:02 PM
-- Design Name: 
-- Module Name: a3_main_tb - Behavioral
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

entity a3_main_tb is
   -- Port ( );
end a3_main_tb;

architecture Behavioral of a3_main_tb is
component a3_main
    Port ( clk : in STD_LOGIC;
           --done : in std_logic;
           addr : in std_logic_vector(13 downto 0);
           output : out std_logic_vector(15 downto 0));
end component;
signal clk : std_logic := '1';
signal addr : std_logic_vector(13 downto 0);
signal output : std_logic_vector(15 downto 0);
begin
UUT : a3_main port map (clk=>clk,addr=>addr,output=>output);
 clk <= not clk after 10 ns;
 addr <= "00000000000000";

end Behavioral;
