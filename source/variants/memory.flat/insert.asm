; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		insert.asm
;		Purpose:	Insert line into code
;		Created:	5th October 2022
;		Reviewed: 	No.
;		Author : 	Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

; ************************************************************************************************
;
;						Insert line in tokenbuffer space at current codePtr point.
;		
; ************************************************************************************************

MemoryInsertLine:
		jsr 	IMemoryFindEnd 				; find end to zTemp2.
		;
		;		zTemp2 is top, codePointer is insert point. Make space for the token buffer
		;	 	data (offset, line#, buffer)
		;
_MDLIFound:
		lda 	tokenOffset 				; insert gap in Y, the offset, e.g. length of the new line
		tay
_MDLIInsert:		
		lda 	(zTemp2) 					; shift one byte up , at least one covers end case.
		sta 	(zTemp2),y 					; work from top down.

		lda 	codePtr 					; done insert point ?
		cmp 	zTemp2
		bne 	_MDLINext
		lda 	codePtr+1
		cmp 	zTemp2+1
		beq 	_MDLIHaveSpace
_MDLINext:
		lda 	zTemp2 						; if no, keep zTemp2 going backwards
		bne 	_MDLINoBorrow
		dec 	zTemp2+1
_MDLINoBorrow:
		dec 	zTemp2
		bra 	_MDLIInsert
		;
		;		Now we have the space, copy the buffer in.
		;
_MDLIHaveSpace:		
		ldy 	tokenOffset 				; bytes to copy
		dey 								; from offset-1 to 0
_MDLICopy:
		lda 	tokenOffset,y
		sta 	(codePtr),y
		dey
		bpl 	_MDLICopy
		rts

; ************************************************************************************************
;
;									Append line at XA
;
;			Can just jump to MDLInsertLine. This allows optimisation of the appending
;
; ************************************************************************************************

MDLAppendLine:
		stx 	zTemp0+1 					; save new line at zTemp0
		sta 	zTemp0

		.set16 	zTemp1,BasicStart 			; check if program empty.
		lda 	(zTemp1)
		bne 	_MDLANoInitialise
		.set16 	AppendPointer,BasicStart 	; reseet the append pointer

_MDLANoInitialise:
		clc
		lda 	AppendPointer 				; copy append pointer to zTemp1 adding the offset as you go
		sta 	zTemp1
		adc 	(zTemp0)
		sta 	AppendPointer
		lda 	AppendPointer+1
		sta 	zTemp1+1
		adc 	#0
		sta 	AppendPointer+1
		;
		ldy 	#0
_MDLACopy:
		lda 	(zTemp0),y 					; copy new line in
		sta 	(zTemp1),y
		iny
		tya	
		cmp 	(zTemp0) 					; done whole line
		bne 	_MDLACopy
			
		lda 	#0 							; end of program.
		sta 	(zTemp1),y

		rts

		.section storage
AppendPointer:
		.fill 	2
		.send storage		

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
	