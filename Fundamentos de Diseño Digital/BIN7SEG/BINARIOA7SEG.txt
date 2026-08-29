library ieee;
use ieee.std_logic_1164.all;

entity BIN7SEG is 
port(A, B, C, D: in std_logic;
F1: out std_logic;
F2: out std_logic;
F3: out std_logic;
F4: out std_logic;
F5: out std_logic;
F6: out std_logic;
F7: out std_logic);
end BIN7SEG;

architecture BIN7SEG of BIN7SEG is begin
F1 <=((NOT B) AND (NOT D)) OR (B AND C) OR ((NOT A) AND C) OR ((NOT A) AND B AND D) OR (A AND (NOT B) AND (NOT C)) OR (A AND (NOT C) AND (NOT D));
F2 <= ((NOT B) AND (NOT D)) OR ((NOT B) AND (NOT C)) OR (A AND (NOT C) AND D) OR ((NOT A) AND (NOT C) AND (NOT D)) OR ((NOT A) AND C AND D) OR ((NOT A) AND (NOT B));
F3 <=(A AND (NOT B)) OR ((NOT A) AND B) OR ((NOT C) AND D) OR ((NOT A) AND (NOT C)) OR ((NOT A) AND D);
F4 <=((NOT B) AND (NOT C) AND (NOT D)) OR (A AND B AND (NOT C)) OR (B AND (NOT C) AND D) OR ((NOT A) AND (NOT B) AND C) OR ((NOT B) AND C AND D) OR (B AND C AND (NOT D));
F5 <=((NOT B) AND (NOT D)) OR (A AND B) OR (C AND (NOT D)) OR (A AND C);
F6 <=(A AND (NOT B)) OR (A AND C) OR ((NOT C) AND (NOT D)) OR (B AND (NOT D)) OR (A AND B AND (NOT C));
F7 <=((NOT A) AND B AND (NOT C)) OR (A AND (NOT B)) OR (C AND (NOT D)) OR (A AND D) OR ((NOT B) AND C);
end BIN7SEG;
