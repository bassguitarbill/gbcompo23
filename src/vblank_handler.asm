UpOrDown EQU _RAM

SECTION "VBlank Handler", ROM0[$400]
VBlankHandler:	
	call MoveWindow
	call ScrollScreen
	reti

MoveWindow:	
	ld a, [rWX]
	inc a
	jr z, .invalid
	cp a, 166
	jr z, .invalid
	jr .valid
.invalid:	
	inc a
.valid:	
	ld [rWX], a
	ret


ScrollScreen:
	ld a, [rSCY]		
	ld b, a			; b = screen scroll y
	ld a, [$C000]		; a = going up or down
	cp 0
	ld a, b			; a = screen scroll y
	jr z, .goingDown	; going down if "going up" is zero
.goingUp:
	inc a
	ld [rSCY], a
	cp 15
	jr nz, .doneScrolling
	dec a
	ld [rSCY], a
	;; switch directions
	ld a, 0
	ld [UpOrDown], a
	jr .doneScrolling
.goingDown:	
	dec a
	ld [rSCY], a
	cp 0
	jr nz, .doneScrolling
	inc a
	ld [rSCY], a
	;; switch directions
	ld a, 1
	ld [UpOrDown], a
.doneScrolling:	
	ret
