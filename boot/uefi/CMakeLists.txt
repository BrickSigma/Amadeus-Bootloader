add_library(uefi-bootloader MODULE)

target_sources(uefi-bootloader
    PRIVATE
        efi_main.c
)

target_compile_options(uefi-bootloader PRIVATE -ffreestanding)

set(TARGET_NAME "" "Used to rename the built target")

if(${CMAKE_SYSTEM_PROCESSOR} STREQUAL "x86")
    set(EFI_ARCH "ia32")
    set(TARGET_NAME "BOOTIA32")
    set(ENTRY_POINT "_efi_main")
elseif(${CMAKE_SYSTEM_PROCESSOR} STREQUAL "x86_64")
    set(EFI_ARCH "x86_64")
    set(TARGET_NAME "BOOTx64")
    set(ENTRY_POINT "efi_main")
else()
    message(FATAL_ERROR "Unsupported architecture uses for building EFI application: ${CMAKE_SYSTEM_PROCESSOR}")
endif()

target_include_directories(uefi-bootloader 
    PRIVATE
        ${GNU_EFI_PATH}/inc
        ${GNU_EFI_PATH}/inc/protocol
        ${GNU_EFI_PATH}/inc/${EFI_ARCH}
)

target_link_libraries(uefi-bootloader
    PRIVATE
        bootloader
        efi-data
)

target_link_options(uefi-bootloader
    PRIVATE
        -nostdlib 
        -Wl,-dll 
        -shared 
        -Wl,--subsystem,10 
        -e ${ENTRY_POINT}
)

set_target_properties(uefi-bootloader PROPERTIES
    PREFIX ""
    OUTPUT_NAME ${TARGET_NAME}
    SUFFIX ".EFI"
)