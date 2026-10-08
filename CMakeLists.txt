cmake_minimum_required(VERSION 3.23)

project(Amadeus 
    VERSION 0.0.2
    DESCRIPTION "A custom Multiboot 2 compliant bootloader for BIOS and UEFI systems"
    HOMEPAGE_URL https://github.com/BrickSigma/Amadeus-Bootloader
    LANGUAGES ASM C
)

enable_language(ASM)

set(GNU_EFI_PATH "~/opt/cross/gnu-efi" CACHE STRING "Location of installed GNU-EFI directory")
option(FIRMWARE_IS_BIOS "Builds the BIOS compatible version of the bootloader" ON)

if(${CMAKE_SYSTEM_PROCESSOR} MATCHES "^x86(_64)?$")
    # If we're building for an x86 compatible PC, add the x86 related libraries
    message("We're building for x86 (or even x86_64): ${CMAKE_SYSTEM_PROCESSOR}")
else()
    message(FATAL_ERROR "Unsupported architecture set for CMAKE_SYSTEM_PROCESSOR(${CMAKE_SYSTEM_PROCESSOR})")
endif()

# Add the architecture folder, which will select libraries based on the value of CMAKE_SYSTEM_PROCESSOR
add_subdirectory(arch)

# Add the bootloader's entry point application
add_subdirectory(boot)

# Add the common libraries folder (for architecture independent items)
add_subdirectory(common)

# Add the actual bootloader folder containing the code for the core of it
add_subdirectory(core)

# Add the drivers folder/libraries
add_subdirectory(drivers)

if (FIRMWARE_IS_BIOS)
    # If we're building for BIOS, add the BIOS folder
    add_subdirectory(bios)
else()
    add_subdirectory(uefi)
endif()

# set(OUTPUT_IMG "${CMAKE_BINARY_DIR}/Amadeus.iso")

# # Copy the bootloader binary file
# add_custom_target(Amadeus ALL
#     COMMAND sh ${CMAKE_SOURCE_DIR}/cdrom.sh ${CMAKE_BINARY_DIR} ${OUTPUT_IMG}
# )

# add_dependencies(Amadeus 
#     CD_Bootloader 
#     SecondStageBootloader
# )

# set_target_properties(Amadeus PROPERTIES
#     ADDITIONAL_CLEAN_FILES "${OUTPUT_IMG};${CMAKE_BINARY_DIR}/isodir"
# )

# # Additional run target to automatically run the OS
# find_program(QEMU_EXECUTABLE qemu-system-i386 REQUIRED)

# add_custom_target(run
#     COMMAND ${QEMU_EXECUTABLE} -cdrom ${OUTPUT_IMG} -d int
#     DEPENDS ${OUTPUT_IMG}
# )

# # Separate run target for running the `.img` file instead of CDROM
# add_custom_target(run_disk
#     COMMAND ${QEMU_EXECUTABLE} -drive format=raw,file=${OUTPUT_IMG} -d int
#     DEPENDS ${OUTPUT_IMG}
# )
