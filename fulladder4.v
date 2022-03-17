
module fulladder4(A, B, Cin, S, Cout);

input [3:0] A;
input [3:0] B;
input Cin;
output [3:0] S;
output Cout;

wire n1, n2, n3;

fulladder1 fulladder1_b0(.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(n1));
fulladder1 fulladder1_b1(.A(A[1]), .B(B[1]), .Cin(n1), .S(S[1]), .Cout(n2));                            
fulladder1 fulladder1_b2(.A(A[2]), .B(B[2]), .Cin(n2), .S(S[2]), .Cout(n3));
fulladder1 fulladder1_b3(.A(A[3]), .B(B[3]), .Cin(n3), .S(S[3]), .Cout(Cout));
                         
endmodule