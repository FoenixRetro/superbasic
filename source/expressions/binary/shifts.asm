; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		shifts.asm
;		Purpose:	Handle binary shift operations
;		Created:	21st September 2022
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code


ShiftLt: ;; [<<]
		plx
SRLoop:	dec 	NSMantissa0+1,x
		bmi 	SRExit
		jsr		NSMShiftLeft
		bra 	SRLoop
SRExit:	rts

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
