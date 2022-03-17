module lu (in_a, b, cin, op, cout, sum, out_logic);

   input [15:0] in_a;
   input [15:0] b;
   input [1:0] op;
   input cin;
   
   output cout;
   output [15:0] sum;
   output [15:0] out_logic;
   
   // carry-lookahead adder module with in_a and In_B inputs
   cla16 cla0 (.A(in_a), .B(b), .Cin(cin), .S(sum), .Cout(cout));

   assign out_logic = (op == 2'b00) ? sum :
                      (op == 2'b01) ? in_a | b :
                      (op == 2'b10) ? in_a ^ b :
                      in_a & (~b);
   
endmodule
