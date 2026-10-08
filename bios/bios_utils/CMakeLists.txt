# Compiler flags for assembly
set(ASFLAGS -m32)

add_library(bios_utils)

target_sources(bios_utils
    PRIVATE
        a20.S
        gdt.S
        nmi.S
        pm_function_caller.S
        print.S
)

# Compiler options
target_compile_options(bios_utils
    PRIVATE
        $<$<COMPILE_LANGUAGE:ASM>: ${ASFLAGS}>
)

target_include_directories(bios_utils
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}
)