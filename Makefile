programmer=C:/Program\ Files/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin

CC = arm-none-eabi-gcc
CC_CPU = cortex-m4
CC_FLAGS = -Wall -fstack-usage -mthumb -ffunction-sections -fdata-sections -fanalyzer -g
#-fcyclomatic-complexity

LD_FLAGS = -Wl,--gc-sections
LINKER_SCRIPT = ./linker.ld

APP_DIRECTORY = ./build
APP_NAME = firmware.elf


SRC_DIRECTORY = ./src
SRC = $(wildcard $(SRC_DIRECTORY)/*.c)

OBJ_DIRECTORY = ./build/src
OBJ = $(subst $(SRC_DIRECTORY),$(OBJ_DIRECTORY),$(SRC:.c=.o))

INC_DIRECTORY = ./includes
# INCLUDES = $(subst $(SRC_DIRECTORY),$(INC_DIRECTORY),$(SRC:.c=.h))

.PHONY: build
build:$(OBJ)
	@echo Linking... 
	@$(CC) $(LD_FLAGS) $(OBJ) -o $(APP_DIRECTORY)/$(APP_NAME) -Wl,-T$(LINKER_SCRIPT)
	@arm-none-eabi-size $(APP_DIRECTORY)/$(APP_NAME) -A -x

$(OBJ_DIRECTORY)%.o:$(SRC_DIRECTORY)%.c
	$(CC) -mcpu=$(CC_CPU) $(CC_FLAGS) $< -c -o $@ -I$(INC_DIRECTORY)

flash: build
	openocd -f interface/stlink.cfg -f target/stm32f4x.cfg -c "init; reset init; program $(APP_DIRECTORY)/$(APP_NAME); reset; shutdown"

show_flash_info:
	openocd -f interface/stlink.cfg -f target/stm32f4x.cfg -c "init; reset init; flash info 0; reset; shutdown"

erase:
	openocd -f interface/stlink.cfg -f target/stm32f4x.cfg -c "init; reset init; flash info 0; reset; shutdown"

debug:
# Start OpenOCD in the background, redirecting output to null to keep the terminal clean
	@echo "Starting OpenOCD..."
	@openocd -s scripts -f interface/stlink.cfg -f target/stm32f4x.cfg &
    # Give OpenOCD time to start
	@sleep 2
    # Start arm-none-eabi-gdb and connect to OpenOCD
	@echo "Starting GDB..."
	@gdb-multiarch ./build/firmware.elf -ex "target remote localhost:3333" -ex "monitor reset halt" -ex "load" -ex "monitor reset init" -ex "b main" -ex "continue"
	


program: build
	$(programmer)/STM32_Programmer_CLI -c port=USB1 -w firmware.elf 0x08000000
# /cygdrive/c/Program\ Files/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/STM32_Programmer_CLI -c port=USB1 -w firmware.elf 0x08000000

clean:
	@rm -rf $(OBJ_DIRECTORY)/*