target remote :3333
monitor reset halt
load
b main
monitor reset init
continue

define np
  n
  info locals
end
