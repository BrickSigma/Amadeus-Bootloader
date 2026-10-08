.PHONY: all clean run run_disk

BUILD ?= debug

ifeq ($(BUILD), debug)
	FOLDER = build
else
	FOLDER = release
endif

all: amadeus-isodir

# This creates the iso directory used by xorriso to create the file system
amadeus-isodir : efisystem.img bios
	mkdir -p $@
	mv efisystem.img boot.bin second_stage.bin $@

# Target for BIOS systems
bios:
	cmake --preset $@-$(BUILD)
	cmake --build $@-$(FOLDER)
	cp $@-$(FOLDER)/boot/bios/boot/boot.bin ./
	cp $@-$(FOLDER)/boot/bios/stage2/second_stage.bin ./

efisystem.img : uefi-ia-32 uefi-x86_64
	dd if=/dev/zero of=$@ bs=1M count=35
	mkfs.fat -F 32 -s 1 $@
	mmd -i $@ ::/EFI
	mmd -i $@ ::/EFI/BOOT
	mcopy -i $@ BOOTx64.EFI ::/EFI/BOOT
	mcopy -i $@ BOOTIA32.EFI ::/EFI/BOOT

uefi-ia-32:
	cmake --preset $@-$(BUILD)
	cmake --build $@-$(FOLDER)
	cp $@-$(FOLDER)/boot/uefi/BOOTIA32.EFI ./

uefi-x86_64:
	cmake --preset $@-$(BUILD)
	cmake --build $@-$(FOLDER)
	cp $@-$(FOLDER)/boot/uefi/BOOTx64.EFI ./


clean:
	rm -rf amadeus-isodir
	rm -rf bios-$(FOLDER)
	rm -rf uefi-ia-32-$(FOLDER)
	rm -rf uefi-x86_64-$(FOLDER)
