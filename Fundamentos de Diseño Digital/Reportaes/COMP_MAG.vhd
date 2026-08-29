library ieee;
use ieee.std_logic_1164.all;

entity COMPARADOR is port (
    A, B: in std_logic_vector (1 downto 0);
    F: out std_logic_vector(3 downto 0));
end COMPARADOR;

architecture BOOLEANA of COMPARADOR is 
    signal F1, F2, F3: std_logic;
begin

    F1<=(A(1) and (not B(1))) or (A(0) and (not B(0)) and (not B(1))) or (A(1) and A(0) and (not B(0)));
    F2<=((not A(1)) and B(1)) or ((not A(1)) (NOT A(0) AND B0) or ((not A(0)) and  B(1) and B(0));
    F3<=(A(0) xnor B(0)) and (A(1) xnor B(1));
    

end BOOLEANA;

