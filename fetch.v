module fetch (clk, rst, halt_df, pcsel_df, pcaddrsel_df, instr_fd, pcinc_fd);

input clk;
input rst;

input halt_df;

input pcsel_df;
input wire [15:0] pcaddrsel_df;

output wire [15:0] instr_fd;

output wire [15:0] pcinc_fd;

wire [15:0] pcinp;
wire [15:0] pcout;

assign pcinp = (pcsel_df == 1'b1) ? pcaddrsel_df : pcinc_fd;

r16 pc0 (.Inp(pcinp), .clk(clk), .rst(rst), .Out(pcout));

fulladder16 fa0 (.A(16'h0002), .B(pcout), .S(pcinc_fd), .Cout());

memory2c im0 (.data_out(instr_fd), .data_in(16'h0000), .addr(pcout), .enable(~halt_df), .wr(1'b0), .createdump(1'b0), .clk(clk), .rst(rst));

endmodule
