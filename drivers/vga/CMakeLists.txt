add_library(vga_driver STATIC)

target_compile_options(vga_driver PRIVATE -std=gnu99 -ffreestanding -nostdlib -Wall -Wextra -mgeneral-regs-only)

target_sources(vga_driver
    PUBLIC
        FILE_SET HEADERS
        FILES
            vga.h
)

if(FIRMWARE_IS_BIOS)
    target_sources(vga_driver PRIVATE bios/vga.c)
    target_link_libraries(vga_driver PRIVATE bios_interface)
else()
    message("UEFI VGA driver not implemented yet!")
    target_sources(vga_driver PRIVATE bios/vga.c)
    target_link_libraries(vga_driver PRIVATE bios_interface)
endif()