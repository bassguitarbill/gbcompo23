SECTION "VBlank Interrupt", ROM0[$40]
	jp VBlankHandler

SECTION "Init", ROM0[$150]
EntryPoint:
	; Shut down audio circuitry
	ld a, 0
	ld [rNR52], a

	; Do not turn the LCD off outside of VBlank
WaitVBlank:
	ld a, [rLY]
	cp 144
	jp c, WaitVBlank

	; Turn the LCD off
	ld a, 0
	ld [rLCDC], a

	; Copy the tile data
	ld de, Tiles
	ld hl, _VRAM9000
	ld bc, TilesEnd - Tiles
CopyTiles:
	ld a, [de]
	ld [hli], a
	inc de
	dec bc
	ld a, b
	or a, c
	jp nz, CopyTiles

	; Copy the tilemap
	ld de, Tilemap
	ld hl, _SCRN0
	ld bc, TilemapEnd - Tilemap
CopyTilemap:
	ld a, [de]
	ld [hli], a
	inc de
	dec bc
	ld a, b
	or a, c
	jp nz, CopyTilemap

	ld de, Text
	ld hl, _SCRN1
	ld bc, TextEnd - Text
CopyText:
	ld a, [de]
	ld [hli], a
	inc de
	dec bc
	ld a, b
	or a, c
	jp nz, CopyText

	ld a, 30
	ld [rWX], a
	ld a, 115
	ld [rWY], a

	; Enable the interrupt handler
	ld a, $0F
	ld [rIE], a

	; During the first (blank) frame, initialize display registers
	; I guess this is the palette
	ld a, %11100100
	ld [rBGP], a

	; Turn the LCD on
	ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00
	
	ld [rLCDC], a

Done:	
	ei
	halt
	jr Done

