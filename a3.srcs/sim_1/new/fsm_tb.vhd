----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2022 12:09:25 AM
-- Design Name: 
-- Module Name: fsm_tb - Behavioral
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

entity fsm_tb is
--  Port ( );
end fsm_tb;

architecture Behavioral of fsm_tb is
component fsm 
    Port ( clk : in std_logic;
           done : out std_logic;
           reset : in std_logic );
end component;
signal clk : std_logic:='1';   
signal done : std_logic;
signal reset : std_logic:='0';  

begin
UUT : fsm port map (clk=>clk,done=>done,reset=>reset);
clk <= not clk after 5 ns; 
reset <= '1' after 500 ns;

end Behavioral;
