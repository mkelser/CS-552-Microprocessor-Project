module de (inp, disp);

input [15:0] inp;

output [15:0] disp;

assign disp = {{5{inp[10]}}, inp[10:0]};

endmodule
