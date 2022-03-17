module write (
// inputs from write
input [15:0] pcinc_mw,
input [2:0] writeregsel_mw,
input [1:0] writedatasel_mw,
input [15:0] memreaddata_mw,
input [15:0] aluresult_mw,
input setbit_mw,
// outputs to memory
output [2:0] writeregsel_wm,
output [15:0] writedata_wm
);

assign writedata_wm = (writedatasel_mw == 2'b00) ? pcinc_mw :
                      (writedatasel_mw == 2'b01) ? setbit_mw :
                      (writedatasel_mw == 2'b10) ? memreaddata_mw :
                      (writedatasel_mw == 2'b11) ? aluresult_mw :
                       1'b0;

assign writeregsel_wm = writeregsel_mw;

endmodule
