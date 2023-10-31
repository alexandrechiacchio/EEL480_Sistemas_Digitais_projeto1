library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity main is --entidade que junta tudo para funcionar na placa
	port(
		op: in std_logic_vector (2 downto 0); -- código da operação
		clk: in std_logic; --entrada de clock
		reset: in std_logic; --reset, reinicia os valores do contador
		Q: out std_logic_vector (3 downto 0); -- resultado da operação
		flag_zero : out std_logic; --flag caso o resultado seja igual a zero
		flag_overflow : out std_logic; -- flag caso ocorra overflow na operação
		flag_negative : out std_logic; -- flag caso o resultado seja negativo
		flag_carry_out : out std_logic); -- flag caso o carry out seja 1

end main;

architecture hardware of main is
	component ula -- declaração do componente da ula
    	Port ( a, b : in  STD_LOGIC_VECTOR (3 downto 0);
			opcode : in  STD_LOGIC_VECTOR (2 downto 0);
           	result : out  STD_LOGIC_VECTOR (3 downto 0);
			zero : out std_logic;
			overflow : out std_logic;
			negative : out std_logic;
			carry_out : out std_logic);
	end component;

	component contador -- declaração do componenete do contador
		port(
			clk: in std_logic; -- clock
			reset: in std_logic; -- reset
			ent: out unsigned (7 downto 0) := "00000000" -- saida
		);
	end component;

	--sinais que servirão de entrada para a ULA
	signal A,B: std_logic_vector (3 downto 0);
	signal AB: unsigned (7 downto 0);

begin

	ula_process: ula PORT MAP (A, B, op, Q, flag_zero, flag_overflow, flag_negative, flag_carry_out); -- ULA
	conta: contador PORT MAP(clk, reset, AB); -- contador


	--atribuição dos valores de entrada da ULA
	A <= std_logic_vector(AB(3 downto 0));
	B <= std_logic_vector(AB(7 downto 4));


end hardware;