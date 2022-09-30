; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		let.asm
;		Purpose:	Assignment command
;		Created:	30th September 2022
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************

		.section code

LetCommand: ;; [let]
		ldx 	#0
		lda 	PrecedenceLevel+"*"			; precedence > this
		jsr 	EvaluateExpressionAtPrecedence
		;
		lda 	#"=" 						; check =
		jsr 	CheckNextA
		;
		inx 								; RHS
		jsr 	EvaluateExpression
		dex
		;
		jsr 	AssignVariable
		rts

; ************************************************************************************************
;
;								Assign Stack[X+1] to Stack[X]
;
; ************************************************************************************************

AssignVariable:
		lda 	NSStatus,x 					; check the string/number type bits match
		pha 								; save a copy
		eor 	NSStatus+1,x
		and 	#NSBIsString
		bne 	_ASError
		pla 								; get back
		and 	#NSBIsString 				; check type
		bne 	_ASString
		jmp 	AssignNumber
_ASString:
		jmp 	AssignString		
_ASError:
		jmp 	TypeError		
		
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
