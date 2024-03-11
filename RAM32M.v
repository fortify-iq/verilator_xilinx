`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// RAM32M primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 Frédéric REQUIN
// License : BSD
//

/* verilator coverage_off */
module RAM32M
#(
    parameter  [63:0] INIT_A           = 64'h0,
    parameter  [63:0] INIT_B           = 64'h0,
    parameter  [63:0] INIT_C           = 64'h0,
    parameter  [63:0] INIT_D           = 64'h0,
    parameter   [0:0] IS_WCLK_INVERTED = 1'b0
)
(
    // Write clock
    input  wire       WCLK,
    // Write enable
    input  wire       WE,
    // Port A
    input  wire [4:0] ADDRA,
    input  wire [1:0] DIA,
`ifdef FAST_IQ
    output wire [1:0] DOA,
`else
    output wire [1:0] DOA /* verilator public_flat_rd */,
`endif
    // Port B
    input  wire [4:0] ADDRB,
    input  wire [1:0] DIB,
`ifdef FAST_IQ
    output wire [1:0] DOB,
`else
    output wire [1:0] DOB /* verilator public_flat_rd */,
`endif
    // Port C
    input  wire [4:0] ADDRC,
    input  wire [1:0] DIC,
`ifdef FAST_IQ
    output wire [1:0] DOC,
`else
    output wire [1:0] DOC /* verilator public_flat_rd */,
`endif
    // Port D
    input  wire [4:0] ADDRD,
    input  wire [1:0] DID,
`ifdef FAST_IQ
    output wire [1:0] DOD
`else
    output wire [1:0] DOD /* verilator_public_flat_rd */
`endif
);
`ifdef SCOPE_IQ
    localparam cell_kind /* verilator public_flat_rd */ = 0;
`endif
    // 64 x 4-bit Select RAM
    reg [63:0] _r_mem_a;
    reg [63:0] _r_mem_b;
    reg [63:0] _r_mem_c;
    reg [63:0] _r_mem_d;

    // Power-up value
    initial begin : INIT_STATE
        _r_mem_a = INIT_A;
        _r_mem_b = INIT_B;
        _r_mem_c = INIT_C;
        _r_mem_d = INIT_D;
    end
    
    // Synchronous memory write
    generate
        if (IS_WCLK_INVERTED) begin : GEN_WCLK_NEG
            always @(negedge WCLK) begin : MEM_WRITE
            
                if (WE) begin
                    _r_mem_a[{ ADDRD, 1'b0 } +: 2] <= DIA;
                    _r_mem_b[{ ADDRD, 1'b0 } +: 2] <= DIB;
                    _r_mem_c[{ ADDRD, 1'b0 } +: 2] <= DIC;
                    _r_mem_d[{ ADDRD, 1'b0 } +: 2] <= DID;
                end
            end
        end
        else begin : GEN_WCLK_POS
            always @(posedge WCLK) begin : MEM_WRITE
            
                if (WE) begin
                    _r_mem_a[{ ADDRD, 1'b0 } +: 2] <= DIA;
                    _r_mem_b[{ ADDRD, 1'b0 } +: 2] <= DIB;
                    _r_mem_c[{ ADDRD, 1'b0 } +: 2] <= DIC;
                    _r_mem_d[{ ADDRD, 1'b0 } +: 2] <= DID;
                end
            end
        end
    endgenerate
    
    // Asynchronous memory read
    assign DOA = _r_mem_a[{ ADDRA, 1'b0 } +: 2];
    assign DOB = _r_mem_b[{ ADDRB, 1'b0 } +: 2];
    assign DOC = _r_mem_c[{ ADDRC, 1'b0 } +: 2];
    assign DOD = _r_mem_d[{ ADDRD, 1'b0 } +: 2];
    
endmodule
/* verilator coverage_on */
