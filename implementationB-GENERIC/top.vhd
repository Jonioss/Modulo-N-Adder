library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;


entity top is
generic(N: integer := 9;
	MODULUS: integer := 15);
port(A, B: in std_logic_vector(n-1 downto 0);
	clk, rst: in std_logic;
	R: out std_logic_vector(integer(ceil(log2(real(MODULUS))))-1 downto 0));
end;

architecture rtl of top is

component QD is 
	generic (n:integer:=4);
	PORT(q:in std_logic_vector(n-1 downto 0);
	     clk,rst:std_logic;
	     d:out std_logic_vector(n-1 downto 0));
end component;

component mod_n_adder is
  GENERIC (n: integer := 9;
					 m: integer := 3);
  PORT (A, B: in std_logic_vector(n-1 downto 0); 
				D: in std_logic_vector(m-1 downto 0);
    		R: out std_logic_vector(m-1 downto 0));
end component;

constant SIZE: integer := integer(ceil(log2(real(MODULUS)))); -- # of bits derived from M dynamically

signal sig_in_A: std_logic_vector(n-1 downto 0);
signal sig_in_B: std_logic_vector(n-1 downto 0);
signal sig_in_D: std_logic_vector(SIZE-1 downto 0);
signal sig_out_R: std_logic_vector(SIZE-1 downto 0);

begin

sig_in_D <= std_logic_vector(to_unsigned(MODULUS, SIZE)); -- mod5

QD_A:QD generic map (N) port map (q=>A, clk=>clk, rst=>rst, d=>sig_in_A);
QD_B:QD generic map (N) port map (q=>B, clk=>clk, rst=>rst, d=>sig_in_B);

AD:mod_n_adder generic map (n=>N, m=>SIZE) port map (A=>sig_in_A, B=>sig_in_B,
						D=>sig_in_D, R=>sig_out_R);

QD_R:QD generic map (SIZE) port map (q=>sig_out_R, clk=>clk, rst=>rst, d=>R);

end;


