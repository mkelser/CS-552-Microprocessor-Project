module cla4 (A, B, Cin, S, Cout);

input [3:0] A;
input [3:0] B;
input Cin;
output [3:0] S;
output Cout;

// 4-bit wire for propagate-bits between A and B
wire [3:0] P;
// 4-bit wire for generate-bits between A and B
wire [3:0] G;
// 4-bit wire for carry-bits between A and B 
wire [3:0] C;

// bitwise OR between A and B to get propagate-bits
assign P = A ^ B;
// bitwise AND between A and B to generate-bits
assign G = A & B;

// carry-bit 0 comes from the input Cin
assign C[0] = Cin;
// calculate the remaining carry-bits with additional gates
assign C[1] = G[0] | (P[0] & C[0]);
assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);

// calculute the sum by XOR between the 4-bit wires for propagate and generate
assign S = P ^ C;

endmodule
