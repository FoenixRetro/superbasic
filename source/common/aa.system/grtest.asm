; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		grtest.asm
;		Purpose:	Graphics test code.
;		Created:	6th October 2022
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code
RunDemos:	


plot:	.macro
		lda 	#((\1)*2)+(((\2) >> 8) & 1)		
		ldx 	#((\2) & $FF)
		ldy 	#(\3)
		jsr 	GraphicDraw
		.endm
		
loop:	
		.plot 	0,1,0
		.plot 	1,1,0
		.plot 	2,$03,0
		.plot 	3,$FF,0
		.plot 	24,130,30
		.plot 	4,'Q',1*8
		.plot 	4,'X',1*8
		.plot 	5,0,1*8
		.plot 	5,1,1*8
		.plot 	5,2,1*8
		.plot 	16,10,10
		.plot 	18,100,100

		.plot 	6,3,1
		.plot 	7,2,0
		rts

demo:	jsr 	Random32Bit 
		inc 	gxEORValue
		lda 	#24*2
		ldx 	RandomSeed+0
		ldy 	RandomSeed+1
		jsr 	GraphicDraw

		bra 	demo


		.send code

; ************************************************************************************************
;
;									Changes and Updates
;
; ************************************************************************************************
;
;		Date			Notes
;		==== 			=====
;
; ************************************************************************************************
