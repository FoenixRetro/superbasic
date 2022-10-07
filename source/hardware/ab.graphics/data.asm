; ************************************************************************************************
; ************************************************************************************************
;
;		Name:		data.asm
;		Purpose:	Data use for Graphics
;		Created:	6th October 2022
;		Reviewed: 	No
;		Author:		Paul Robson (paul@robsons.org.uk)
;
; ************************************************************************************************
; ************************************************************************************************
;
;		Page number to map in/out
;
GXMappingPage = 5
;
;		Address of that page
;
GXMappingAddress = ($2000 * GXMappingPage)
;
;		LUT to use for mapping
;
GFXMappingLUT = 0
;
;		LUT Edit slot
;
GFXEditSlot = 8 + GXMappingPage
;
;		Zero Page (reuse BASIC temps)
;
gzTemp0 = zTemp0
gzTemp1 = zTemp1

		.section storage

; ************************************************************************************************
;
;										Graphics data area
;								(maintain order for first section)
;
; ************************************************************************************************
;
;		current X/Y coordinates
;
gxCurrentX:
		.fill 	2		
gxCurrentY:
		.fill 	2		
;
;		last pair of X/Y coordinates
;
gxLastX:
		.fill 	2		
gxLastY:
		.fill 	2		
;
;		Working coordinate sets
;		
gxX1:
		.fill 	2
gxY1:
		.fill 	2
gxX2:
		.fill 	2
gxY2:
		.fill 	2
;
;		Base page of bitmap
;
gxBasePage:
		.fill 	1
;
;		Height of screen
;		
gxHeight:
		.fill 	1
;
;		Colours
;		
gxForeground:
		.fill 	1
gxBackground:
		.fill 	1
;
;		Original LUT and MMU settings
;		
gxOriginalLUTValue:
		.fill 	1
gxOriginalMMUSetting:
		.fill 	1		

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
