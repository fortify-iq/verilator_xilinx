`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// IBUFDS primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 Frédéric REQUIN
// License : BSD
//

/* verilator coverage_off */
module IBUFDS
#(
    parameter CAPACITANCE      = "DONT_CARE",
    parameter DIFF_TERM        = "FALSE",
    parameter DQS_BIAS         = "FALSE",
    parameter IBUF_DELAY_VALUE = "0",
    parameter IBUF_LOW_PWR     = "TRUE",
    parameter IFD_DELAY_VALUE  = "AUTO",
    parameter IOSTANDARD       = "DEFAULT"
)
(
    // Clock input
    input  I,
    input  IB,
    // Clock outputs
`ifdef FAST_IQ
    output O /* verilator clocker */
`else
    output O /* verilator clocker */ /* verilator public_flat_rd */
`endif
);
`ifdef SCOPE_IQ
    localparam cell_kind /* verilator public_flat_rd */ = 1;
`endif

`ifdef FAST_IQ
    reg O_f /* verilator public_flat_rw */ = 1'b0;
    reg O_v /* verilator public_flat_rw */ = 1'b0;
    assign O = O_f ? O_v : I;
`else
    assign O = I;
`endif
    
endmodule
/* verilator coverage_on */
