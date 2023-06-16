INCLUDE "lib/hardware.inc"
INCLUDE "src/init.asm"
INCLUDE "src/tiles.asm"

SECTION "Header", ROM0[$100]
	jp EntryPoint

	ds $150 - @, 0 ; Make room for the header

