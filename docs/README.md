# Amadeus Documentation
This is the documentation of the source code for the Amadeus Bootloader.

> [!NOTE]  
> I'm still actively working on Amadeus, and the project structure is definitely going to change a lot while working on it. These docs may therefore be inconsistent with the actual code and shouldn't be relied upon until a stable release has been fully developed.

## Contents
- [Boot Sequence](#boot-sequence)
- [Project Structure](#project-structure)

## Structure of the Documentation
Each folder in the project (and their respective subfolders) are mirrored in the `docs/` folder, and each directory has it's own README file describing what part of the bootloader the code within contributes to, how it is structured, compiled, and any other notes of importance.

For example, if you are looking to understand how the VGA driver in the BIOS section of the bootloader works, simply locate the README in the `docs/boot/bios/vga` folder. Each README will also attempt to describe the folder structure of the immediate folders in the directory, for instance the [docs/boot/README.md](boot/README.md) file will explain what each folder in the `boot/` directory is for, and each subfolder will do the same. 

## Boot Sequence
Before diving into the project source code and structure, I'd like to quickly give a run through of how Amadeus boots up a kernel.

The boot sequence starts from the BIOS loading the MBR and ends once the ELF kernel is loaded:
1. BIOS boots MBR containing first stage loader,
2. The first stage loader loads the second stage from disk, which may either be an ISO 9660 filesystem or a GPT/FAT32 file system,
3. The second stage loader enabled protected mode and jumps to C,
4. [**Currently being worked on**] The bootloader searches the file system for the configuration file (similar to GRUB's `grub.cfg` file),
5. The config file is used to locate the kernel and load it up,
6. The ELF headers are parsed, as well as the multiboot header flags, and the kernel segments are placed in RAM,
7. The bootloader fills in the headers and tables required by Multiboot to boot the kernel, such as the memory map or setting the video mode,
8. The bootloader finally jumps to the kernel's entry point.

## Project Structure
The source code for the project is structured as follows:
```
.
├── boot/
├── common/
└── drivers/
```

- `boot/` - contains code related to the bootloader, supporting both BIOS ~~and UEFI~~ (This is yet to be implemented)
- `common/` - contains hardware independent code such as the ELF parser and assembly instruction abstractions for C
- `drivers/` - contains code for the drivers (like VGA, PIC, etc...)