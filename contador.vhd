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

entity contador is
	generic(t_max : integer := 40000000); -- aguarda 2s
	port(
		clk: in std_logic; -- clock
		reset: in std_logic; -- reset
		ent: out unsigned (7 downto 0) := "00000000" -- saida
	);
end contador;

architecture Behavioral of contador is
	signal ent_cnt: unsigned (7 downto 0) := "00000000"; -- sinal em que fica minhas entradas A e B e conta

begin

	contador_process : process(clk, reset) -- processo detecção
		variable t : integer range t_max downto 0 := 0; -- variavel que conta cada clock (50ns)
		begin
			if(reset = '1') then
				ent_cnt <= "00000000"; --zerar o contador quando o reset for habilitado
			elsif rising_edge(clk) then
				if (t <= t_max) then
					t := t + 1;-- incremento o temporizador
				else -- se passaram 2 segundos
					ent_cnt <= ent_cnt + 1; -- incremento o contador
					t := 0; -- zerar o temporizador depois de incrementar o contador para recomeçar a contagem no temporizador
				end if;
			end if;
	end process;
	ent <= ent_cnt; -- var saida

end Behavioral;