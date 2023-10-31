library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is --entidade que junta tudo para funcionar na placa
	port(
		op: in std_logic_vector (2 downto 0); --teste
		clk: in std_logic; -- teste denvo
		reset: in std_logic;
		Q: out std_logic_vector (3 downto 0);
		flag_zero : out std_logic;
		flag_overflow : out std_logic;
		flag_negative : out std_logic;
		flag_carry_out : out std_logic);
	
end main;

architecture hardware of main is
	component ula
    	Port ( a, b : in  STD_LOGIC_VECTOR (3 downto 0);
			opcode : in  STD_LOGIC_VECTOR (2 downto 0);
           	result : out  STD_LOGIC_VECTOR (3 downto 0);
			zero : out std_logic;
			overflow : out std_logic;
			negative : out std_logic;
			carry_out : out std_logic);
	end component;
	
	component contador
		port(
			clk: in std_logic; -- clock
			reset: in std_logic; -- reset
			ent: out unsigned (7 downto 0) := "00000000" -- saida
		);
	end component;

	signal A,B: std_logic_vector (3 downto 0);
	signal AB: unsigned (7 downto 0);

begin
	ula_process: ula PORT MAP (A, B, op, Q, flag_zero, flag_overflow, flag_negative, flag_carry_out);
	conta: contador PORT MAP(clk, reset, AB);
	
	A <= std_logic_vector(AB(3 downto 0));
	B <= std_logic_vector(AB(7 downto 4));
	

end hardware;