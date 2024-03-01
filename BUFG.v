`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// BUFG primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 Frédéric REQUIN
// License : BSD
//

/*verilator coverage_off*/
module BUFG
(
    input  I,
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
/*verilator coverage_on*/
