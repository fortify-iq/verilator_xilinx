`ifdef verilator3
`else
`timescale 1 ps / 1 ps
`endif
//
// RAM64M8 primitive for Xilinx FPGAs
// Compatible with Verilator tool (www.veripool.org)
// Copyright (c) 2019-2022 Frédéric REQUIN
// License : BSD
//

/* verilator coverage_off */
module RAM64M8
#(
    parameter  [63:0] INIT_A           = 64'h0,
    parameter  [63:0] INIT_B           = 64'h0,
    parameter  [63:0] INIT_C           = 64'h0,
    parameter  [63:0] INIT_D           = 64'h0,
    parameter  [63:0] INIT_E           = 64'h0,
    parameter  [63:0] INIT_F           = 64'h0,
    parameter  [63:0] INIT_G           = 64'h0,
    parameter  [63:0] INIT_H           = 64'h0,
    parameter   [0:0] IS_WCLK_INVERTED = 1'b0
)
(
    // Write clock
    input  wire       WCLK,
    // Write enable
    input  wire       WE,
    // Port A
    input  wire [5:0] ADDRA,
    input  wire       DIA,
`ifdef FAST_IQ
    output wire       DOA,
`else
    output wire       DOA /* verilator_public_flat_rd */,
`endif
    // Port B
    input  wire [5:0] ADDRB,
    input  wire       DIB,
`ifdef FAST_IQ
    output wire       DOB,
`else
    output wire       DOB /* verilator_public_flat_rd */,
`endif
    // Port C
    input  wire [5:0] ADDRC,
    input  wire       DIC,
`ifdef FAST_IQ
    output wire       DOC,
`else
    output wire       DOC /* verilator_public_flat_rd */,
`endif
    // Port D
    input  wire [5:0] ADDRD,
    input  wire       DID,
`ifdef FAST_IQ
    output wire       DOD,
`else
    output wire       DOD /* verilator_public_flat_rd */,
`endif
    // Port E
    input  wire [5:0] ADDRE,
    input  wire       DIE,
`ifdef FAST_IQ
    output wire       DOE,
`else
    output wire       DOE /* verilator_public_flat_rd */,
`endif
    // Port F
    input  wire [5:0] ADDRF,
    input  wire       DIF,
`ifdef FAST_IQ
    output wire       DOF,
`else
    output wire       DOF /* verilator_public_flat_rd */,
`endif
    // Port G
    input  wire [5:0] ADDRG,
    input  wire       DIG,
`ifdef FAST_IQ
    output wire       DOG,
`else
    output wire       DOG /* verilator_public_flat_rd */,
`endif
    // Port H
    input  wire [5:0] ADDRH,
    input  wire       DIH,
`ifdef FAST_IQ
    output wire       DOH
`else
    output wire       DOH /* verilator_public_flat_rd */
`endif
);
`ifdef SCOPE_IQ
    localparam cell_kind /* verilator public_flat_rd */ = 0;
`endif
    // 64 x 8-bit Select RAM
    reg [63:0] _r_mem_a;
    reg [63:0] _r_mem_b;
    reg [63:0] _r_mem_c;
    reg [63:0] _r_mem_d;
    reg [63:0] _r_mem_e;
    reg [63:0] _r_mem_f;
    reg [63:0] _r_mem_g;
    reg [63:0] _r_mem_h;

    // Power-up value
    initial begin : INIT_STATE
        _r_mem_a = INIT_A;
        _r_mem_b = INIT_B;
        _r_mem_c = INIT_C;
        _r_mem_d = INIT_D;
        _r_mem_e = INIT_E;
        _r_mem_f = INIT_F;
        _r_mem_g = INIT_G;
        _r_mem_h = INIT_H;
    end
    
    // Synchronous memory write
    generate
        if (IS_WCLK_INVERTED) begin : GEN_WCLK_NEG
            always @(negedge WCLK) begin : MEM_WRITE
            
                if (WE) begin
                    _r_mem_a[ADDRH] <= DIA;
                    _r_mem_b[ADDRH] <= DIB;
                    _r_mem_c[ADDRH] <= DIC;
                    _r_mem_d[ADDRH] <= DID;
                    _r_mem_e[ADDRH] <= DIE;
                    _r_mem_f[ADDRH] <= DIF;
                    _r_mem_g[ADDRH] <= DIG;
                    _r_mem_h[ADDRH] <= DIH;
                end
            end
        end
        else begin : GEN_WCLK_POS
            always @(posedge WCLK) begin : MEM_WRITE
            
                if (WE) begin
                    _r_mem_a[ADDRH] <= DIA;
                    _r_mem_b[ADDRH] <= DIB;
                    _r_mem_c[ADDRH] <= DIC;
                    _r_mem_d[ADDRH] <= DID;
                    _r_mem_e[ADDRH] <= DIE;
                    _r_mem_f[ADDRH] <= DIF;
                    _r_mem_g[ADDRH] <= DIG;
                    _r_mem_h[ADDRH] <= DIH;
                end
            end
        end
    endgenerate
    
    // Asynchronous memory read
    assign DOA = _r_mem_a[ADDRA];
    assign DOB = _r_mem_b[ADDRB];
    assign DOC = _r_mem_c[ADDRC];
    assign DOD = _r_mem_d[ADDRD];
    assign DOE = _r_mem_e[ADDRE];
    assign DOF = _r_mem_f[ADDRF];
    assign DOG = _r_mem_g[ADDRG];
    assign DOH = _r_mem_h[ADDRH];
    
endmodule
/* verilator coverage_on */
