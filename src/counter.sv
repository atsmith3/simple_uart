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
  input logic en,
  input logic clr,
  output logic [WIDTH-1:0] count
);

  reg [WIDTH-1:0] value;

  always_ff @ ((posedge clk) or (negedge reset_n)) begin
    if (~reset_n) begin
      value <= 0;
    end
    else if (clr) begin
      value <= 0;
    end
    else if (en) begin
      value <= value + 1;
    end
    else begin
      value <= value;
    end
  end

  assign count = value;
endmodule
