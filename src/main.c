
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
  int x = 0;
  uint64_t y = 20;
  char *ptr = arr;

  for(;;)
  {
      memcpy(arr, "Hello", 5);
      GPIOC_ODR = _setBit(GPIOC_ODR, 13);
      delay(1000000);
      GPIOC_ODR = _clrBit(GPIOC_ODR, 13);
      GPIOC_ODR = _clrBit(GPIOC_ODR, 13);
      delay(1000000);
      x++;
      y+=x;
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