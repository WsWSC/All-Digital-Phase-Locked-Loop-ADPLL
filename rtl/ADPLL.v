//-----------------------------------------------------//
//- Advanced Digital IC Design                        -//
//-                                                   -//
//- Final Project: ADPLL                              -//
//-----------------------------------------------------//
`timescale 1ns/1ps
`include "RESET_INV.v"
`include "PFD.v"
`include "CONTROLLER.v"
`include "DCO.v"
`include "FREQ_DIV.v"

`timescale 1ns/1ps

module ADPLL(REF_CLK, M2, M1, M0, RESET, OUT_CLK, LOCK);

    input REF_CLK;
    input M2, M1, M0;
    input RESET;
    output OUT_CLK, LOCK;

    wire [6:0] DCO_CODE;
    wire RESET_;
    wire flagU, flagD;
    wire PHASE_CLK;
    wire OUT_divM;
    wire POLARITY;

    RESET_INV reset_inv(
        .RESET(RESET),
        .RESET_(RESET_)
    );

    PFD pfd(
        .RESET_(RESET_),
        .IN(REF_CLK),
        .FB(OUT_divM),
        .flagU(flagU),
        .flagD(flagD),
        .PHASE_CLK(PHASE_CLK)
    );

    CONTROLLER controller(
        .RESET(RESET),
        .PHASE_CLK(PHASE_CLK),
        .P_UP(flagU),
        .P_DOWN(flagD),
        .DCO_CODE(DCO_CODE),
        .FREQ_LOCK(LOCK),
        .POLARITY(POLARITY)
    );

    DCO dco(
        .RESET_(RESET_),
        .DCO_CODE_0(DCO_CODE[0]),
        .DCO_CODE_1(DCO_CODE[1]),
        .DCO_CODE_2(DCO_CODE[2]),
        .DCO_CODE_3(DCO_CODE[3]),
        .DCO_CODE_4(DCO_CODE[4]),
        .DCO_CODE_5(DCO_CODE[5]),
        .DCO_CODE_6(DCO_CODE[6]),
        .DCO_OUT(OUT_CLK)
    );

    FREQ_DIV freq_div(
        .RESET(RESET),
        .CLK(OUT_CLK),
        .M2(M2),
        .M1(M1),
        .M0(M0),
        .OUT_CLK(OUT_divM)
    );

endmodule
