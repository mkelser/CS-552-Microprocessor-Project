module proc (clk, rst, err);

   input clk;
   input rst;
   output err;
   
   // instruction
   wire [15:0] instr_fd, instr_dx, instr_xm, instr_mw;
   
   // pc select for pc incremented or pc address
   wire pcsel_wm, pcsel_mx, pcsel_xd, pcsel_df; 
   // pc incremented
   wire [15:0] pcinc_fd, pcinc_dx, pcinc_xm, pcinc_mw;
   // pc address for jump and branch
   wire [15:0] pcaddrsel_xm, pcaddrsel_df, pcaddrsel_xd, pcaddrsel_mx;
   
   // halt signal
   wire halt_df, halt_dx, halt_xm, halt_mw;
   
   // select for register
   wire [1:0] regsrcsel_fd, regsrcsel_dx, regsrcsel_xm, regsrcsel_mw;
   // register to be written to
   wire [2:0] writeregsel_xm, writeregsel_mw, writeregsel_wm, writeregsel_mx, writeregsel_xd;
   // data to be written in write register
   wire [15:0] writedata_wm, writedata_mx, writedata_xd, writedata_fd;
   // data read from first register
   wire [15:0] read1data_dx, read1data_xm;
   // data read from second register
   wire [15:0] read2data_dx, read2data_xm;
   
   // displacement value
   wire [15:0] disp_dx, disp_xm;
   // first immediate value
   wire [15:0] imm1_dx, imm1_xm;
   // second immediate value
   wire [15:0] imm2_dx, imm2_xm;
 
   // opcode for alu
   wire [3:0] aluop_dx;
   // source for b for alu
   wire [1:0] alusrcsel_dx;
   // carry-in value for alu
   wire cin_dx, cin_xm;
   // invert signal for a
   wire inva_dx, inva_xm;
   // result form alu
   wire [15:0] aluresult_xm, aluresult_mw;
   // overflow signal from alu
   wire ofl_xm, ofl_mw;
   // zero signal from alu
   wire z_xm, z_mw;
   // negative signal from alu
   wire n_xm, n_mw;
   // carry-out signal from alu
   wire cout_xm, cout_mw;
   
   // data select for data to be written
   wire [1:0] writedatasel_dx, writedatasel_xm, writedatasel_mw;
   // memory read enable
   wire memread_dx, memread_xm;
   // memory write enable
   wire memwrite_dx, memwrite_xm;
   
   // data read for memory
   wire [15:0] memreaddata_mw;
   
   // branch signal
   wire branch_dx, branch_xm;
   // jump singal
   wire jump_dx, jump_xm;
   
   // select flag from alu
   wire [2:0] setcondsel_dx, setcondsel_xm;

   // selcect to add pc and immediate
   wire immsrcsel_dx;
   // select to add pc and displacement
   wire immaddsel_dx;

   // condition
   wire setbit_mw;
   
   // error indication for each stage
   wire err_d;
   
   assign err = err_d;
      
   fetch f0 (
    // inputs
    .clk(clk), 
    .rst(rst),
    // inputs from decode
    .halt_df(halt_df),
    .pcsel_df(pcsel_df),
    .pcaddrsel_df(pcaddrsel_df),
    // outputs to decode
    .instr_fd(instr_fd),
    .pcinc_fd(pcinc_fd)
   );
   
   decode d0 (
    // inputs
    .clk(clk), 
    .rst(rst),
    // inputs from fetch
    .instr_fd(instr_fd),
    .pcinc_fd(pcinc_fd),
    // inputs from execute
    .pcsel_xd(pcsel_xd),
    .pcaddrsel_xd(pcaddrsel_xd),
    .writeregsel_xd(writeregsel_xd),
    .writedata_xd(writedata_xd),
    // outputs to fetch
    .halt_df(halt_df),
    .pcsel_df(pcsel_df),
    .pcaddrsel_df(pcaddrsel_df),
    // outputs to execute
    .pcinc_dx(pcinc_dx),
    .instr_dx(instr_dx),
    .read1data_dx(read1data_dx),
    .read2data_dx(read2data_dx),
    .disp_dx(disp_dx),
    .imm1_dx(imm1_dx),
    .imm2_dx(imm2_dx),    
    .memread_dx(memread_dx),
    .memwrite_dx(memwrite_dx),
    .writedatasel_dx(writedatasel_dx),
    .regsrcsel_dx(regsrcsel_dx),
    .aluop_dx(aluop_dx),
    .alusrcsel_dx(alusrcsel_dx),
    .cin_dx(cin_dx),
    .inva_dx(inva_dx),
    .setcondsel_dx(setcondsel_dx),
    .branch_dx(branch_dx),
    .jump_dx(jump_dx),
    .immsrcsel_dx(immsrcsel_dx),
    .immaddsel_dx(immaddsel_dx),
    // error output
    .err_d(err_d)
   );
   
   execute e0 (
    // halt from fetch
    .halt_df(halt_df),
    // inputs from decode
    .pcinc_dx(pcinc_dx),
    .instr_dx(instr_dx),
    .read1data_dx(read1data_dx),
    .read2data_dx(read2data_dx),
    .disp_dx(disp_dx),
    .imm1_dx(imm1_dx),
    .imm2_dx(imm2_dx),
    .memread_dx(memread_dx),
    .memwrite_dx(memwrite_dx),
    .writedatasel_dx(writedatasel_dx),
    .regsrcsel_dx(regsrcsel_dx),
    .aluop_dx(aluop_dx),
    .alusrcsel_dx(alusrcsel_dx),
    .cin_dx(cin_dx),
    .inva_dx(inva_dx),
    .setcondsel_dx(setcondsel_dx),
    .branch_dx(branch_dx),
    .jump_dx(jump_dx),
    .immsrcsel_dx(immsrcsel_dx),
    .immaddsel_dx(immaddsel_dx),
    // inputs from memory
    .pcsel_mx(pcsel_mx),
    .pcaddrsel_mx(pcaddrsel_mx),   
    .writeregsel_mx(writeregsel_mx),
    .writedata_mx(writedata_mx),
    // outputs to decode
    .pcsel_xd(pcsel_xd),
    .pcaddrsel_xd(pcaddrsel_xd),
    .writeregsel_xd(writeregsel_xd),
    .writedata_xd(writedata_xd),
    // outputs to memory
    .halt_xm(halt_xm),
    .pcinc_xm(pcinc_xm),
    .pcaddrsel_xm(pcaddrsel_xm),
    .aluresult_xm(aluresult_xm),
    .z_xm(z_xm),
    .ofl_xm(ofl_xm),
    .n_xm(n_xm),
    .setcondsel_xm(setcondsel_xm),
    .cout_xm(cout_xm),
    .read2data_xm(read2data_xm),
    .writeregsel_xm(writeregsel_xm),
    .writedatasel_xm(writedatasel_xm),
    .memread_xm(memread_xm),
    .memwrite_xm(memwrite_xm),
    .branch_xm(branch_xm),
    .jump_xm(jump_xm)
   );
   
   memory m0 (
    // inputs
    .clk(clk),
    .rst(rst),
    // inputs from execute
    .halt_xm(halt_xm),
    .pcinc_xm(pcinc_xm),
    .pcaddrsel_xm(pcaddrsel_xm),
    .aluresult_xm(aluresult_xm),
    .z_xm(z_xm),
    .ofl_xm(ofl_xm),
    .n_xm(n_xm),
    .cout_xm(cout_xm),
    .setcondsel_xm(setcondsel_xm),
    .read2data_xm(read2data_xm),
    .writeregsel_xm(writeregsel_xm),
    .writeregsel_wm(writeregsel_wm),
    .writedata_wm(writedata_wm),
    .writedatasel_xm(writedatasel_xm),
    .memread_xm(memread_xm),
    .memwrite_xm(memwrite_xm),
    .branch_xm(branch_xm),
    .jump_xm(jump_xm),
    // outputs to write
    .writedatasel_mw(writedatasel_mw),
    .pcinc_mw(pcinc_mw),
    .memreaddata_mw(memreaddata_mw),
    .aluresult_mw(aluresult_mw),
    .writeregsel_mw(writeregsel_mw),
    .setbit_mw(setbit_mw),
    .pcaddrsel_mx(pcaddrsel_mx),
    .pcsel_mx(pcsel_mx),
    .writeregsel_mx(writeregsel_mx),
    .writedata_mx(writedata_mx)
   );
   
   write w0 (
    // inputs from write
    .pcinc_mw(pcinc_mw),
    .writeregsel_mw(writeregsel_mw),
    .writedatasel_mw(writedatasel_mw),
    .memreaddata_mw(memreaddata_mw),
    .aluresult_mw(aluresult_mw),
    .setbit_mw(setbit_mw),
    // outputs to memory
    .writeregsel_wm(writeregsel_wm),
    .writedata_wm(writedata_wm)
   );
    
endmodule