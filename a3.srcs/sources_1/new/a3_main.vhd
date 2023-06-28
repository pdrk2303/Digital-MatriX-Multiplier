----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 06:15:55 PM
-- Design Name: 
-- Module Name: a3_main - Behavioral
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

entity a3_main is
    Port ( clk : in STD_LOGIC;
           --done : in std_logic;
           addr : in std_logic_vector(13 downto 0);
           output : out std_logic_vector(15 downto 0));
end a3_main;

architecture Behavioral of a3_main is
component fsm
    Port ( clk : in std_logic;
           done : out std_logic;
           reset : in std_logic );
end component;

component dist_mem_gen_1
    port (
    a : in STD_LOGIC_VECTOR ( 13 downto 0 );
    clk : in STD_LOGIC;
    d : in STD_LOGIC_VECTOR ( 15 downto 0 );
    spo : out STD_LOGIC_VECTOR (15 downto 0 );
    we : in STD_LOGIC
  );
end component;

signal done : std_logic;
signal reset : std_logic:='0';
signal din : std_logic_vector(13 downto 0);
signal we : std_logic;
signal a : std_logic_vector(13 downto 0);
signal spo : std_logic_vector(15 downto 0);
begin

UUT1 : fsm port map (clk=>clk,done=>done,reset=>reset);
UUT2 : dist_mem_gen_1 port map (a=>a,clk=>clk,d=>din,spo=>spo,we=>we);

process(reset)
begin
if rising_edge(clk) then
    reset <= '0';
end if;
end process;

process(done)
begin
if done = '1' then
    we<= '0';
    a <=addr;
end if;
end process;
output <= spo;
end Behavioral;