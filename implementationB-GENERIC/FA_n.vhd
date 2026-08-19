library ieee;
use ieee.std_logic_1164.all;

entity FA_n is
  GENERIC (n: integer := 4);
  PORT (A, B: in std_logic_vector(n-1 downto 0);
    Cin: in std_logic;
    Outp: out std_logic_vector(n-1 downto 0);
    Cout: out std_logic);
end;

architecture rtl of FA_n is
signal c: std_logic_vector(n-1 downto 0);
component FA is
  PORT (a,b,cin: in std_logic;
    s,cout: out std_logic);
end component;  

begin
  FA_0:FA port map(a=>A(0), b=>B(0), cin=>Cin, s=>Outp(0), cout=>c(0));
  generate_FA:
  for i in 1 to n-1 generate
    FA_i:FA port map(a=>A(i), b=>B(i), cin=>c(i-1), s=>Outp(i), cout=>c(i));
end generate;
  cout <= c(n-1);
end;



