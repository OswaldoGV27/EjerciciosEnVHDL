
--  CYPRESS NOVA XVL Structural Architecture

--  JED2VHD Reverse Assembler - 6.3 IR 35


--    VHDL File: FUSION 2.vhd

--    Date: Tue Nov 07 04:18:14 2023

--  Disassembly from Jedec file for: c22v10

--  Device Ordercode is: PALCE22V10-25PC/PI
library ieee;
use ieee.std_logic_1164.all;

library primitive;
use primitive.primitive.all;


-- Beginning Test Bench Header

ENTITY ctrl7seg IS
    PORT (
	                ctrl :    in std_logic ;
	                   a :    in std_logic ;
	                   b :    in std_logic ;
	                   c :    in std_logic ;
	                   d :    in std_logic ;
	                 seg : inout std_logic_vector (6 downto 0)
    );
END ctrl7seg;

-- End of Test Bench Header

ARCHITECTURE DSMB of ctrl7seg is

	signal jed_node1	: std_logic:='0' ; -- d
	signal jed_node2	: std_logic:='0' ; -- ctrl
	signal jed_node3	: std_logic:='0' ; -- c
	signal jed_node4	: std_logic:='0' ; -- b
	signal jed_node5	: std_logic:='0' ; -- a
	signal jed_node6	: std_logic:='0' ;
	signal jed_node7	: std_logic:='0' ;
	signal jed_node8	: std_logic:='0' ;
	signal jed_node9	: std_logic:='0' ;
	signal jed_node10	: std_logic:='0' ;
	signal jed_node11	: std_logic:='0' ;
	signal jed_node12	: std_logic:='0' ;
	signal jed_node13	: std_logic:='0' ;
	signal jed_node18	: std_logic:='0' ;
	signal jed_node19	: std_logic:='0' ;
	signal jed_node20	: std_logic:='0' ;
	signal jed_node24	: std_logic:='0' ;

	for all: c22v10m use entity primitive.c22v10m (sim);

SIGNAL  one:std_logic:='1';
SIGNAL  zero:std_logic:='0';
SIGNAL  jed_oept_1:std_logic:='0';
--Attribute PIN_NUMBERS of d:SIGNAL is "0001";

SIGNAL  jed_oept_2:std_logic:='0';
--Attribute PIN_NUMBERS of ctrl:SIGNAL is "0002";

SIGNAL  jed_oept_3:std_logic:='0';
--Attribute PIN_NUMBERS of c:SIGNAL is "0003";

SIGNAL  jed_oept_4:std_logic:='0';
--Attribute PIN_NUMBERS of b:SIGNAL is "0004";

SIGNAL  jed_oept_5:std_logic:='0';
--Attribute PIN_NUMBERS of a:SIGNAL is "0005";

SIGNAL  jed_oept_14:std_logic:='0';
SIGNAL  jed_sum_14,jed_fb_14:std_logic:='0';
--Attribute PIN_NUMBERS of seg(5):SIGNAL is "0014";

SIGNAL  jed_oept_15:std_logic:='0';
SIGNAL  jed_sum_15,jed_fb_15:std_logic:='0';
--Attribute PIN_NUMBERS of seg(1):SIGNAL is "0015";

SIGNAL  jed_oept_16:std_logic:='0';
SIGNAL  jed_sum_16,jed_fb_16:std_logic:='0';
--Attribute PIN_NUMBERS of seg(2):SIGNAL is "0016";

SIGNAL  jed_oept_17:std_logic:='0';
SIGNAL  jed_sum_17,jed_fb_17:std_logic:='0';
--Attribute PIN_NUMBERS of seg(6):SIGNAL is "0017";

SIGNAL  jed_oept_21:std_logic:='0';
SIGNAL  jed_sum_21,jed_fb_21:std_logic:='0';
--Attribute PIN_NUMBERS of seg(4):SIGNAL is "0021";

SIGNAL  jed_oept_22:std_logic:='0';
SIGNAL  jed_sum_22,jed_fb_22:std_logic:='0';
--Attribute PIN_NUMBERS of seg(0):SIGNAL is "0022";

