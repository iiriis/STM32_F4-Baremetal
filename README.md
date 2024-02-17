# STM32_F4-Baremetal
A basic setup for stm32 baremetal




## Debugging

This section outlines the steps needed to configure a debugging environment in Visual Studio Code that includes both pre-launch and post-launch tasks. This setup is helpful when you need to prepare the environment before debugging (like starting a server or another process) and perform cleanup activities after the debugging session ends.

## Prerequisites

- Visual Studio Code installed on your system.
- C/C++ extension for Visual Studio Code installed.
- OpenOCD installed and accessible from the command line.
- `arm-none-eabi-gdb` or similar installed and configured for cross-compiling and debugging.
- Your project's compiled firmware file, typically with an `.elf` extension, ready for debugging.

## Configuration Steps