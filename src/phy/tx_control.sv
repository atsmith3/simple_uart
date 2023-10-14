module tx_control (
  input logic clk,
  input control_t control,
  input logic reset_n,
  input logic vld,
  output logic rdy,
  output select_t select,
);

typedef enum bit [3:0] {
  HIGH=0;
  LOW,
  DATA0,
  DATA1,
  DATA2,
  DATA3,
  DATA4,
  DATA5,
  DATA6,
  DATA7,
  DATA8,
  PARITY
} select_t;

typedef enum bit [3:0] {
  IDLE=0;
  START,
  D0,
  D1,
  D2,
  D3,
  D4,
  D5,
  D6,
  D7,
  D8,
  PARITY,
  STOP0,
  STOP1
} state, next_state;

/* Next State Logic */
always_comb begin 
  case (state)
    IDLE : begin

    end
    START : begin

    end
    D0 : begin

    end
    D1 : begin

    end
    D2 : begin

    end
    D3 : begin

    end
    D4 : begin

    end
    D5 : begin

    end
    D6 : begin

    end
    D7 : begin

    end
    D8 : begin

    end
    PARITY : begin

    end
    STOP0 : begin

    end
    STOP1 : begin

    end
  endcase
end

/* Output Logic */
always_comb begin 
  rdy = 1'b0;
  select = HIGH;
  case (state)
    IDLE : begin
      rdy = 1'b1;
    end
    START : begin

    end
    D0 : begin

    end
    D1 : begin

    end
    D2 : begin

    end
    D3 : begin

    end
    D4 : begin

    end
    D5 : begin

    end
    D6 : begin

    end
    D7 : begin

    end
    D8 : begin

    end
    PARITY : begin

    end
    STOP0 : begin

    end
    STOP1 : begin

    end
  endcase
end

always @ (posedge clk) begin
  if (~reset_n) begin
    state <= IDLE;
  end
  else begin
    if (baud_clk) begin
      state <= next_state;
    end
    else
      state <= state;
    end
  end
end

endmodule