SIGNAL  jed_oept_23:std_logic:='0';
SIGNAL  jed_sum_23,jed_fb_23:std_logic:='0';
--Attribute PIN_NUMBERS of seg(3):SIGNAL is "0023";

SIGNAL  jed_oept_25:std_logic:='0';
SIGNAL  jed_node25,jed_sum_25:std_logic:='0';
SIGNAL  jed_oept_26:std_logic:='0';
SIGNAL  jed_node26,jed_sum_26:std_logic:='0';

BEGIN
jed_node1 <= d ;
jed_node2 <= ctrl ;
jed_node3 <= c ;
jed_node4 <= b ;
jed_node5 <= a ;
Mcell_14:c22v10m
generic map(comb,
   ninv,
   xpin,
   	25 ns, --tpd
	25 ns, --tea
	25 ns, --ter
	15 ns, --tco
	18 ns, --ts
	0 ns, --th
	14 ns, --twh
	14 ns, --twl
	13 ns, --tcf
	25 ns, --taw
	25 ns, --tar
	25 ns, --tap
	25 ns  --tspr
)
port map(
     d=>jed_sum_14,
     clk=>jed_node1,
     oe=>jed_oept_14,
     ss=>jed_sum_26,
     ar=>jed_sum_25,
     y=>seg(5),
     fb=>jed_fb_14
   );

Mcell_15:c22v10m
generic map(comb,
   ninv,
   xpin,
   	25 ns, --tpd
	25 ns, --tea
	25 ns, --ter
	15 ns, --tco
	18 ns, --ts
	0 ns, --th
	14 ns, --twh
	14 ns, --twl
	13 ns, --tcf
	25 ns, --taw
	25 ns, --tar
	25 ns, --tap
	25 ns  --tspr
)
port map(
     d=>jed_sum_15,
     clk=>jed_node1,
     oe=>jed_oept_15,
     ss=>jed_sum_26,
     ar=>jed_sum_25,
     y=>seg(1),
     fb=>jed_fb_15
   );

Mcell_16:c22v10m
generic map(comb,
   ninv,
   xpin,
   	25 ns, --tpd
	25 ns, --tea
	25 ns, --ter
	15 ns, --tco
	18 ns, --ts
	0 ns, --th
	14 ns, --twh
	14 ns, --twl
	13 ns, --tcf
	25 ns, --taw
	25 ns, --tar
	25 ns, --tap
	25 ns  --tspr
)
port map(
     d=>jed_sum_16,
     clk=>jed_node1,
     oe=>jed_oept_16,
     ss=>jed_sum_26,
     ar=>jed_sum_25,
     y=>seg(2),
     fb=>jed_fb_16
   );

Mcell_17:c22v10m
generic map(comb,
   invt,
   xpin,
   	25 ns, --tpd
	25 ns, --tea
	25 ns, --ter
	15 ns, --tco
	18 ns, --ts
	0 ns, --th
	14 ns, --twh
	14 ns, --twl
	13 ns, --tcf
	25 ns, --taw
	25 ns, --tar
	25 ns, --tap
	25 ns  --tspr
)
port map(
     d=>jed_sum_17,
     clk=>jed_node1,
     oe=>jed_oept_17,
     ss=>jed_sum_26,
     ar=>jed_sum_25,
     y=>seg(6),
     fb=>jed_fb_17
   );

Mcell_21:c22v10m
generic map(comb,
   ninv,
   xpin,
   	25 ns, --tpd
	25 ns, --tea
	25 ns, --ter
	15 ns, --tco
	18 ns, --ts
	0 ns, --th
	14 ns, --twh
	14 ns, --twl
	13 ns, --tcf
	25 ns, --taw
	25 ns, --tar
	25 ns, --tap
	25 ns  --tspr
)
port map(
     d=>jed_sum_21,
     clk=>jed_node1,
     oe=>jed_oept_21,
     ss=>jed_sum_26,
     ar=>jed_sum_25,
     y=>seg(4),
     fb=>jed_fb_21
   );

