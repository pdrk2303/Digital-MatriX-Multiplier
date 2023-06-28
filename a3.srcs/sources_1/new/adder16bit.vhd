----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 12:15:08 AM
-- Design Name: 
-- Module Name: adder16bit - Behavioral
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

entity adder16bit is
    Port ( x : in STD_LOGIC_VECTOR (15 downto 0);
           y : in STD_LOGIC_VECTOR (15 downto 0);
           cin : in STD_LOGIC;
           z : out STD_LOGIC_VECTOR (15 downto 0);
           cout : out STD_LOGIC);
end adder16bit;

architecture Behavioral of adder16bit is


signal c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15 : std_logic;
component full_adder
    Port( a : in std_logic;
          b : in std_logic;
          cin : in std_logic;
          s : out std_logic;
          cout : out std_logic);
end component;

begin

i0 : full_adder port map(x(0),y(0),cin,z(0),c1);
i1 : full_adder port map(x(1),y(1),c1,z(1),c2);
i2 : full_adder port map(x(2),y(2),c2,z(2),c3);
i3 : full_adder port map(x(3),y(3),c3,z(3),c4);
i4 : full_adder port map(x(4),y(4),c4,z(4),c5);
i5 : full_adder port map(x(5),y(5),c5,z(5),c6);
i6 : full_adder port map(x(6),y(6),c6,z(6),c7);
i7 : full_adder port map(x(7),y(7),c7,z(7),c8);
i8 : full_adder port map(x(8),y(8),c8,z(8),c9);
i9 : full_adder port map(x(9),y(9),c9,z(9),c10);
i10 : full_adder port map(x(10),y(10),c10,z(10),c11);
i11 : full_adder port map(x(11),y(11),c11,z(11),c12);
i12 : full_adder port map(x(12),y(12),c12,z(12),c13);
i13 : full_adder port map(x(13),y(13),c13,z(13),c14);
i14 : full_adder port map(x(14),y(14),c14,z(14),c15);
i15 : full_adder port map(x(15),y(15),c15,z(15),cout);


end Behavioral;
