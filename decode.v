module decode (
// inputs
input clk,
input rst,
// inputs from fetch
input [15:0] instr_fd,
input [15:0] pcinc_fd,
// inputs from execute
input pcsel_xd,
input [15:0] pcaddrsel_xd,
input [2:0] writeregsel_xd,
input [15:0] writedata_xd,
// outputs to fetch
output halt_df,
output pcsel_df,
output [15:0] pcaddrsel_df,
// outputs to execute
output [15:0] pcinc_dx,
output [15:0] instr_dx,
output [15:0] read1data_dx,
output [15:0] read2data_dx,
output [15:0] disp_dx,
output [15:0] imm1_dx,
output [15:0] imm2_dx,
output memread_dx,
output memwrite_dx,
output [1:0] writedatasel_dx,
output [1:0] regsrcsel_dx,
output [3:0] aluop_dx,
output [1:0] alusrcsel_dx,
output cin_dx,
output inva_dx,
output [2:0] setcondsel_dx,
output branch_dx,
output jump_dx,
output immsrcsel_dx,
output immaddsel_dx,
// error output
output err_d
);

wire regwrite;
wire zeroextsel;

wire err_rf, err_cu;

de de0 (.inp(instr_fd), .disp(disp_dx));

ie ie0 (.inp(instr_fd), .zeroextsel(zeroextsel), .imm1(imm1_dx), .imm2(imm2_dx));

rf rf0 (.read1data(read1data_dx), .read2data(read2data_dx), .err(err_rf), .clk(clk), .rst(rst),
         .read1regsel(instr_fd[10:8]), .read2regsel(instr_fd[7:5]), .writeregsel(writeregsel_xd),
          .writedata(writedata_xd), .write(regwrite));


cu cu0 (.instr_fd(instr_fd), .halt_df(halt_df), .memread_dx(memread_dx), .memwrite_dx(memwrite_dx),
        .writedatasel_dx(writedatasel_dx), .regsrcsel_dx(regsrcsel_dx), .aluop_dx(aluop_dx),
        .alusrcsel_dx(alusrcsel_dx), .cin_dx(cin_dx), .inva_dx(inva_dx), .setcondsel_dx(setcondsel_dx),
        .branch_dx(branch_dx), .jump_dx(jump_dx), .immsrcsel_dx(immsrcsel_dx), .immaddsel_dx(immaddsel_dx),
        .zeroextsel(zeroextsel), .regwrite(regwrite), .err_cu(err_cu));

assign pcinc_dx = pcinc_fd;
assign instr_dx = instr_fd;

assign err_d = err_rf | err_cu;

assign pcaddrsel_df = pcaddrsel_xd;
assign pcsel_df = pcsel_xd;


endmodule
