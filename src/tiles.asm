SECTION "Tile data", ROM0

Tiles:
	incbin "assets/text.bin"
TilesEnd:
ObjectTiles:
	incbin "assets/tiles.bin"
ObjectTilesEnd:	

SECTION "Window Tilemap", ROM0

Text:
	db "Hello, world!"
TextEnd:	

SECTION "Tilemap", ROM0

Tilemap:
	db $7F, $7F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $00, $01, $00, $01, $00, $01, $01, $00, $01, $00, $00, $01, $00, $00, $01, $01, $01, $00, $00, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $00, $01, $00, $01, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $01, $00, $00, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $00, $01, $01, $01, $00, $01, $01, $00, $01, $00, $00, $01, $00, $00, $01, $00, $01, $00, $00, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $00, $01, $00, $01, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $01, $00, $00, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $00, $01, $00, $01, $00, $01, $01, $00, $01, $01, $00, $01, $01, $00, $01, $01, $01, $00, $00, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $00, $01, $00, $01, $00, $01, $01, $01, $00, $01, $01, $00, $00, $01, $00, $00, $01, $01, $00, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $00, $01, $00, $01, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $01, $00, $00, $01, $00, $00, $01, $00, $01, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $00, $01, $01, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $00, $01, $00, $01, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $00, $01, $00, $01, $00, $01, $01, $01, $00, $01, $00, $01, $00, $01, $01, $00, $01, $01, $00, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $00, $00, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,  0,0,0,0,0,0,0,0,0,0,0,0
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,  0,0,0,0,0,0,0,0,0,0,0,0
TilemapEnd:
	
