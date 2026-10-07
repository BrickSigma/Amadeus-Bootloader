# Amadeus Bootloader
Amadeus is a custom bootloader (currently in development) designed to be compliant with the Multiboot 2 standard and support both BIOS and UEFI PC systems.

## Contents
- [Building and Running](#building-and-running)
- [Project Roadmap](#project-roadmap)
- [Documentation](#documentation)
- [How Amadeus was Started](#how-amadeus-was-started)
- [Resources and References](#resources-and-references)
- [AI Usage Disclaimer](#ai-usage-disclaimer)
- [Final Words](#final-words)

## Building and Running
Before building, you'll need to setup a cross-compiler to build the project. The project uses a **x86_64-elf** toolchain, and I have created a separate repository with a BASH script to build the toolchain automatically, which you can find [here](https://github.com/BrickSigma/SteinerOS-toolchain) and use it to setup the cross-compiler. Once you've compiled the cross-compiler, make sure to add the `opt/cross/bin` folder to your environment PATH.

The project uses [CMake](https://cmake.org) as it's build system over the standard UNIX Makefile used in most OSDev projects. I've setup a CMake presets file ([CMakePresets.json](CMakePresets.json)) to make the build process easier. To build the project, simply run the following in your terminal emulator:

```bash
cmake --preset i686-debug  # or use i686-release for a release build
cmake --build build
```

There is also a `run` target added in the build process to quickly launch the bootloader ISO in QEMU:

```bash
cmake --build build --target run
```

If you need to clean the build folder, simply run:

```bash
cmake --build build --target clean
```

> [!NOTE]  
> **Why use CMake?**  
> This is mostly a personal preference, however I like how CMake builds projects *out-of-source*, meaning the built binaries (like `.o`, `.a`, `.bin` files and more) aren't saved in the source code directories but instead a separate folder, like `build`. This makes it easier to navigate the code base when constantly recompiling the project as I don't have to check if a file is a build artifact or not, and I don't need to constantly run `make clean` to view the source code clearly again. You can read more on the topic of CMake for OSDev on the [OSDev Wiki](https://wiki.osdev.org/CMake_Build_System).

## Project Roadmap
Below is a rough outline of the roadmap I'm following for now:

- [x] Setup a first and second stage bootloader,
- [x] Setup protected mode (GDT, IDT, A20 line, etc...),
- [ ] Create some simple drivers (disk, PIC, VGA, etc...),
- [ ] Build an ELF file parser to load and jump to a kernel image
- [ ] Port the BIOS code to UEFI

## Documentation
The project documentation can be found within the [docs](docs/) folder. It is structured to match the folder layout of the source code, detailing the boot sequence, order of folders a new user can use to navigate the project, and further details about the roadmap and features being worked on.

## How Amadeus was Started
Amadeus was created as part of a larger hobby operating system project I'm working on called [SteinerOS](https://github.com/BrickSigma/SteinerOS). The source code for the bootloader was originally part of SteinerOS's repository, however I've separated the two to make the projects more distinguishable. 

Much like how SteinerOS was named after the popular visual novel and anime series **Steins;Gate**, Amadeus is named after the virtual AI avatar program from the show, while also taking inspiration from the fictional origins of the story of the famous musician and composer *Wolfgang Amadeus Mozart* and his collegue *Antonio Salieri*.

## Resources and References
One of the most important parts about OS Dev is finding the right resources and sites to start out. Obviously there is the [OSDev Wiki](https://wiki.osdev.org) which has a surplus of documentation and tutorials to follow. I've created a list of some of the links I'll be using for this project in case anyone is curious:

- [Babysteps Guide](https://wiki.osdev.org/Babystep1) - this is the starting point for the project, it contains a step by step guide for understanding the basics of a bootloader and building one.
- [IBM's VGA XVG Technical Reference Manual](https://ia801905.us.archive.org/30/items/bitsavers_ibmpccardseferenceManualMay92_1756350/IBM_VGA_XGA_Technical_Reference_Manual_May92.pdf) - to help understand VGA graphics a bit better while developing the graphics driver.
- [Intel 8086 ISA](https://www.eng.auburn.edu/~sylee/ee2220/8086_instruction_set.html) - Full instruction set for the Intel 8086 assembly language.
- [Ralph Brown's interrupt list](https://web.archive.org/web/20260326152440/https://www.ctyme.com/intr/int.htm) - a listing of all available BIOS interrupt functions for several PCs.
- [IBM PS2 and PC BIOS Interface Technical Reference (April 1987)](https://archive.org/details/bitsavers_ibmpcps2PSTechnicalReferenceApr87_5816663/page/n1/mode/2up) - a more detailed guide by IBM on the BIOS functions, which mostly helped with understanding the memory layout of the BIOS video modes.

## AI Usage Disclaimer
> [!IMPORTANT]  
> **ABSOLUTELY NO AI WAS USED TO GENERATE CODE FOR AMADEUS**

While AI has become a major part of programming in the last few years, it removes the essence of programming as a hobby in my opinion. The thrill of writing code, facing a wall of compilation errors and the screen freezing up, reading pages of old manuals, and the overwhelming joy of finally seeing your project boot is something AI can never replace. Therefore this project is strictly against the use of AI assisted tools for code generation: every line of code has been written by a human being behind the keyboard.

There is only **one** exception to the use of AI in Amadeus: as a search engine assistant for locating resources on specific problems or topics that websites like the OSDev Wiki, StackOverFlow, Reddit and Discord forums, cannot find or assist with. This includes searching for the IBM manuals and understanding which sections are relevant or not, breaking down OS concepts from existing textbooks and sources, comparing ways of structuring the project, and any other theory-related research. Beyond acting as a search engine when the resources and sites listed above have been searched exhaustively, no form of AI content or code is present in the code base.

## Final Words
This is one of the most complex and interesting projects I (and probably for anyone who is a computer scientist) have undertaken, and it'll definitely change a lot as I learn more and get more ideas on how to do things correctly through trial and error.

Thanks for reading, I hope you stick around for the journey that lies ahead!

El Psy Kongroo.
