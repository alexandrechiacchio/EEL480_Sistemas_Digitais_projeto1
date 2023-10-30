----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:54:13 10/27/2023 
-- Design Name: 
-- Module Name:    diff - Behavioral 
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

entity diff is
    Port ( t : in  STD_LOGIC_VECTOR (3 downto 0);
           r : in  STD_LOGIC_VECTOR (3 downto 0);
			  negative : out  STD_LOGIC;
           diff : out  STD_LOGIC_VECTOR (3 downto 0);
			  comp2 : out  STD_LOGIC_VECTOR (3 downto 0);
           c_out : out  STD_LOGIC);
end diff;

architecture Behavioral of diff is

component somador4bit is
	port(	x, y: in STD_LOGIC_VECTOR(3 downto 0);
			c_in: in std_logic; 
			s: out STD_LOGIC_VECTOR(3 downto 0);
			c_out: out std_logic);
end component;

component inverter is
	Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
          negated_x : out  STD_LOGIC_VECTOR (3 downto 0);
			 sin : out STD_LOGIC);
end component;

signal negated_r : std_logic_vector (3 downto 0);
signal sin_neg : STD_LOGIC;
signal negated_diff : std_logic_vector (3 downto 0);
signal sin_neg_d : STD_LOGIC;
signal c_out_comp2 : STD_LOGIC;
signal diff_c : std_logic_vector (3 downto 0);

begin

inverterR_label : inverter port map (r, negated_r, sin_neg);
diffR_label : somador4bit port map (t, negated_r, '1', diff_c, c_out);
diff <= diff_c;
inverterdiff_label : inverter port map (diff_c, negated_diff, sin_neg_d);
comp2_label : somador4bit port map (negated_diff, "0000", '1', comp2, c_out_comp2);
end Behavioral;

