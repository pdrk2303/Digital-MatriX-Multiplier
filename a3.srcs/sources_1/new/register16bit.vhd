----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 12:18:57 AM
-- Design Name: 
-- Module Name: register16bit - Behavioral
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

entity register16bit is
    Port ( din : in STD_LOGIC_VECTOR (15 downto 0);
           dout : out STD_LOGIC_VECTOR (15 downto 0);
           we : in STD_LOGIC;
           clk : in std_logic);
end register16bit;

architecture Behavioral of register16bit is
signal dlatch : std_logic_vector(din'range) := (others => '0');
begin
process(clk)
begin
if rising_edge(clk) then
    if we = '1' then
        dlatch <= din;
    end if;
end if;
end process;
dout <= dlatch;

end Behavioral;