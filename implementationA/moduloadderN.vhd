library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity moduloadderN is
generic (M:integer := 5);
port (in1: in std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
	in2: in std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
	clk, rst: in std_logic;
	outp: out std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0));
end moduloadderN;

architecture rtl of moduloadderN is

component FA_n is
	generic (n: integer := 4);
 	port (A, B: in std_logic_vector(n-1 downto 0);
		Cin: in std_logic;
		Outp: out std_logic_vector(n-1 downto 0);
		Cout: out std_logic);
end component;
component QD is 
	generic (n:integer:=4);
	PORT(q:in std_logic_vector(n-1 downto 0);
	     clk,rst:std_logic;
	     d:out std_logic_vector(n-1 downto 0));
end component;

constant SIZE: integer := integer(ceil(log2(real(M)))); -- # of bits derived from M dynamically
constant CORR: integer := 2**SIZE - M; -- correction for error of ceil() function
signal path1, path2: std_logic_vector(SIZE downto 0);
signal sig_in1, sig_in2, sig_out: std_logic_vector(SIZE-1 downto 0);
signal path2_cout: std_logic;

begin
	QD_IN1:QD generic map (SIZE) port map (q=>in1, clk=>clk, rst=>rst, d=>sig_in1);
	QD_IN2:QD generic map (SIZE) port map (q=>in2, clk=>clk, rst=>rst, d=>sig_in2);

	FA_PATH1:FA_n generic map (SIZE) port map (A=>sig_in1, B=>sig_in2, Cin=>'0',
		Outp=>path1(SIZE-1 downto 0), Cout=>path1(SIZE));
	FA_PATH2:FA_n generic map (SIZE+1) port map (A=>path1, B=>std_logic_vector(to_unsigned(CORR, SIZE+1)),
		Cin=>'0', Outp=>path2, Cout=>path2_cout);

	sig_out <= path2(SIZE-1 downto 0) when path2(SIZE) = '1'
			else path1(SIZE-1 downto 0);

	QD_OUT:QD generic map (SIZE) port map (q=>sig_out, clk=>clk, rst=>rst, d=>outp);
end;