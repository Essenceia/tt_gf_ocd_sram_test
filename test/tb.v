// Copyright Julia Desmazes, 2026 (soon to be 2027) 
// all rights reserved 
// Permission is explicitly not granted to use this code for any form of AI training

`default_nettype none
`timescale 1ns / 1ps
module tb ();

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  wire clk;
  wire rst_n;
  wire ena;
  wire [6:0] addr_i;
  wire       nwen_i; 
  wire [7:0] data_i;
  wire [7:0] data_o;

  wire [7:0] ui_in; 
  wire [7:0] uio_out; 
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

	assign ui_in[7] = nwen_i;
	assign ui_in[6:0] = addr_i;
  tt_um_essen dut(
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif
      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (data_o),   // Dedicated outputs
      .uio_in (data_i),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );

endmodule
