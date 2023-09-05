module uart_tx (
  input logic clk,
  input logic reset_n,
  input logic vld,
  input logic [8:0] data,
  input logic [8:0] bitmask,
  output logic rdy,
  output logic tx
);

control u_control ();

assign tx = tx_reg;

endmodule
