add_library(bootloader STATIC)

target_sources(bootloader
    PRIVATE
        bootloader.c
)

# Compiler options
target_compile_options(bootloader PRIVATE -std=gnu99 -ffreestanding -nostdlib -Wall -Wextra -mgeneral-regs-only)

# Linker options
target_link_libraries(bootloader 
    PRIVATE
        interrupts
        bios_interface
        disk_driver
        vga_driver
)