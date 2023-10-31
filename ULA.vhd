library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.all;
--use IEEE.STD_LOGIC_unsigned.all;
--use IEEE.numeric_STD.all;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ula is
    Port ( a, b : in  STD_LOGIC_VECTOR (3 downto 0);
			opcode : in  STD_LOGIC_VECTOR (2 downto 0);
           	result : out  STD_LOGIC_VECTOR (3 downto 0);
			zero : out std_logic;
			overflow : out std_logic;
			negative : out std_logic;
			carry_out : out std_logic);
end ula;

architecture structural of ula is

component somador4bit is --somador de 4 bits
	port(	x, y: in STD_LOGIC_VECTOR(3 downto 0);
			c_in: in std_logic; 
			s: out STD_LOGIC_VECTOR(3 downto 0);
			c_out: out std_logic);
end component;

component inverter is --componente que inverte os bits do input
	Port ( 	x : in  STD_LOGIC_VECTOR (3 downto 0);
          	negated_x : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component diff is --componente que faz a diferença entre a e b
    Port ( 	t : in  STD_LOGIC_VECTOR (3 downto 0);
           	r : in  STD_LOGIC_VECTOR (3 downto 0);
			negative : out  STD_LOGIC;
           	diff : out  STD_LOGIC_VECTOR (3 downto 0);
			comp2 : out  STD_LOGIC_VECTOR (3 downto 0);
			c_out : out  STD_LOGIC);
end component;

--declaração sinais usados
signal negated_a : std_logic_vector (3 downto 0);
signal negated_b : std_logic_vector (3 downto 0);
signal sum :  STD_LOGIC_VECTOR (3 downto 0);
signal sumC_out :  STD_LOGIC;
signal diff_result :  STD_LOGIC_VECTOR (3 downto 0);
signal diff_comp2 :  STD_LOGIC_VECTOR (3 downto 0);
signal diffC_out :  STD_LOGIC;
signal diff_negative : STD_LOGIC;
signal twosComplement :  STD_LOGIC_VECTOR (3 downto 0);
signal twosComplementC_out :  STD_LOGIC;
signal bump :   STD_LOGIC_VECTOR (3 downto 0);
signal bumpC_out :   STD_LOGIC;
signal left_shift : STD_LOGIC_VECTOR (3 downto 0);
signal right_shift : STD_LOGIC_VECTOR (3 downto 0);
signal equality : STD_LOGIC;
signal equality_vector : STD_LOGIC_VECTOR (3 downto 0);
signal nn : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal mm : STD_LOGIC_VECTOR (3 downto 0) := "1111";

begin

-- operações realizadas na ula
inverterA_label : inverter port map (a, negated_a);
sum_label : somador4bit port map (a, b, '0', sum, sumC_out);
diff_label : diff port map (a, b, diff_negative, diff_result, diff_comp2, diffC_out);
twosComplement_label : somador4bit port map (negated_a, nn, '1', twosComplement, twosComplementC_out);
bump_label :  somador4bit port map (a, "0000", '1', bump, bumpC_out);
left_shift_label : left_shift <= a(2 downto 0) & "0";
right_shift_label : right_shift <= "0" & a(3 downto 1);
equality_vector_label : equality <= ((a(0) xnor b(0)) and (a(1) xnor b(1)) and (a(2) xnor b(2)) and (a(3) xnor b(3)));
equality_vector(0) <= equality;
equality_vector(1) <= '0';
equality_vector(2) <= '0';
equality_vector(3) <= '0';

--processo da ula
process (a, b, opcode, negated_a, sum, sumC_out, diff_result, 
diffC_out, diff_comp2, twosComplement, twosComplementC_out, bump,
 bumpC_out, left_shift, right_shift, equality_vector)
begin 
	case (opcode) is
		when "000" => --inverter a
			result <= negated_a;
			zero <= '0';
			overflow <= '0';
			negative <= negated_a(3);
			carry_out <= '0';
		when "001" => --somar
			result <= sum;
			zero <= not (sum(0) or sum(1) or sum(2) or sum(3));
			overflow <= (a(3) xnor b(3)) xnor sum(3);
			negative <= sum(3);
			carry_out <= sumC_out;
		when "010" => --complemento a 2
			result <= twosComplement;
			zero <= not (twosComplement(0) or twosComplement(1) or twosComplement(2) or twosComplement(3));
			overflow <= '0';
			negative <= twosComplement(3);
			carry_out <= twosComplementC_out;
		when "011" => --subtração
			zero <= not (diff_result(0) or diff_result(1) or diff_result(2) or diff_result(3));
			overflow <= (a(3) xor b(3)) xnor diff_result(3);
			negative <= diff_result(3);
			if diff_result(3) = '1' then result <= diff_comp2;
			else result <= diff_result;
			end if;
			carry_out <= diffC_out;
		when "100" => --incremento 1
			result <= bump;
			zero <= not (bump(0) or bump(1) or bump(2) or bump(3));
			overflow <= (a(3) xnor b(3)) xnor bump(3);
			negative <= bump(3);
			carry_out <= bumpC_out;
		when "101" => -- >> bit shift right
			result <= right_shift;
			zero <= not (right_shift(0) or right_shift(1) or right_shift(2) or right_shift(3));
			overflow <= '0';
			negative <= '0';
			carry_out <= a(3);
		when "110" => -- << bit shift left
			result <= left_shift;
			zero <= not (left_shift(0) or left_shift(1) or left_shift(2) or left_shift(3));
			overflow <= '0';
			negative <= left_shift(3);
			carry_out <= '0';
		when "111" => -- igualdade
			result <= equality_vector;
			zero <= not (equality_vector(0) or equality_vector(1) or equality_vector(2) or equality_vector(3));
			overflow <= '0';
			negative <= '0';
			carry_out <= '0';
		when others => 
			result <= "XXXX";
			zero <= '0';
			overflow <= '0';
			negative <= '0';
			carry_out <= '0';
	end case;
end process;
