//-----------------------------------------------------//
//- Advanced Digital IC Design                        -//
//- Exercise: Frequency Divider                       -//
//-                                                   -//
//- RESET = 1 RESET                                   -//
//-----------------------------------------------------//

`timescale 1ns/1ps

module FREQ_DIV(RESET, CLK, M2, M1, M0, OUT_CLK);

    input RESET;
    input CLK;
    input M2, M1, M0;
    output reg OUT_CLK;

    reg [2:0] counter;
    reg out_tmp, M1_clk;

    wire [2:0] M = {M2, M1, M0};

    // Write Your Programmable Counter-based Frequency Divider Here

    always@(*) begin
        if (RESET)
            M1_clk = 1'b0;
        else
            M1_clk = CLK;
    end

    always@(*) begin
        if (M == 3'd1)
            OUT_CLK = M1_clk;
        else
            OUT_CLK = out_tmp;
    end

    // counter
    always@(posedge CLK or posedge RESET) begin
        if (RESET) begin
            counter <= 3'd0;
            out_tmp <= 1'b0;
        end else if (M == 3'd0) begin
            counter <= 3'd0;
            out_tmp <= 1'b0;
        end else if (counter == 3'd0) begin
            counter <= M - 3'd1;
            out_tmp <= 1'b1;
        end else begin
            counter <= counter - 3'd1;
            out_tmp <= 1'b0;
        end
    end

endmodule
