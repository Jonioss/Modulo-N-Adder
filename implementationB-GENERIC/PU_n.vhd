library ieee;
use ieee.std_logic_1164.all;

entity PU_n is
  GENERIC (n: integer := 8);
  PORT (A, B: in std_logic_vector(n-1 downto 0);
    Outp: out std_logic_vector(n-1 downto 0));
end;

architecture rtl of PU_n is

component FA_n is
  GENERIC (n: integer := 8);
  PORT (A, B: in std_logic_vector(n-1 downto 0);
    Cin: in std_logic;
    Outp: out std_logic_vector(n-1 downto 0);
    Cout: out std_logic);
end component; 

component mux2to1 is
  generic(n: integer := 8);
  PORT(w0, w1: in std_logic_vector(n-1 downto 0);
  s: in std_logic;
  f: out std_logic_vector(n-1 downto 0));
end component;

signal nb,faout: std_logic_vector(n-1 downto 0);
signal s: std_logic;

begin
	
	nb <= not B;
	
	FA1: FA_n generic map (n) port map (A,nb,'1',faout,s);
	MUX: mux2to1 generic map (n) port map (A,faout,s,Outp);

end;