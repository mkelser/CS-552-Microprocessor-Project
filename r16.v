module r16(Inp, clk, rst, Out);

input [15:0] Inp;
input clk;
input rst;
output [15:0] Out;

dff dff16 [15:0] (.q(Out), .d(Inp), .clk(clk), .rst(rst));

endmodule
