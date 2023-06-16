ASSEMBLER := rgbasm
ASSEMBLER_FLAGS := -L

LINKER := rgblink

FIXER := rgbfix
FIXER_FLAGS := -v -p 0xFF

OBJECT_FILE := main.o
SOURCE_FILE := src/main.asm
MAP_FILE := main.map
SYM_FILE := main.sym

ROM_NAME := main.gb

EMULATOR := bgb

build: $(SOURCE_FILE)
	$(ASSEMBLER) $(ASSEMBLER_FLAGS) -o $(OBJECT_FILE) $(SOURCE_FILE)
	$(LINKER) -o $(ROM_NAME) $(OBJECT_FILE)
	$(FIXER) $(FIXER_FLAGS) $(ROM_NAME)

clean:
	rm -f *.o
	rm -f *.gb
	rm -f *.sym
	rm -f *.map

map: $(ROM_NAME)
	$(LINKER) $(OBJECT_FILE) -m $(MAP_FILE)

sym: $(OBJECT_FILE)
	$(LINKER) -n $(SYM_FILE) $(OBJECT_FILE)

run: $(ROM_NAME)
	$(EMULATOR) $(ROM_NAME)
