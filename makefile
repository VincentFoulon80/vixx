include ../config.mk

ASM_EXE ?= ./acme.exe
ASM_FLAGS ?= -f cbm
EMU_DIR ?= ../emu
EMU_EXE ?= $(EMU_DIR)x16emu.exe
EMU_FLAGS ?= -debug -scale 2 -quality nearest -run -keymap fr -prg

all: build run

build:
	@echo "building"
	$(ASM_EXE) $(ASM_FLAGS) -o vixx.prg main.asm

run:
	@echo "launching emulator"
	@$(EMU_EXE) $(EMU_FLAGS) vixx.prg