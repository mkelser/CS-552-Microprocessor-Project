module execute (
 // halt from fetch
input halt_df,
// inputs from decode
input [15:0] pcinc_dx,
input [15:0] instr_dx,
input [15:0] read1data_dx,
input [15:0] read2data_dx,
input [15:0] disp_dx,
input [15:0] imm1_dx,
input [15:0] imm2_dx,
input memread_dx,
input memwrite_dx,
input [1:0] writedatasel_dx,
input [1:0] regsrcsel_dx,
input [3:0] aluop_dx,
input [1:0] alusrcsel_dx,
input cin_dx,
input inva_dx,
input [2:0] setcondsel_dx,
input branch_dx,
input jump_dx,
input immsrcsel_dx,
input immaddsel_dx,
// inputs from memory
input pcsel_mx,
input [15:0] pcaddrsel_mx,
input [2:0] writeregsel_mx,
input [15:0] writedata_mx,
// outputs to decode
output pcsel_xd,
output [15:0] pcaddrsel_xd,
output [2:0] writeregsel_xd,
output [15:0] writedata_xd,
// outputs to memory
output halt_xm,
output [15:0] pcinc_xm,
output [15:0] pcaddrsel_xm,
output [15:0] aluresult_xm,
output z_xm,
output ofl_xm,
output n_xm,
output [2:0] setcondsel_xm,
output cout_xm,
output [15:0] read2data_xm,
output [2:0] writeregsel_xm,
output [1:0] writedatasel_xm,
output memread_xm,
output memwrite_xm,
output branch_xm,
output jump_xm
);

assign writedatasel_xm = writedatasel_dx;
assign branch_xm = branch_dx;
assign jump_xm = jump_dx;
assign memread_xm = memread_dx;
assign memwrite_xm = memwrite_dx;
assign pcinc_xm = pcinc_dx;
assign pcaddrsel_xd = pcaddrsel_mx;
assign writedata_xd = writedata_mx;
assign writeregsel_xd = writeregsel_mx;
assign pcsel_xd = pcsel_mx;
assign read2data_xm = read2data_dx;
assign setcondsel_xm = setcondsel_dx;
assign halt_xm = halt_df;

wire [15:0] immsrc;
wire [15:0] immaddsrc;

wire [15:0] alusrc;

fulladder16 fa0 (.A(immsrc), .B(immaddsrc), .S(pcaddrsel_mx), .Cout());

assign alusrc = (alusrcsel_dx == 2'b00) ? imm2_dx :
(alusrcsel_dx == 2'b01) ? read2data_dx :
(alusrcsel_dx == 2'b10) ? 16'h0000 :
imm1_dx;

alu alu0 (.a(read1data_dx), .b(alusrc), .cin(cin_dx), .op(aluop_dx), .inva(inva_dx), .result(aluresult_xm), .ofl(ofl_xm), .z(z_xm), .n(n_xm), .cout(cout_xm), .err(err_alu));

assign immsrc = immsrcsel_dx ? imm2_dx : disp_dx;
assign immaddsrc = immaddsel_dx ? read1data_dx : pcinc_dx;



assign writeregsel_xm = (regsrcsel_dx == 2'b00) ? instr_dx[7:5] :
                        (regsrcsel_dx == 2'b01) ? instr_dx[10:8] :
                        (regsrcsel_dx == 2'b10) ? instr_dx[4:2] :
                        3'b111;

endmodule
