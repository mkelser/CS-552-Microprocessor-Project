
module cla16 (A, B, Cin, S, Cout);

input [15:0] A;
input [15:0] B;
input Cin;
output [15:0] S;
output Cout;

// carry-bits for the  4-bit carry-lookahead adders
wire C0, C1, C2;

// 4-bit carry lookahead adder modules (carry-bit is rippled)
cla4 cla0 (.A(A[3:0]), .B(B[3:0]), .Cin(Cin), .S(S[3:0]), .Cout(C0));
cla4 cla1 (.A(A[7:4]), .B(B[7:4]), .Cin(C0), .S(S[7:4]), .Cout(C1));
cla4 cla2 (.A(A[11:8]), .B(B[11:8]), .Cin(C1), .S(S[11:8]), .Cout(C2));
cla4 cla3 (.A(A[15:12]), .B(B[15:12]), .Cin(C2), .S(S[15:12]), .Cout(Cout));

endmodule
