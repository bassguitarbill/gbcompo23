ASSEMBLER := rgbasm
ASSEMBLER_FLAGS := -L

LINKER := rgblink

FIXER := rgbfix
FIXER_FLAGS := -v -p 0xFF

OBJECT_FILES := hello-world.o
SOURCE_FILES := src/hello-world.asm
MAP_FILES := hello-world.map
SYM_FILES := hello-world.sym

ROM_NAME := hello-world.gb

EMULATOR := bgb

build: src/hello-world.asm
	$(ASSEMBLER) $(ASSEMBLER_FLAGS) -o $(OBJECT_FILES) $(SOURCE_FILES)
	$(LINKER) -o $(ROM_NAME) $(OBJECT_FILES)
	$(FIXER) $(FIXER_FLAGS) $(ROM_NAME)

map: $(ROM_NAME)
	$(LINKER) $(OBJECT_FILES) -m $(MAP_FILES)

sym: $(OBJECT_FILES)
	$(LINKER) -n $(SYM_FILES) $(OBJECT_FILES)

run: $(ROM_NAME)
	$(EMULATOR) $(ROM_NAME)
