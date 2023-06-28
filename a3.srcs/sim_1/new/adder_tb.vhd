----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 08:56:01 PM
-- Design Name: 
-- Module Name: adder_tb - Behavioral
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

entity adder_tb is
--  Port ( );
end adder_tb;

architecture Behavioral of adder_tb is
component adder16bit 
    Port ( x : in STD_LOGIC_VECTOR (15 downto 0);
           y : in STD_LOGIC_VECTOR (15 downto 0);
           cin : in STD_LOGIC;
           z : out STD_LOGIC_VECTOR (15 downto 0);
           cout : out STD_LOGIC);
end component;
signal x,y,z : std_logic_vector(15 downto 0);
signal cin,cout : std_logic;
begin
UUT : adder16bit port map (x=>x,y=>y,cin=>cin,cout=>cout,z=>z);
x <= "0000000000000001";
y <= "0000000000000011";
cin <= '0';
end Behavioral;
