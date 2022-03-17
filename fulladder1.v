
module fulladder1(A, B, Cin, S, Cout);

input A;
input B;
input Cin;
output S;
output Cout;

wire n1, n2, n3, n4, n5, n6;

xor2 xor2_gate1(.in1(A), .in2(B), .out(n1));
xor2 xor2_gate2(.in1(n1), .in2(Cin), .out(S));

nand2 nand2_gate1(.in1(n1), .in2(Cin), .out(n2));
not1 not1_gate1(.in1(n2), .out(n3));

nand2 nand2_gate2(.in1(A), .in2(B), .out(n4));
not1 not1_gate2(.in1(n4), .out(n5));

nor2 nor2_gate1(.in1(n3), .in2(n5), .out(n6));
not1 not1_gate3(.in1(n6), .out(Cout));

endmodule