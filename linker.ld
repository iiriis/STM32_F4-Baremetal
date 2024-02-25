ENTRY(Reset_Handler);

MEMORY {
  FLASH(rx)  : ORIGIN = 0x08000000, LENGTH = 256k
  SRAM(rwx) : ORIGIN = 0x20000000, LENGTH = 64k  /* remaining 64k in a separate address space */
}

_MSP = ORIGIN(SRAM) + LENGTH(SRAM) - 1;


SECTIONS
{
  .isr_vector :
  {
    KEEP(*(.isr_vector))
  } > FLASH

  .text :
  {
    *(.text)
  } > FLASH

  .rodata :
  {
    *(.rodata)
  } > FLASH

  .data : 
  {
    __data_start__ = .;
    *(.data)
    __data_end__   = .;
    __data_FLASH_end__ = LOADADDR(.data);
  } > SRAM AT> FLASH

  .bss :
  {
    __bss_start__ = .;
    *(.bss)
    __bss_end__ = .;
  } > SRAM
}