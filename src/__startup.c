
// #include <main.h>

// __attribute__((naked, noreturn)) void _reset(void) {
//   // memset .bss to zero, and copy .data section to RAM region
//   extern long _sbss, _ebss, _sdata, _edata, _sidata;
//   for (long *src = &_sbss; src < &_ebss; src++) *src = 0;
//   for (long *src = &_sdata, *dst = &_sidata; src < &_edata;) *src++ = *dst++;

//   main();             // Call main()
//   for (;;) (void) 0;  // Infinite loop in the case if main() returns
// }

// extern void _estack(void);  // Defined in link.ld

// // 16 standard and 91 STM32-specific handlers
// __attribute__((section(".vectors"), used)) void (*tab[16 + 91])(void) = {_estack, _reset};


#include <main.h>
#include <string.h>

extern uint32_t _MSP;  // Defined in link.ld

void Reset_Handler(void) {

    extern uint8_t __data_start__, __data_end__, __data_FLASH_end__, __bss_start__, __bss_end__;

    memcpy(&__data_start__, &__data_FLASH_end__, (uint32_t)(&__data_end__ - &__data_start__));

    memset(&__bss_start__, 0, (uint32_t)(&__bss_end__ - &__bss_start__));

    main();
    for(;;);
}

__attribute__((section(".isr_vector"), used)) uint32_t vector_table [] = {
    (uint32_t)&_MSP,
    (uint32_t)&Reset_Handler,
};

