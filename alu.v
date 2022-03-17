module alu (a, b, cin, op, inva, result, ofl, z, n, cout, err);

   input [15:0] a;
   input [15:0] b;
   input cin;
   input [3:0] op;
   input inva;
   output [15:0] result;
   output ofl;
   output z;
   output n;
   output cout;
   output err;

   // A input after inversion
   wire [15:0] in_a;
   
   wire [15:0] out_logic;
   wire [15:0] out_shift;
   wire [15:0] out_btr;
   wire [15:0] out_slbi;
   wire [15:0] out_lbi;
   
   // sum from the carry-lookahead adder
   wire [15:0] sum;
   
   // shifter module with count from B input
   shifter shifter0 (.In(in_a), .Cnt(b[3:0]), .Op(op[1:0]), .Out(out_shift));

   lu lu0 (.in_a(in_a), .b(b), .cin(cin), .op(op[1:0]), .cout(cout), .sum(sum), .out_logic(out_logic));
   
   btr btr0 (.inp(in_a), .out(out_btr));
   
   assign in_a = inva ? ~a : a;
               
   assign out_slbi = (in_a << 8) | b;
   assign out_lbi = b;
   
   assign result = (op[3:2] == 2'b00) ? out_shift :
                   (op[3:2] == 2'b01) ? out_logic :
                   ((op == 4'b1000) ? out_btr : ((op == 4'b1001) ? out_slbi : out_lbi));
   
   // check for overflow in the signed cases otherwise if Cout is high 
   assign ofl = (op == 3'b100) & (sum[15] != in_a[15]) & (b[15] == in_a[15]);
   
   // check if output is zero by the shifted and logical outputs
   assign z = result == 0;
   assign n = result[15];
   
   assign err = 1'b0;
   
endmodule
