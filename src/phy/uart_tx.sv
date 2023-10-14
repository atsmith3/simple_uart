module uart_tx (
  input logic clk,
  input logic reset_n,
  input logic vld,
  input logic [8:0] data,
  input control_t control,
  output logic rdy,
  output logic tx
);

logic data_clk;
logic tx_out;

reg tx_reg;

tx_control u_control (.clk(clk),
                      .reset_n(reset_n),
                      .vld(vld),
                      .rdy(rdy),
                      .select(select),
                      .control(control));

parity u_parity (.data(data),
                 .odd_parity(parity));

dataout_mux u_dataout_mux (.high(1'b1),
                           .low(1'b0),
                           .data0(data[0]),
                           .data1(data[1]),
                           .data2(data[2]),
                           .data3(data[3]),
                           .data4(data[4]),
                           .data5(data[5]),
                           .data6(data[6]),
                           .data7(data[7]),
                           .data8(data[8]),
                           .parity(parity),
                           .select(select),
                           .out(tx_out));


/* Logic for Buffering the Tx Output */
always @ (posedge clk) begin
  if (~reset_n) begin
    assign tx_reg <= 0
  end
  else
    assign tx_reg <= tx_out;
  end
end

assign tx = tx_reg;

endmodule
