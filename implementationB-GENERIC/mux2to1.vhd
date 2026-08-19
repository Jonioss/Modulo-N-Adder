library ieee;
use ieee.std_logic_1164.all;

entity mux2to1 is
  generic(n: integer := 8);
  PORT(w0, w1: in std_logic_vector(n-1 downto 0);
  s: in std_logic;
  f: out std_logic_vector(n-1 downto 0));
end;

architecture mux2to1_arch of mux2to1 is
begin
	with s select  
		f <= w0 when '0',
         w1 when others;
end;
