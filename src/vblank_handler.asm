SCREEN_HEIGHT EQU 18
SCREEN_WIDTH  EQU 20
	
CONTROLS		EQU _HRAM + 0
LAST_FRAME_CONTROLS	EQU _HRAM + 1
FIRST_PRESSED_CONTROLS	EQU _HRAM + 2

CURSOR_XPOS		EQU _HRAM + 3
CURSOR_YPOS		EQU _HRAM + 4
	
SECTION "VBlank Handler", ROM0[$400]
VBlankHandler:	
	call ReadInput
	call UpdateScreen
	call DrawInput
	reti

ReadInput:
	ld a, P1F_GET_DPAD
	ld [rP1], a
	ld a, [rP1]
	ld a, [rP1]
	ld a, [rP1]
	ld a, [rP1]
	ld a, [rP1]
	and $0F
	swap a
	ld b, a

	ld a, P1F_GET_BTN
	ld [rP1], a
	ld a, [rP1]
	ld a, [rP1]
	ld a, [rP1]
	ld a, [rP1]
	ld a, [rP1]
	and $0F
	add b
	ld b, a

	;; B holds the currently-pressed controls
	;; First overwrite last frame controls with current controls from last frame
	ld a, [CONTROLS]
	ld [LAST_FRAME_CONTROLS], a

	;; A first-pressed control is one where it was not pressed
	;; last frame, but is pressed in the current frame
	;; Buttons are pressed if they are 0, so we want A & ~B
	;; Store last frame in C
	ld c, a

	;; Invert B
	ld a, b
	cpl

	;; Bitwise and ~B with C
	and c
	ld [FIRST_PRESSED_CONTROLS], a

	;; Now just store the regular controls
	ld a, b
	ld [CONTROLS], a
	ret

DrawInput:
	ld a, %11100100
	ld [$FF48], a
	
	ld HL, _OAMRAM

	ld a, [CURSOR_YPOS]
	inc a
	inc a
	sla a
	sla a
	sla a
	ldi [HL], a

	ld a, [CURSOR_XPOS]
	inc a
	sla a
	sla a
	sla a
	ldi [HL], a

	ld a, $00
	ldi [HL], a

	ld a, %00000000
	ldi [HL], a

	ret

UpdateScreen:	
	ld a, [FIRST_PRESSED_CONTROLS]
	bit 7, a
	jr nz, .moveDown
	bit 6, a
	jr nz, .moveUp
	bit 5, a
	jr nz, .moveLeft
	bit 4, a
	jr nz, .moveRight
	jr .doneMoving
	
.moveDown:
	ld a, [CURSOR_YPOS]
	cp SCREEN_HEIGHT - 1
	jr nc, .doneMoving
	inc a
	ld [CURSOR_YPOS], a
	jr .doneMoving

.moveUp:
	ld a, [CURSOR_YPOS]
	cp 0
	jr z, .doneMoving
	dec a
	ld [CURSOR_YPOS], a
	jr .doneMoving

.moveRight:
	ld a, [CURSOR_XPOS]
	cp SCREEN_WIDTH - 1
	jr z, .doneMoving
	inc a
	ld [CURSOR_XPOS], a
	jr .doneMoving

.moveLeft:
	ld a, [CURSOR_XPOS]
	cp 0
	jr z, .doneMoving
	dec a
	ld [CURSOR_XPOS], a
	jr .doneMoving
	
.doneMoving:
	ret
