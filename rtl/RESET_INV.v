//-----------------------------------------------------//
//- Advanced Digital IC Design                        -//
//-                                                   -//
//- Final Project: ADPLL                              -//
//-----------------------------------------------------//
`timescale 1ns/1ps

module RESET_INV(RESET, RESET_);
    input RESET;
    output reg RESET_;

    always@(*) RESET_ = ~RESET;

endmodule
