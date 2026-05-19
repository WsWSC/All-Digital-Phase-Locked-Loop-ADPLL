//-----------------------------------------------------//
//- Advanced Digital IC Design                        -//
//-                                                   -//
//- Final Project: ADPLL                              -//
//-----------------------------------------------------//
`timescale 1ns/1ps

`include "ADPLL.v"
`include "test_MONITOR.v"
// `include "tb_freq_sweep.v"

`timescale 1ns/1ps

module TOP;

    wire REF_CLK;
    wire RESET;
    wire M2, M1, M0;
    wire OUT_CLK;
    wire LOCK;

    ADPLL adpll(
        .REF_CLK(REF_CLK),
        .M2(M2),
        .M1(M1),
        .M0(M0),
        .RESET(RESET),
        .OUT_CLK(OUT_CLK),
        .LOCK(LOCK)
    );

    TEST test(
        .LOCK(LOCK),
        .OUT_CLK(OUT_CLK),
        .REF_CLK(REF_CLK),
        .RESET(RESET),
        .M2(M2),
        .M1(M1),
        .M0(M0)
    );

endmodule
