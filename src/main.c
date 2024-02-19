
#include "main.h"
#include "rcc.h"
#include "gpio.h"
#include "utils.h"
#include "string.h"

void delay(uint64_t del);

volatile char arr[5] = {1,2,3,4,5};

int main(void) {

  configureSystemClock();
  GPIO_Init();

  for(;;)
  {
      memcpy(arr, "Hello", 5);
      GPIOC_ODR = _setBit(GPIOC_ODR, 13);
      // *(volatile uint32_t*)(PERI_BB_ADDRESS_FROM_ABS_ADDRESS(GPIOC_BASE_ADDR + 0x14, 13)) = 1; //using bit addressble locations
      delay(1000000);
      GPIOC_ODR = _clrBit(GPIOC_ODR, 13);
      // *(volatile uint32_t*)(PERI_BB_ADDRESS_FROM_ABS_ADDRESS(GPIOC_BASE_ADDR + 0x14, 13)) = 0; //using bit addressble locations
      delay(1000000);
  }

  return 0;
}


void delay(uint64_t del)
{
  while(del)
  {
    asm("nop");
    del--;
  }
}