Mcell_22:c22v10m
generic map(comb,
   ninv,
   xpin,
   	25 ns, --tpd
	25 ns, --tea
	25 ns, --ter
	15 ns, --tco
	18 ns, --ts
	0 ns, --th
	14 ns, --twh
	14 ns, --twl
	13 ns, --tcf
	25 ns, --taw
	25 ns, --tar
	25 ns, --tap
	25 ns  --tspr
)
port map(
     d=>jed_sum_22,
     clk=>jed_node1,
     oe=>jed_oept_22,
     ss=>jed_sum_26,
     ar=>jed_sum_25,
     y=>seg(0),
     fb=>jed_fb_22
   );

Mcell_23:c22v10m
generic map(comb,
   invt,
   xpin,
   	25 ns, --tpd
	25 ns, --tea
	25 ns, --ter
	15 ns, --tco
	18 ns, --ts
	0 ns, --th
	14 ns, --twh
	14 ns, --twl
	13 ns, --tcf
	25 ns, --taw
	25 ns, --tar
	25 ns, --tap
	25 ns  --tspr
)
port map(
     d=>jed_sum_23,
     clk=>jed_node1,
     oe=>jed_oept_23,
     ss=>jed_sum_26,
     ar=>jed_sum_25,
     y=>seg(3),
     fb=>jed_fb_23
   );

jed_node25<=jed_sum_25;
jed_node26<=jed_sum_26;
jed_oept_14<=(one);

jed_sum_14<= ((not(jed_node2) and (jed_node3) and (jed_node5)) or
(not(jed_node1) and not(jed_node3) and not(jed_node4)
) or
(not(jed_node3) and (jed_node4) and not(jed_node5)) or
(not(jed_node3) and not(jed_node4) and (jed_node5)) or
(not(jed_node1) and (jed_node4) and not(jed_node5)) or
(not(jed_node1) and not(jed_node2) and not(jed_node3)
));

jed_oept_15<=(one);

jed_sum_15<= (((jed_node1) and not(jed_node2) and not(jed_node3) and (jed_node5)
) or
((jed_node1) and (jed_node3) and not(jed_node5)) or
(not(jed_node1) and not(jed_node3) and not(jed_node5)
) or
(not(jed_node1) and not(jed_node2) and not(jed_node4)
) or
(not(jed_node4) and not(jed_node5)) or
(not(jed_node3) and not(jed_node4)));

jed_oept_16<=(one);

jed_sum_16<= ((not(jed_node2) and not(jed_node4) and (jed_node5)) or
((jed_node1) and not(jed_node2) and not(jed_node3)) or
((jed_node1) and not(jed_node5)) or
((jed_node4) and not(jed_node5)) or
(not(jed_node3) and not(jed_node4)));

jed_oept_17<=(one);

jed_sum_17<= ((not(jed_node1) and not(jed_node2) and not(jed_node3)
 and (jed_node4) and (jed_node5)) or
((jed_node1) and (jed_node3) and (jed_node4) and not(jed_node5)
) or
(not(jed_node3) and not(jed_node4) and not(jed_node5)
));

jed_oept_21<=(one);

jed_sum_21<= ((not(jed_node2) and (jed_node3) and (jed_node5)) or
(not(jed_node2) and (jed_node4) and (jed_node5)) or
(not(jed_node1) and (jed_node3) and not(jed_node5)) or
(not(jed_node1) and not(jed_node3) and not(jed_node4)
));

jed_oept_22<=(one);

jed_sum_22<= (((jed_node1) and (jed_node4) and not(jed_node5)) or
(not(jed_node3) and not(jed_node4) and (jed_node5)) or
(not(jed_node2) and (jed_node3) and (jed_node4)) or
(not(jed_node1) and not(jed_node3) and not(jed_node4)
) or
(not(jed_node1) and not(jed_node2) and (jed_node5)) or
((jed_node3) and not(jed_node5)));

jed_oept_23<=(one);

jed_sum_23<= ((not(jed_node1) and (jed_node3) and not(jed_node4) and (jed_node5)
) or
(not(jed_node1) and not(jed_node3) and (jed_node4) and not(jed_node5)
) or
((jed_node1) and (jed_node3) and (jed_node4)) or
((jed_node2) and (jed_node3) and (jed_node5)) or
((jed_node2) and (jed_node4) and (jed_node5)) or
((jed_node1) and not(jed_node3) and not(jed_node4)));

end DSMB;
