----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:30:35 09/26/2023 
-- Design Name: 
-- Module Name:    inverter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity inverter is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           negated_x : out  STD_LOGIC_VECTOR (3 downto 0);
			  sin : out STD_LOGIC);
end inverter;

architecture Behavioral of inverter is

component somador4bit is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           y : in  STD_LOGIC_VECTOR (3 downto 0);
           c_in : in  STD_LOGIC;
           c_out : out  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

signal comp_2 : STD_LOGIC_VECTOR (3 downto 0);
signal comp_2Cout : STD_LOGIC;

begin 
	negated_x(3) <= not x(3);
	negated_x(2) <= not x(2);
	negated_x(1) <= not x(1);
	negated_x(0) <= not x(0);
	
sin <= not x(3);
	
end Behavioral;

