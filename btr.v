module btr (inp, out);

   input [15:0] inp;
   
   output [15:0] out;

   assign out = {
                 inp[0], inp[1], inp[2], inp[3],
                 inp[4], inp[5], inp[6], inp[7],
                 inp[8], inp[9], inp[10], inp[11],
                 inp[12], inp[13], inp[14], inp[15]
                };
   
endmodule
