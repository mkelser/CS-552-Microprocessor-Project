module cu (
input [15:0] instr_fd,
// outputs to fetch
output reg halt_df,
// outputs to execute
output reg memread_dx,
output reg memwrite_dx,
output reg [1:0] writedatasel_dx,
output reg [1:0] regsrcsel_dx,
output reg [3:0] aluop_dx,
output reg [1:0] alusrcsel_dx,
output reg cin_dx,
output reg inva_dx,
output reg [2:0] setcondsel_dx,
output reg branch_dx,
output reg jump_dx,
output reg immsrcsel_dx,
output reg immaddsel_dx,
output reg zeroextsel,
output reg regwrite,
// error output
output reg err_cu
);

wire [4:0] opcode;
wire [1:0] func;

assign opcode = instr_fd[15:11];
assign func = instr_fd[1:0];

always @(*) begin
   // default output values
   halt_df = 1'b0;
   memread_dx = 1'b0;
   memwrite_dx = 1'b0;   
   writedatasel_dx = 2'b00;
   regsrcsel_dx = 2'b00;
   aluop_dx = 4'b0000;
   alusrcsel_dx = 2'b00;
   cin_dx = 1'b0;
   inva_dx = 1'b0;
   setcondsel_dx = 3'b000;
   branch_dx = 1'b0;
   jump_dx = 1'b0;
   immsrcsel_dx = 1'b0;
   immaddsel_dx = 1'b0;
   regwrite = 1'b0;
   zeroextsel = 1'b0;
   err_cu = 1'b0;
   case(opcode)
      // halt
      5'b00000 : begin
         halt_df = 1'b1;
      end
      // nop
      5'b00001 : begin
      end
      // siic
      5'b00010 : begin
      end
      // nop/rti
      5'b00011 : begin
      end
      // addi
      5'b01000 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b11;
         aluop_dx = 4'b0100;
         alusrcsel_dx = 2'b11;
      end
      // subi
      5'b01001 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b11;
         aluop_dx = 4'b0100;
         alusrcsel_dx = 2'b11;
         inva_dx = 1'b1;
         cin_dx = 1'b1;
      end
      // xori
      5'b01010 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b11;
         aluop_dx = 4'b0110;
         alusrcsel_dx = 2'b11;
         zeroextsel = 1'b1;
      end
      // andni
      5'b01011 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b11;
         aluop_dx = 4'b0111;
         alusrcsel_dx = 2'b11;
         zeroextsel = 1'b1;
      end
      // roli
      5'b10100 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b11;
         aluop_dx = 4'b0000;
         alusrcsel_dx = 2'b11;
      end
      // slli
      5'b10101 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b11;
         aluop_dx = 4'b0001;
         alusrcsel_dx = 2'b11;
      end
      // rori
      5'b10110 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b11;
         aluop_dx = 4'b0010;
         alusrcsel_dx = 2'b11;
      end
      // srli
      5'b10111 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b11;
         aluop_dx = 4'b0011;
         alusrcsel_dx = 2'b11;
      end
      // st
      5'b10000 : begin
         aluop_dx = 4'b0100;
         alusrcsel_dx = 2'b11;
         memwrite_dx = 1'b1;
      end
      // ld
      5'b10001 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b10;
         aluop_dx = 4'b0100;
         alusrcsel_dx = 2'b11;
         memread_dx = 1'b1;
      end
      // stu
      5'b10011 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b11;
         aluop_dx = 4'b0100;
         alusrcsel_dx = 2'b11;
         memwrite_dx = 1'b1;
         regsrcsel_dx = 2'b01;
      end
      // btr
      5'b11001 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b11;
         aluop_dx = 4'b1000;
         alusrcsel_dx = 2'b01;
         regsrcsel_dx = 2'b10;
       end
       // add, sub, xor, andn
       5'b11011 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b11;
         aluop_dx = (func == 2'b00) ? 4'b0100 :
                    (func == 2'b01) ? 4'b0100 :
                    (func == 2'b10) ? 4'b0110 :
                    4'b0111;
         cin_dx = (func == 2'b01) ? 1'b1 : 1'b0;
         inva_dx = (func == 2'b01) ? 1'b1 : 1'b0;
         alusrcsel_dx = 2'b01;
         regsrcsel_dx = 2'b10;
      end
      // rol, sll, ror, srl
      5'b11010 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b11;
         aluop_dx = (func == 2'b00) ? 4'b0000 :
                    (func == 2'b01) ? 4'b0001 :
                    (func == 2'b10) ? 4'b0010 :
                    4'b0011;
         alusrcsel_dx = 2'b01;
         regsrcsel_dx = 2'b10;
      end
      // seq
      5'b11100 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b01;
         aluop_dx = 4'b0100;
         alusrcsel_dx = 2'b01;
         cin_dx = 1'b1;
         inva_dx = 1'b1;
         setcondsel_dx = 3'b010;
         regsrcsel_dx = 2'b10;
      end
      // slt
      5'b11101 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b01;
         aluop_dx = 4'b0100;
         alusrcsel_dx = 2'b01;
         cin_dx = 1'b1;
         inva_dx = 1'b1;
         setcondsel_dx = 3'b011;
         regsrcsel_dx = 2'b10;
      end
      // sle
      5'b11110 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b01;
         aluop_dx = 4'b0100;
         alusrcsel_dx = 2'b01;
         cin_dx = 1'b1;
         inva_dx = 1'b1;
         setcondsel_dx = 3'b001;
         regsrcsel_dx = 2'b10;
      end
      // sco
      5'b11111 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b01;
         aluop_dx = 4'b0100;
         alusrcsel_dx = 2'b01;
         setcondsel_dx = 3'b111;
         regsrcsel_dx = 2'b10;
      end
      // beqz
      5'b01100 : begin
         alusrcsel_dx = 2'b10;
         aluop_dx = 4'b0100;
         setcondsel_dx = 3'b010;
         branch_dx = 1'b1;
         immsrcsel_dx = 1'b1;      
      end
      // bnez
      5'b01101 : begin
         alusrcsel_dx = 2'b10;
         aluop_dx = 4'b0100;
         setcondsel_dx = 3'b000;
         branch_dx = 1'b1;
         immsrcsel_dx = 1'b1;
      end
      // bltz
      5'b01110 : begin
         alusrcsel_dx = 2'b10;
         aluop_dx = 4'b0100;
         inva_dx = 1'b1;
         cin_dx = 1'b1;
         setcondsel_dx = 3'b011;
         branch_dx = 1'b1;
         immsrcsel_dx = 1'b1;
      end
      // bgez
      5'b01111 : begin
         alusrcsel_dx = 2'b10;
         aluop_dx = 4'b0100;
         inva_dx = 1'b1;
         cin_dx = 1'b1;
         setcondsel_dx = 3'b100;
         branch_dx = 1'b1;
         immsrcsel_dx = 1'b1;
      end
      // lbi
      5'b11000 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b11;
         alusrcsel_dx = 2'b00;
         aluop_dx = 4'b1011;
         regsrcsel_dx = 2'b01;
      end
      // slbi
      5'b10010 : begin
         regwrite = 1'b1;
         zeroextsel = 1'b1;
         writedatasel_dx = 2'b11;
         alusrcsel_dx = 2'b00;
         aluop_dx = 4'b1001;
         regsrcsel_dx = 2'b01;
      end
      // j
      5'b00100 : begin
         jump_dx = 1'b1;
      end
      // jal
      5'b00110 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b00;
         regsrcsel_dx = 2'b11;
         jump_dx = 1'b1;
      end
      // jr
      5'b00101 : begin
         jump_dx = 1'b1;
         immsrcsel_dx = 1'b1;
         immaddsel_dx = 1'b1;
      end
      // jalr
      5'b00111 : begin
         regwrite = 1'b1;
         writedatasel_dx = 2'b00;
         jump_dx = 1'b1; 
         regsrcsel_dx = 2'b11;
         immsrcsel_dx = 1'b1;
         immaddsel_dx = 1'b1;
      end
      default : begin
         err_cu = 1'b1;
      end
   endcase
 
end

endmodule
