`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// CARRY4 primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 Frédéric REQUIN
// License : BSD
//

/* verilator coverage_off */
module CARRY4
(
    // Carry cascade input
    input  wire       CI,
    // 
    input  wire       CYINIT,
    // Carry MUX data input
    input  wire [3:0] DI,
    // Carry MUX select line
    input  wire [3:0] S,
`ifdef FAST_IQ
    // Carry out of each stage of the chain
    output wire [3:0] CO,
    // Carry chain XOR general data out
    output wire [3:0] O
`else
    output wire [3:0] CO /* verilator public_flat_rd */,
    output wire [3:0] O /* verilator public_flat_rd */
`endif
);
`ifdef SCOPE_IQ
    localparam cell_kind /* verilator public_flat_rd */ = 1;
`endif
    wire _w_CO0 = S[0] ? CI | CYINIT : DI[0];
    wire _w_CO1 = S[1] ?      _w_CO0 : DI[1];
    wire _w_CO2 = S[2] ?      _w_CO1 : DI[2];
    wire _w_CO3 = S[3] ?      _w_CO2 : DI[3];

    assign CO   = { _w_CO3, _w_CO2, _w_CO1, _w_CO0 };

    assign O    =  S ^ { _w_CO2, _w_CO1, _w_CO0, CI | CYINIT };

endmodule
/* verilator coverage_on */
