library ieee;
use ieee.std_logic_1164.all;

entity mod_n_adder is
  GENERIC (n: integer := 9;
					 m: integer := 4);
  PORT (A, B: in std_logic_vector(n-1 downto 0); 
				D: in std_logic_vector(m-1 downto 0);
    		R: out std_logic_vector(m-1 downto 0));
end;

architecture rtl of mod_n_adder is

component FA_n is
  GENERIC (n: integer := 8);
  PORT (A, B: in std_logic_vector(n-1 downto 0);
    Cin: in std_logic;
    Outp: out std_logic_vector(n-1 downto 0);
    Cout: out std_logic);
end component; 

component PU_n is
  GENERIC (n: integer := 8);
  PORT (A, B: in std_logic_vector(n-1 downto 0);
    Outp: out std_logic_vector(n-1 downto 0));
end component;

component QD is 
	generic (n:integer:=4);
	PORT(q:in std_logic_vector(n-1 downto 0);
	     clk,rst:std_logic;
	     d:out std_logic_vector(n-1 downto 0));
end component;

signal ab: std_logic_vector (n+m-1 downto 0);
signal dn: std_logic_vector (m downto 0);
--signal pin2: std_logic_vector (m downto 0);
signal pout1: std_logic_vector (m-1 downto 0);
signal pout2: std_logic_vector ((n+1)*(m+2)-2 downto 0);

begin

generate_loop1:
for i in n+1 to n+m-1 generate
ab(i) <= '0';
end generate;

dn(m) <= '0';
dn(m-1 downto 0) <= D;

FA1: FA_n generic map (n) port map (A,B,'0',ab(n-1 downto 0), ab(n));
PUi: PU_n generic map (m) port map (ab(n+m-1 downto n),D,pout1);

pout2(m downto 1) <= pout1;
pout2(m+1) <= '0';
--pin2(n-3 downto 0) <= ab(n-3 downto 0);

generate_loop2:
for i in 0 to n-1 generate
pout2 ((m+2)*i) <= ab (n-1-i);
end generate;

generate_loop3:
for i in 0 to n-2 generate
PU2: PU_n generic map (m+1) port map (pout2(((m+2)*i)+m downto (m+2)*i),dn,pout2((m+2)*(i+1)+m+1 downto (m+2)*(i+1)+1));
end generate;

PU3: PU_n generic map (m+1) port map (pout2(((m+2)*(n-1))+m downto (m+2)*(n-1)),dn,pout2((m+2)*(n)+m downto (m+2)*(n)));

R <= pout2((n)*(m+2)+m-1 downto (n)*(m+2));

end;