library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- somador completo de 1 bit, toma três entradas e duas saídas

entity somador1bit is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           cin : in  STD_LOGIC;
           sum : out  STD_LOGIC;
           cout : out  STD_LOGIC);
end somador1bit;

architecture Behavioral of somador1bit is

begin
	sum <= a xor b xor cin;
	cout <= (a and b) or ((a xor b) and cin);

end Behavioral;

