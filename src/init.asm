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

	; Copy the tile data
	ld de, ObjectTiles
	ld hl, _VRAM8000
	ld bc, ObjectTilesEnd - ObjectTiles
CopyObjectTiles:
	ld a, [de]
	ld [hli], a
	inc de
	dec bc
	ld a, b
	or a, c
	jp nz, CopyObjectTiles

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

	;; Window setup
	ld a, 30
	ld [rWX], a
	ld a, 115
	ld [rWY], a

	;; Blank out OAM with a DMA
	;; ld a, $A0
	;; ld [rDMA], a

	;; DMAs are wild, use a loop instead
	ld b, $A0
	ld HL, _OAMRAM
	xor a
ClearOAM:	
	ldi [HL], a
	dec b
	jr nz, ClearOAM

	;; clear dot RAM
	ld a, -1
	ld [DOT_ANIMATION_PROGRESS], a
	
	; Enable the interrupt handler
	ld a, $0F
	ld [rIE], a

	; During the first (blank) frame, initialize display registers
	; I guess this is the palette
	ld a, %11100100
	ld [rBGP], a

	; Turn the LCD on
	ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00 | LCDCF_OBJON | LCDCF_OBJ8
	
	ld [rLCDC], a

	xor a
	ld [CURSOR_XPOS], a
	ld [CURSOR_YPOS], a

Done:	
	ei
	halt
	jr Done

