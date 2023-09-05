module clk_gen (
  input logic reset_n,
  input logic clk_ref,
  output logic periph_clk,
  output logic locked);

`ifdef XILINX_7SERIES
MMCME2_BASE mmcm0 

`endif
`ifdef SIM
assign locked = 1;
assign periph_clk = clk_ref;
`endif

endmodule
