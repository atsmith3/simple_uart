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

module counter #(parameter WIDTH=16) (
  input logic clk,
  input logic reset_n,
  input logic load_shift,
  input logic load_parallel,
  input logic [WIDTH-1:0] parallel_in,
  input logic shift_in, 
  output logic [WIDTH-1:0] parallel_out,
  output logic shift_out
);
  
  reg [WIDTH-1:0] data;

  always_ff @ ((posedge clk) or (negedge reset_n)) begin
    if (~reset_n) begin
      data <= 0;
    end
    else if (load_shift) begin
      data <= {shift_in, data[WIDTH-1:1]};
    end
    else if (load_parallel) begin
      data <= parallel_in;
    end
    else begin
      data <= data;
    end
  end

  assign shift_out = data[0];
  assign parallel_out = data;
endmodule
