//-----------------------------------------------------//
//- Advanced Digital IC Design                        -//
//-                                                   -//
//- Final Project: ADPLL                              -//
//-----------------------------------------------------//
`timescale 1ns/1ps

module TEST(LOCK, OUT_CLK, REF_CLK, RESET, M2, M1, M0);

    input LOCK, OUT_CLK;
    output reg REF_CLK, RESET;
    output reg M2, M1, M0;

    always #40 REF_CLK = ~REF_CLK; // 1MHz

    initial begin
`ifdef FSDB
        $fsdbDumpfile("test_MONITOR.fsdb");
        $fsdbDumpvars;
`endif

        RESET = 1'b1;
        REF_CLK = 1'b0;
        {M2, M1, M0} = 3'd1;
        #20 RESET = 1'b0;
        #2000;

        RESET = 1'b1;
        REF_CLK = 1'b0;
        {M2, M1, M0} = 3'd2;
        #20 RESET = 1'b0;
        #2000;

        RESET = 1'b1;
        REF_CLK = 1'b0;
        {M2, M1, M0} = 3'd3;
        #20 RESET = 1'b0;
        #2000;

        RESET = 1'b1;
        REF_CLK = 1'b0;
        {M2, M1, M0} = 3'd4;
        #20 RESET = 1'b0;
        #2000;

        RESET = 1'b1;
        REF_CLK = 1'b0;
        {M2, M1, M0} = 3'd5;
        #20 RESET = 1'b0;
        #2000;

        RESET = 1'b1;
        REF_CLK = 1'b0;
        {M2, M1, M0} = 3'd6;
        #20 RESET = 1'b0;
        #2000;

        RESET = 1'b1;
        REF_CLK = 1'b0;
        {M2, M1, M0} = 3'd7;
        #20 RESET = 1'b0;
        #2000;

        $finish;
    end

endmodule
