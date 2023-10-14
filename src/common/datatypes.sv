
`ifndef __DATATYPES_SV__
`define __DATATYPES_SV__

/* 11 Bits of Divider */
typedef enum bit [10:0] {
  B_4800=96,
  B_9600=48,
  B_19200=24,
  B_38400=12,
  B_57600=8,
  B_115200=4,
} baud_t;

/* 3 Bits of Data Length Select */
typedef enum bit [2:0] {
  D_5=0,
  D_6,
  D_7,
  D_8,
  D_9,
} data_len_t;

/* 1 bit of Parity Select */
typedef enum bit {
  P_N=0,
  P_Y
} parity_t;

/* 1 bit of Stop Bit Select */
typedef enum bit {
  S_1=0, 
  S_2, 
} stop_t;

/* 16 bits of Control Word */
typedef struct {
  baud_t      baud,
  data_len_t  data_len,
  parity_t    parity,
  stop_t      stop
} control_t;

`endif
