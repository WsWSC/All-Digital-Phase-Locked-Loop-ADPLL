//-----------------------------------------------------//
//- Advanced Digital IC Design                        -//
//-                                                   -//
//- Final Project: ADPLL                              -//
//-----------------------------------------------------//
`timescale 1ns/1ps

`include "ADPLL.v"
`include "test_MONITOR.v"
// `include "tb_freq_sweep.v"

module TOP;

//ADPLL
// module ADPLL(REF_CLK, M, RESET, OUT_CLK, LOCK);
ADPLL adpll(.REF_CLK(REF_CLK), .M2(M2), .M1(M1), .M0(M0), .RESET(RESET),
            .OUT_CLK(OUT_CLK), .LOCK(LOCK));

//tb_freq_sweep
// module test(LOCK, OUT_CLK, REF_CLK, RESET, M);
TEST test(.LOCK(LOCK), .OUT_CLK(OUT_CLK),
          .REF_CLK(REF_CLK), .RESET(RESET), .M2(M2), .M1(M1), .M0(M0));

endmodule
