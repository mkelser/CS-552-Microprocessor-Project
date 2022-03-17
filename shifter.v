module shifter (In, Cnt, Op, Out);
   
   input [15:0] In;
   input [3:0]  Cnt;
   input [1:0]  Op;
   output [15:0] Out;
   
   // the original input shifted 2, 4, and 8 bits
   wire [15:0] S1, S2, S4;
   
   // shifter modules that shifts by opcode a parameterized number of bits
   bit_shifter #(1) shifter1(.In(In), .Cnt(Cnt[0]), .Op(Op), .Out(S1));
   bit_shifter #(2) shifter2(.In(S1), .Cnt(Cnt[1]), .Op(Op), .Out(S2));
   bit_shifter #(4) shifter4(.In(S2), .Cnt(Cnt[2]), .Op(Op), .Out(S4));
   bit_shifter #(8) shifter8(.In(S4), .Cnt(Cnt[3]), .Op(Op), .Out(Out));

endmodule

