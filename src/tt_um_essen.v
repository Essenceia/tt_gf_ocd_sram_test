/*
Copyright (c) 2026 Julia Desmazes 

This code was written by a human, authorization is explicitly not 
granted to use it to train any model. 
*/

`default_nettype none

module tt_um_essen #(
	localparam SRAM_LINE_CNT = 64,
	localparam SRAM_ADDR_W = $clog2(SRAM_LINE_CNT),
	localparam SRAM_DATA_W = 8
)(
	input  wire [7:0] ui_in,    
    output wire [7:0] uo_out,   
    input  wire [7:0] uio_in,   
    output wire [7:0] uio_out,  
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

assign uio_out = 8'd0;
assign uio_oe  = 8'd0;

// place sram
reg  [SRAM_ADDR_W-1:0] mem_addr_q; 
reg  [SRAM_DATA_W-1:0] mem_d_q;
wire [SRAM_DATA_W-1:0] mem_q; 
reg  [SRAM_DATA_W-1:0] mem_d1_q;
reg                    wen_q;
reg                    wen_q;


wire   ui_in_unused; 
assign ui_in_unused = ui_in[6];

always @(posedge clk) begin
	if (~rst_n) begin
		mem_addr_q <= {SRAM_ADDR_W{1'b0}};
		mem_d_q    <= {SRAM_DATA_W{1'b0}};
		mem_d1_q   <= {SRAM_DATA_W{1'b0}};
		wen_q      <= 1'b0;  
	end else begin
		mem_addr_q <= ui_in[5:0];
		mem_d_q    <= uio_in;
		mem_d1_q   <= mem_q;
		wen_q      <= ui_in[7];
	end
end
assign uo_out = mem_d1_q;

gf180mcu_ocd_ip_sram__sram64x8m8wm1 m_sram(
	.CLK(clk), 
	.CEN(~ena), // shut down sram in case this is ever included in a shuttle without power gatting
	.GWEN(wen_q),
	.WEN({SRAM_DATA_W{1'b0}}),
	.A(mem_addr_q),
	.D(mem_d_q),
	.Q(mem_q)
);

endmodule
