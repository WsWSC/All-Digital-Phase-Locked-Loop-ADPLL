//-----------------------------------------------------//
//- Advanced Digital IC Design                        -//
//-                                                   -//
//- PFD Modeling                                      -//
//-                                                   -//
//- RESET_ = 0 reset                                  -//
//-----------------------------------------------------//

`timescale 1ns/1ps

module PFD(RESET_, IN, FB, flagU, flagD, PHASE_CLK);
    input RESET_, IN, FB;
    output flagU, flagD, PHASE_CLK;

    reg RST;
    reg QU, QD;
    reg OUTU, OUTD, tmp_outU, tmp_outD;
    reg PHASE_CLK;
    wire OUTBU, OUTBD;

    // reset
    wire AND1;
    assign AND1 = ~(QU && QD);
    always@(AND1 or RESET_) RST = (AND1 && RESET_);

    // PHASE_CLK
    always@(*) begin
        PHASE_CLK = flagU && flagD;
    end

    // QU & QD
    always@(posedge IN or negedge RST) begin
        if (RST == 1'b0)  QU <= #0.5 1'b0;
        else              QU <= #0.5 1'b1;
    end

    always@(posedge FB or negedge RST) begin
        if (RST == 1'b0)  QD <= #0.5 1'b0;
        else              QD <= #0.5 1'b1;
    end

    // OUTU & OUTD
    always@(QU or QD)  OUTU <= #0.1 ~(QU && !QD);
    always@(QU or QD)  OUTD <= #0.1 ~(!QU && QD);

    // deadzone
    assign #0.018 OUTBU = OUTU;
    assign #0.018 OUTBD = OUTD;

    // flagU & flagD
    always@(posedge IN or negedge OUTBU) begin
        if (OUTBU == 1'b0)  tmp_outU <= #0.5 1'b0;
        else                tmp_outU <= #0.5 1'b1;
    end

    always@(posedge FB or negedge OUTBD) begin
        if (OUTBD == 1'b0)  tmp_outD <= #0.5 1'b0;
        else                tmp_outD <= #0.5 1'b1;
    end

    assign flagU = tmp_outU;
    assign flagD = tmp_outD;

endmodule
