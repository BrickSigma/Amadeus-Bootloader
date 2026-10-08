add_library(efi-data STATIC)

target_sources(efi-data 
    PRIVATE
        data.c
)

target_compile_options(efi-data PRIVATE -ffreestanding)

if(${CMAKE_SYSTEM_PROCESSOR} STREQUAL "x86")
    set(EFI_ARCH "ia32")
elseif(${CMAKE_SYSTEM_PROCESSOR} STREQUAL "x86_64")
    set(EFI_ARCH "x86_64")
else()
    message(FATAL_ERROR "Unsupported architecture uses for building EFI application: ${CMAKE_SYSTEM_PROCESSOR}")
endif()

target_include_directories(efi-data 
    PRIVATE
        ${GNU_EFI_PATH}/inc
        ${GNU_EFI_PATH}/inc/protocol
        ${GNU_EFI_PATH}/inc/${EFI_ARCH}
)