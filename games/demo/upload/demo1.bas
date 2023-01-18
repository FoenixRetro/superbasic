100 print "Loading demo11.dat"
110 bload "demo11.dat",$030000
120 print "Loaded.
1000 '
1001 ' "Demo"
1002 '
1003 cls:bitmap on:sprites on:bitmap clear 0:spriteCount = 8
1004 dim x(spriteCount),y(spriteCount),xi(spriteCount),yi(spriteCount),img(spriteCount)
1005 for i = 0 to spriteCount-1
1006 x(i) = 16+random(320)
1007 y(i) = 16+random(240)
1008 xi(i) = random(5)+2:yi(i) = 0:img(i) = 1
1009 if i % 2 = 0 then yi(i) = xi(i):xi(i) = 0:img(i) = 3
1010 next
1011 currentSprite = 0
1012 repeat
1013 demo(40)
1014 for d = 33 to 37
1015 demo(d)
1016 next
1017 until false
1018 '
1019 ' "Do demo using op n."
1020 '
1021 proc demo(op)
1022 bitmap clear 0
1023 gfx 32,160,120
1024 t1 = timer() + 70*3
1025 while timer() < t1
1026 gfx 4,random(256),0
1027 gfx op,random(320),random(240)
1028 if event(nextSprite,3)
1029 for i = 0 to spriteCount-1
1030 moveSprite(i)
1031 next
1032 endif
1033 wend
1034 endproc
1035 proc moveSprite(n)
1036 x(n) = x(n)+xi(n)
1037 y(n) = y(n)+yi(n)
1038 if x(n) < 10 | y(n) < 10 | x(n) > 310 | y(n) > 230
1039 xi(n) = -xi(n):yi(n) = -yi(n)
1040 img(i) = img(i) ^ 1
1041 else
1042 sprite n image img(n) to x(n),y(n)
1043 endif
1044 endproc
ÿÿÿÿ

