
module fulladder16 (A, B, S, Cout);

input [15:0] A;
input [15:0] B;
output [15:0] S;
output Cout;

wire n1, n2, n3;

fulladder4 fulladder4_n0(.A(A[3:0]), .B(B[3:0]), .Cin(1'b0), .S(S[3:0]), .Cout(n1));
fulladder4 fulladder4_n1(.A(A[7:4]), .B(B[7:4]), .Cin(n1), .S(S[7:4]), .Cout(n2));
fulladder4 fulladder4_n2(.A(A[11:8]), .B(B[11:8]), .Cin(n2), .S(S[11:8]), .Cout(n3));
fulladder4 fulladder4_n3(.A(A[15:12]), .B(B[15:12]), .Cin(n3), .S(S[15:12]), .Cout(Cout));

endmodule