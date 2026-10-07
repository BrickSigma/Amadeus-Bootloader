# Compiler flags for C
set(CFLAGS -std=gnu99 -ffreestanding -nostdlib -Wall -Wextra -mgeneral-regs-only)

add_library(disk_driver STATIC)

target_sources(disk_driver
    PUBLIC
        FILE_SET HEADERS
        FILES
            disk.h
)

if(FIRMWARE_IS_BIOS)
    target_sources(disk_driver PRIVATE bios/disk.c)
    target_link_libraries(disk_driver PRIVATE bios_interface)
else()
    message(FATAL_ERROR "UEFI disk driver not implemented yet!")
endif()

# Compiler options
target_compile_options(disk_driver
    PRIVATE
        $<$<COMPILE_LANGUAGE:C>: ${CFLAGS}>
)