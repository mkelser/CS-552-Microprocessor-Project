module bit_shifter (In, Cnt, Op, Out);

   input [15:0] In;
   input Cnt;
   input [1:0]  Op;
   output [15:0] Out;
   
   // parameter to be for the number of bits to shift by 
   parameter s;
   // parameter for bit width
   parameter b = 15 - s;
   
   // 00 rol
   // 01 sll
   // 10 ror
   // 11 rll
   
   // if count isn't high don't shift otherwise shift based off opcode
   assign Out = !Cnt ? In : 
                           (Op == 2'b00) ? {In[b:0], In[15:b+1]} : 
                           (Op == 2'b01) ? {In[b:0], {s{1'b0}}} :
                           (Op == 2'b10) ? {In[s+1:0], In[15:s]} :
                           {{s{1'b0}}, In[15:s]};
   
endmodule

