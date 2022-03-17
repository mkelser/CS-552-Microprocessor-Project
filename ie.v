module ie (inp, zeroextsel, imm1, imm2);

input [15:0] inp;
input zeroextsel;

output [15:0] imm1;
output [15:0] imm2;

assign imm1 = zeroextsel ? {{12{1'b0}}, inp[4:0]} : {{12{inp[4]}}, inp[4:0]};
assign imm2 = zeroextsel ? {{8{1'b0}}, inp[7:0]} : {{8{inp[7]}}, inp[7:0]};

endmodule
