ASSEMBLER := rgbasm
ASSEMBLER_FLAGS := -L

LINKER := rgblink

FIXER := rgbfix
FIXER_FLAGS := -v -p 0xFF

GRAPHICS := rgbgfx
GRAPHICS_FILES := assets/text.bin

OBJECT_FILE := main.o
SOURCE_FILE := src/main.asm
SOURCE_FILES := src/*.asm
MAP_FILE := main.map
SYM_FILE := main.sym

ROM_NAME := main.gb

EMULATOR := bgb

$(ROM_NAME): $(SOURCE_FILES) $(GRAPHICS_FILES)
	$(ASSEMBLER) $(ASSEMBLER_FLAGS) -o $(OBJECT_FILE) $(SOURCE_FILE)
	$(LINKER) -o $(ROM_NAME) $(OBJECT_FILE)
	$(FIXER) $(FIXER_FLAGS) $(ROM_NAME)

assets/%.bin: assets/%.png
	$(GRAPHICS) $< -o $@

clean:
	rm -f *.o
	rm -f *.gb
	rm -f *.sym
	rm -f *.map
	rm -f assets/*.bin

map: $(ROM_NAME)
	$(LINKER) $(OBJECT_FILE) -m $(MAP_FILE)

sym: $(OBJECT_FILE)
	$(LINKER) -n $(SYM_FILE) $(OBJECT_FILE)

run: $(ROM_NAME)
	$(EMULATOR) $(ROM_NAME)
