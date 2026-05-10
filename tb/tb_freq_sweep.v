//-----------------------------------------------------//
//- Advanced Digital IC Design                        -//
//-                                                   -//
//- Final Project: ADPLL                              -//
//-----------------------------------------------------//
`timescale 1ns/1ps

module tb_freq_sweep(LOCK, OUT_CLK, REF_CLK, RESET, M2, M1, M0);

input        LOCK, OUT_CLK;
output reg   REF_CLK, RESET;
output reg   M2, M1, M0;

parameter MIN_PER = 0.1;
parameter MAX_PER = 10.0;
parameter num_pkts = 50;
parameter num_m = 7;
parameter delta = (MAX_PER - MIN_PER) / (num_pkts);

real period = MAX_PER;
real prev_out_clk_time = 0.0;

integer pkts_checked = 1;

always #(period / 2.0) REF_CLK = ~REF_CLK; // 1MHz

initial begin
    $fsdbDumpfile("tb_freq_sweep.fsdb");
    $fsdbDumpvars;

    REF_CLK = 1'b0;

    #(period / 2.0) RESET = 1'b0;
    #(period / 2.0) RESET = 1'b1;
    #(period / 2.0) RESET = 1'b0;

    {M2, M1, M0} = 3'd1;

    repeat(num_m) begin
        period = MAX_PER;

        repeat(num_pkts) begin
            $display("[NOTE] TIME = %09t Packet %03d: period = %f ns, M = %d", $realtime, pkts_checked, period, {M2, M1, M0});

            #300 pkts_checked = pkts_checked + 1;
            period = period - delta;

            #(period / 2.0) RESET = 1'b1;
            #(period / 2.0) RESET = 1'b0;
        end

        #500 {M2, M1, M0} = {M2, M1, M0} + 1;
    end

    #100 $finish;
end

endmodule
