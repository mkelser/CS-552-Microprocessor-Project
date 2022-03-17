/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module rf (
           // Outputs
           read1data, read2data, err,
           // Inputs
           clk, rst, read1regsel, read2regsel, writeregsel, writedata, write
           );
   input clk, rst;
   input [2:0] read1regsel;
   input [2:0] read2regsel;
   input [2:0] writeregsel;
   input [15:0] writedata;
   input        write;

   output [15:0] read1data;
   output [15:0] read2data;
   output        err;

   wire [15:0] Inp0, Inp1, Inp2, Inp3, Inp4, Inp5, Inp6, Inp7;
   wire [15:0] Out0, Out1, Out2, Out3, Out4, Out5, Out6, Out7;
   
   r16 r0 (.Inp(Inp0), .clk(clk), .rst(rst), .Out(Out0));
   r16 r1 (.Inp(Inp1), .clk(clk), .rst(rst), .Out(Out1));
   r16 r2 (.Inp(Inp2), .clk(clk), .rst(rst), .Out(Out2));
   r16 r3 (.Inp(Inp3), .clk(clk), .rst(rst), .Out(Out3));
   r16 r4 (.Inp(Inp4), .clk(clk), .rst(rst), .Out(Out4));
   r16 r5 (.Inp(Inp5), .clk(clk), .rst(rst), .Out(Out5));
   r16 r6 (.Inp(Inp6), .clk(clk), .rst(rst), .Out(Out6));
   r16 r7 (.Inp(Inp7), .clk(clk), .rst(rst), .Out(Out7));
   
   assign Inp0 = (writeregsel == 3'b000 & write) ? writedata : Out0;
   assign Inp1 = (writeregsel == 3'b001 & write) ? writedata : Out1;
   assign Inp2 = (writeregsel == 3'b010 & write) ? writedata : Out2;
   assign Inp3 = (writeregsel == 3'b011 & write) ? writedata : Out3;
   assign Inp4 = (writeregsel == 3'b100 & write) ? writedata : Out4;
   assign Inp5 = (writeregsel == 3'b101 & write) ? writedata : Out5;
   assign Inp6 = (writeregsel == 3'b110 & write) ? writedata : Out6;
   assign Inp7 = (writeregsel == 3'b111 & write) ? writedata : Out7;
   
   assign read1data = read1regsel == 3'b000 ? Out0 :
                      read1regsel == 3'b001 ? Out1 :
                      read1regsel == 3'b010 ? Out2 :
                      read1regsel == 3'b011 ? Out3 :
                      read1regsel == 3'b100 ? Out4 :
                      read1regsel == 3'b101 ? Out5 :
                      read1regsel == 3'b110 ? Out6 :
                      Out7;
   
   assign read2data = read2regsel == 3'b000 ? Out0 :
                      read2regsel == 3'b001 ? Out1 :
                      read2regsel == 3'b010 ? Out2 :
                      read2regsel == 3'b011 ? Out3 :
                      read2regsel == 3'b100 ? Out4 :
                      read2regsel == 3'b101 ? Out5 :
                      read2regsel == 3'b110 ? Out6 :
                      Out7;
   
   assign err = 1'b0;
   
endmodule
// DUMMY LINE FOR REV CONTROL :1:
