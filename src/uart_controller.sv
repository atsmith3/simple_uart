`include "datatypes.sv"

module uart_tx_controller (
  input logic clk,
  input logic reset_n,
  input logic rdy,
  input logic val,
  input logic [8:0] data,
  input logic [3:0] baud,
  input logic parity_type,
  output logic parity,
  output logic load_tx_out,
  output logic tx,
  output logic parity_bit_sel
);

  reg [8:0] data_shift_reg;
  reg [3:0] ones_counter_reg;
  reg [8:0] baud_counter;

  enum {
    IDLE = 0,                  // MAR <- PC
    START_LOAD,
    START,
    D0_LOAD,
    D0,
    D1_LOAD,
    D1,
    D2_LOAD,
    D2,
    D3_LOAD,
    D3,
    D4_LOAD,
    D4,
    D5_LOAD,
    D5,
    D6_LOAD,
    D6,
    D7_LOAD,
    D7,
    PARITY_LOAD,
    PARITY,
    END0_LOAD,
    END0,
    END1_LOAD,
    END1
  } state, next_state;


  // Next State Logic
  always_comb begin
    // Defaults
    next_state = IDLE;

    case (state)
      IDLE : begin
        if load

      end
      START_LOAD : begin

      end
      START : begin

      end
      D0_LOAD : begin

      end
      D0 : begin

      end
      D1_LOAD : begin

      end
      D1 : begin

      end
      D2_LOAD : begin

      end
      D2 : begin

      end
      D3_LOAD : begin

      end
      D3 : begin

      end
      D4_LOAD : begin

      end
      D4 : begin

      end
      D5_LOAD : begin

      end
      D5 : begin

      end
      D6_LOAD : begin

      end
      D6 : begin

      end
      D7_LOAD : begin

      end
      D7 : begin

      end
      PARITY_LOAD : begin

      end
      PARITY : begin

      end
      END0_LOAD : begin

      end
      END0 : begin

      end
      END1_LOAD : begin

      end
      END1 : begin

      end
      default:
        next_state = IDLE;
      endcase
  end

  // Output Logic
  always_comb begin
    // Defaults
    load_mar = 1'b0;
    load_mdr = 1'b0;
    load_pc = 1'b0;
    load_ir = 1'b0;
    load_reg = 1'b0;
    pc_mux_sel = 0;
    mdr_mux_sel = 0;
    databus_mux_sel = DATABUS_PC;
    rs1_mux_sel = RS1_OUT;
    rs2_mux_sel = RS2_OUT;
    mem_read = 0;
    mem_write = 0;
    alu_op = ALU_ADD;

    case (state)
      FETCH_0: begin
        load_mar = 1'b1;
        mem_read = 1'b1;
      end
      FETCH_1: begin
      end
      FETCH_2: begin
        load_mdr = 1'b1;
      end
      FETCH_3: begin
        load_ir = 1'b1;
        databus_mux_sel = DATABUS_MDR;
      end
      DECODE: begin

      end
      BRANCH_0 : begin
      end
      BRANCH_T : begin
        load_pc = 1'b1;
        databus_mux_sel = DATABUS_ALU;
        rs1_mux_sel = RS1_PC;
        rs2_mux_sel = RS2_IMM;
      end
      PC_INC : begin
        load_pc = 1'b1;
        databus_mux_sel = DATABUS_ALU;
        rs1_mux_sel = RS1_4;
        rs2_mux_sel = RS2_PC;
      end
      JAL_0 : begin
        load_reg = 1'b1;
        databus_mux_sel = DATABUS_ALU;
        rs1_mux_sel = RS1_4;
        rs2_mux_sel = RS2_PC;
      end
      JAL_1 : begin
        load_pc = 1'b1;
        databus_mux_sel = DATABUS_ALU;
        rs1_mux_sel = RS1_PC;
        rs2_mux_sel = RS2_IMM;
      end
      REG_REG : begin
        databus_mux_sel = DATABUS_ALU;
        load_reg = 1'b1;
        alu_op = {1'b0,funct3};
        if (funct3 == 3'b001 || funct3 == 3'b101 || funct3 == 3'b000) begin
          alu_op = {arithmatic,funct3};
        end
      end
      REG_IMM : begin
        databus_mux_sel = DATABUS_ALU;
        rs2_mux_sel = RS2_IMM;
        load_reg = 1'b1;
        alu_op = {1'b0,funct3};
        if (funct3 == 3'b001 || funct3 == 3'b101) begin
          alu_op = {arithmatic,funct3};
        end
      end
      LUI_0 : begin
        load_reg = 1'b1;
        rs2_mux_sel = RS2_IMM;
        databus_mux_sel = DATABUS_ALU;
        alu_op = ALU_PASS_RS2;
      end
      JALR_0 : begin
        load_reg = 1'b1;
        databus_mux_sel = DATABUS_ALU;
        rs1_mux_sel = RS1_4;
        rs2_mux_sel = RS2_PC;
      end
      JALR_1 : begin
        load_pc = 1'b1;
        rs2_mux_sel = RS2_IMM;
        databus_mux_sel = DATABUS_ALU;
      end
      LD_0 : begin
        load_mar = 1'b1;
        databus_mux_sel = DATABUS_ALU;
        rs2_mux_sel = RS2_IMM;
      end
      LD_1 : begin
        mem_read = 1'b1;
      end
      LD_2 : begin
      end
      LD_3 : begin
        load_mdr = 1'b1;
      end
      LD_4 : begin
        databus_mux_sel = DATABUS_MDR;
        load_reg = 1'b1;
      end
      ST_0 : begin
        load_mar = 1'b1;
        databus_mux_sel = DATABUS_ALU;
        rs2_mux_sel = RS2_IMM;
      end
      ST_1 : begin
        load_mdr = 1'b1;
        databus_mux_sel = DATABUS_ALU;
        mdr_mux_sel = 1'b1;
        alu_op = ALU_PASS_RS2;
      end
      ST_2 : begin
        mem_write = 1'b1;
      end
      ST_3 : begin
      end
      AUIPC_0 : begin
        load_reg = 1'b1;
        rs2_mux_sel = RS2_IMM;
        rs1_mux_sel = RS1_PC;
        databus_mux_sel = DATABUS_ALU;
      end
    endcase
  end
  


endmodule
