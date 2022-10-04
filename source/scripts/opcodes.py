# *******************************************************************************************
# *******************************************************************************************
#
#       Name :      opcodes.py
#       Purpose :   Assembler raw data
#       Date :      4th October 2022
#       Author :    Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,re 

opcodes = """
1   ora 1
21  and 1
41  eor 1
61  adc 1
81  sta 1
a1  lda 1
c1  cmp 1
e1  sbc 1
	
02  asl 2       X   X   X       X       X
22  rol 2       X   X   X       X       X
42  lsr 2       X   X   X       X       X
62  ror 2       X   X   X       X       X
82  stx 2       X       X               
a2  ldx 2   X   X       X               
c2  dec 2       X       X       X       X
e2  inc 2       X       X       X       X
60  stz 2       X               X       
20  bit 2       X       X       X       X
80  sty 2       X       X       X       
a0  ldy 2   X   X       X       X       X
c0  cpy 2   X   X       X       X       
e0  cpx 2   X   X       X               
00  tsb 2       X       X               
10  trb 2       X       X               
14  jsr 2               X               
40  jmp 2               X               

10  bpl 3
30  bmi 3
50  bvc 3
70  bvs 3
90  bcc 3
b0  bcs 3
d0  bne 3
f0  beq 3
80  bra 3
		
0   brk 4
08  php 4
18  clc 4
28  plp 4
38  sec 4
40  rti 4
48  pha 4
58  cli 4
5a  phy 4
60  rts 4
68  pla 4
78  sei 4
7a  ply 4
88  dey 4
8A  txa 4
98  tya 4
9A  txs 4
a8  tay 4
AA  tax 4
b8  clv 4
BA  tsx 4
c8  iny 4
CA  dex 4
d8  cld 4
da  phx 4
e8  inx 4
EA  nop 4
f8  sed 4
fa  plx 4   
"""

print(";\n;\t This file is automatically generated.\n;")
for op in [x.strip() for x in opcodes.strip().split("\n") if x.strip() != ""]:
	m = re.match("^([0-9A-Fa-f]+)\\s*([a-z]+)\\s*([1-4])(.*)$",op)
	assert m is not None,"Bad line "+op
	print("Assemble_{0}: ;; [{1}]".format(m.group(2),m.group(2).lower()))
	print("\tjsr\tAssembleGroup{0}".format(m.group(3).strip()))
	print("\t.byte ${0:02x}".format(int(m.group(1),16)))
	if m.group(3) == "2":
		options = m.group(4)+"                                                                     "
		options = options[1:].replace("X","1")
		for i in range(0,8):
			c = i * 4 + 2
			if options[c] == ' ':
				options = options[:c]+'0'+options[c+1:]
		aset = int(options.strip().replace(" ",""),2)
		print("\t.byte ${0:02x}".format(aset))

