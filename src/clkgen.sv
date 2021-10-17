// Copyright (c) 2012-2021 Andrew Smith
// 
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

`timescale 1ps/1ps

module clockgen (
  input logic src_clk,
  input logic reset_n,
  output logic div_clk
);
  // Counter Values MUST be >= 1
  parameter UP_COUNT=50;
  parameter DOWN_COUNT=50;

  typedef enum logic {
    UP,
    DOWN
  } state_t;

  state_t state, next_state;
  reg [8:0] count;
  logic [8:0] n_count;

  // Output Logic
  always_comb begin
    div_clk = 1'b0;
    if ( state == UP ) begin 
      div_clk = 1'b1;
    end
    else begin
      div_clk = 1'b0;
    end
  end

  // Next State Logic
  always_comb begin
    n_count = count;
    next_state = state;
    if ( state == UP ) begin
      /* verilator lint_off UNSIGNED */
      if ( count < (UP_COUNT-1) ) begin 
      /* verilator lint_on UNSIGNED */
        n_count = count + 1;
        next_state = UP;
      end
      else begin
        n_count = 'b0;
        next_state = DOWN;
      end
    end
    else begin
      /* verilator lint_off UNSIGNED */
      if ( count < (DOWN_COUNT-1) ) begin 
      /* verilator lint_on UNSIGNED */
        n_count = count + 1;
        next_state = DOWN;
      end
      else begin
        n_count = 'b0;
        next_state = UP;
      end
    end
  end

  always_ff @ ((posedge src_clk) or (negedge reset_n)) begin
    if (~reset_n) begin
      state <= DOWN;
      count <= DOWN_COUNT;
    end
    else begin
      state <= next_state;
      count <= n_count;
    end
  end
endmodule
