module memory (
// inputs
input clk,
input rst,
// inputs from execute
input halt_xm,
input [15:0] pcinc_xm,
input [15:0] pcaddrsel_xm,
input [15:0] aluresult_xm,
input z_xm,
input ofl_xm,
input n_xm,
input cout_xm,
input [2:0] setcondsel_xm,
input [15:0] read2data_xm,
input [2:0] writeregsel_xm,
input [1:0] writedatasel_xm,
input memread_xm,
input memwrite_xm,
input branch_xm,
input jump_xm,
// inputs from write
input [2:0] writeregsel_wm,
input [15:0] writedata_wm,
// outpus to write
output [1:0] writedatasel_mw,
output [15:0] pcinc_mw,
output [15:0] memreaddata_mw,
output [15:0] aluresult_mw,
output [2:0] writeregsel_mw,
output setbit_mw,
// outputs to execute
output [15:0] pcaddrsel_mx,
output pcsel_mx,
output [2:0] writeregsel_mx,
output [15:0] writedata_mx
);

wire greaterthan, lessthan, lessthanorequal;

wire enable;

memory2c dm0 (.data_out(memreaddata_mw), .data_in(read2data_xm), .addr(aluresult_xm), .enable(enable),
               .wr(memwrite_xm), .createdump(halt_xm), .clk(clk), .rst(rst));

// outputs to execute
assign writeregsel_mx = writeregsel_wm;
assign writedata_mx = writedata_wm;
assign pcaddrsel_mx = pcaddrsel_xm;

// outputs to write
assign writedatasel_mw = writedatasel_xm;
assign pcinc_mw = pcinc_xm;
assign aluresult_mw = aluresult_xm;
assign writeregsel_mw = writeregsel_xm;

assign greaterthan = n_xm | z_xm;
assign lessthan =  ofl_xm ^ (~n_xm & ~z_xm);
assign lessthanorequal = z_xm | lessthan;

assign setbit_mw = (setcondsel_xm == 3'b000) ? ~z_xm :
                   (setcondsel_xm == 3'b001) ? lessthanorequal :
                   (setcondsel_xm == 3'b010) ? z_xm :
                   (setcondsel_xm == 3'b011) ? lessthan :
                   (setcondsel_xm == 3'b100) ? greaterthan :
                   (setcondsel_xm == 3'b101) ? ofl_xm :
                   (setcondsel_xm == 3'b110) ? ~n_xm :
                   cout_xm;

assign pcsel_mx = (branch_xm & setbit_mw) | jump_xm;

assign enable = ~halt_xm & (memwrite_xm | memread_xm);

endmodule
