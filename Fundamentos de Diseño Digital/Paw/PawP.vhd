--Paw Patroll 
library ieee;
use ieee.std_logic_1164.all;
entity paw is port(
	a,b,c, d, e: in std_logic;
	    f: out std_logic);
end paw;
architecture patroll of paw is begin 
f <= '1' when (a='0' and b='0' and c='0' and d='0' and e='1') else	
	'1' when (a='0' and b='0' and c='0' and d='1' and e='1') else
	'1' when (a='0' and b='0' and c='1' and d='1' and e='1') else
	'1' when (a='0' and b='1' and c='1' and d='1' and e='1') else
	'1' when (a='1' and b='0' and c='1' and d='1' and e='1') else
	'1' when (a='0' and b='1' and c='0' and d='0' and e='0') else
	'1' when (a='1' and b='0' and c='0' and d='0' and e='0') else
	'1' when (a='1' and b='1' and c='0' and d='0' and e='0') else
	'1' when (a='1' and b='0' and c='1' and d='0' and e='0') else
	'1' when (a='1' and b='1' and c='1' and d='0' and e='1') else
	'0';
end patroll;