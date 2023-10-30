----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:21:43 09/26/2023 
-- Design Name: 
-- Module Name:    somador4bit - Behavioral 
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

entity somador4bit is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           y : in  STD_LOGIC_VECTOR (3 downto 0);
           c_in : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  c_out : out  STD_LOGIC);
			  
end somador4bit;

architecture structural of somador4bit is

component somador1bit is
	port(a, b, cin: in std_logic; sum, cout: out std_logic);
end component;
signal carry: std_logic_vector(4 downto 0);

begin
	carry(0) <= c_in;

	addr: for i in 3 downto 0 generate
		fa: somador1bit PORT MAP(x(i), y(i), carry(i), s(i), carry(i+1));
	end generate;
	
	c_out <= carry(4);
	
end structural;

