library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- junta 4 somadores completos de um bit para fazer um somador completo de 4 bits

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

