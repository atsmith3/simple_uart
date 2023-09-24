module parity (
  input logic [8:0] data;
  output logic odd_parity;
  output logic even_parity;
);

assign odd_parity = data[8]^(((data[7]^data[6])^(data[5]^data[4]))^((data[3]^data[2])^(data[1]^data[0])));

assign even_parity = ~odd_parity;

endmodule
