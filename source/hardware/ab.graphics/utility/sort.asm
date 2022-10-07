; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		sort.asm
;		Purpose:	Coordinate sorting code
;		Created:	6th October 2022
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

; ************************************************************************************************
;
;							Sort coordinate pairs so Y1 >= Y0
;
; ************************************************************************************************

GXSortY:
		lda 	gxY0 						; if Y0 >= Y1
		cmp 	gxY1
		bcc 	_GXSYSorted
		;
		ldx 	#3 							; swap 3-0
		ldy 	#7 							; with 4-7
_GXSwap1:
		jsr 	GXSwapXY
		dey
		dex
		bpl 	_GXSwap1		
_GXSYSorted:
		rts		

; ************************************************************************************************
;
;								Swap offset X,Y from gxX0
;
; ************************************************************************************************

GXSwapXY:
		lda 	gxX0,x
		pha
		lda 	gxX0,y
		sta 	gxX0,x
		pla
		sta 	gxX0,y
		rts

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