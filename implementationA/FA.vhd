library ieee;
use ieee.std_logic_1164.all;

entity FA is
  PORT (a,b,cin: in std_logic;
    s,cout: out std_logic);
end;

architecture rtl of FA is
begin
  s <= (a xor b) xor cin;
  cout <= (a and b) or (cin and (a xor b));
end;


