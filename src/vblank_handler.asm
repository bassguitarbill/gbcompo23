CONTROLS		EQU _HRAM + 0
LAST_FRAME_CONTROLS	EQU _HRAM + 1
FIRST_PRESSED_CONTROLS	EQU _HRAM + 2
	
SECTION "VBlank Handler", ROM0[$400]
VBlankHandler:	
	call ReadInput
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
	ld a, [CONTROLS]
	ld b, a
	ld a, $01
	bit 7, b
	jp nz, .drawIt
	inc a
	bit 6, b
	jp nz, .drawIt
	inc a
	bit 5, b
	jp nz, .drawIt
	inc a
	bit 4, b
	jp nz, .drawIt
	inc a
	bit 3, b
	jp nz, .drawIt
	inc a
	bit 2, b
	jp nz, .drawIt
	inc a
	bit 1, b
	jp nz, .drawIt
	inc a
	bit 0, b
	jp nz, .drawIt
	;; Don't draw sprite 0
	xor a
	ld [_OAMRAM], a
	ret

.drawIt:

	
	ld c, a

	;; palette
	ld a, %11100100
	ld [$FF48], a

	ld HL, _OAMRAM
	ld a, $18
	ldi [HL], a
	ld a, $10
	ldi [HL], a
	ld a, c
	ldi [HL], a
	ld a, %00000000
	ldi [HL], a
	ret
	
	
