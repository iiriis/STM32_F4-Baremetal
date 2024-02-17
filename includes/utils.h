#define _chkBit(REG, bit) (REG&(1<<bit)) > 0 ? 1 : 0
#define _setBit(REG, bit) (REG|(1<<bit))
#define _invBit(REG, bit) (REG^(1<<bit))
#define _clrBit(REG, bit) (REG&(~(1<<bit)))
#define _bit(bit) (1<<bit)
