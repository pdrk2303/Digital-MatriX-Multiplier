----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 12:19:36 AM
-- Design Name: 
-- Module Name: multiplier - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
--use IEEE.NUMERIC_BIT.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplier is
  Port (a : in std_logic_vector(7 downto 0);
        b : in std_logic_vector(7 downto 0);
        c : out std_logic_vector(15 downto 0));
end multiplier;

architecture Behavioral of multiplier is
signal a_int : integer;
signal b_int : integer;
signal c_int : integer;
begin

a_int <= TO_INTEGER(unsigned(a));
b_int <= TO_INTEGER(unsigned(b));

c_int <= a_int * b_int;
c <= std_logic_vector(to_unsigned(c_int,c'length));

end Behavioral;

