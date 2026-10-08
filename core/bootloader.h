#ifndef BOOTLOADER_H
#define BOOTLOADER_H

typedef struct __attribute__((packed)) BootloaderArgs
{
    uint8_t boot_drive;
    uint16_t bytes_per_sector;
} BootloaderArgs;

/**
 * Entrypoint to the bootloader C code
 * 
 * @param args arguments passed by BIOS or UEFI for the bootloader to use, such as disk information and startup settings
 * @param ret pointer to return variable for BIOS and UEFI to use if they need it
 */
void bootloader_main(BootloaderArgs *args, void *ret);

#endif  // BOOTLOAD_H