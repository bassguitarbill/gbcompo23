SECTION "VBlank Handler", ROM0[$400]
VBlankHandler:	
	ld a, [rWX]
	inc a
	jr z, invalid
	cp a, 166
	jr z, invalid
	jr valid
invalid:	
	inc a
valid:	
	ld [rWX], a
	reti
