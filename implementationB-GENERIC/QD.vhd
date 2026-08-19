library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity QD is 
	generic (n:integer:=4);
	PORT(q:in std_logic_vector(n-1 downto 0);
	     clk,rst:std_logic;
	     d:out std_logic_vector(n-1 downto 0));
end QD;

architecture my_arch of QD is
begin
process(clk,rst)
begin
	if rst='1' then
		d<=(others=>'0');
	elsif clk'event and clk='1' then
		d<=q;
	end if;
end process;
end my_arch;
