//-----------------------------------------------------//
//- Advanced Digital IC Design                        -//
//-                                                   -//
//- Exercise: PLL Controller                          -//
//-                                                   -//
//- RESET = 1 RESET                                   -//
//-----------------------------------------------------//

`timescale 1ns/1ps

module CONTROLLER(RESET, PHASE_CLK, P_UP, P_DOWN,
                  DCO_CODE, FREQ_LOCK, POLARITY);
    input RESET, PHASE_CLK;
    input P_UP, P_DOWN;
    output reg [6:0] DCO_CODE;
    output reg FREQ_LOCK, POLARITY;

    // Write Your PLL Controller Here

    // state control
    // pre_state == 0 -> add state
    // pre_state == 1 -> sub state
    reg start_flag, lock_flag, pre_state;
    parameter code_max = 7'd127, code_min = 7'd0;
    reg [4:0] step;

    // anchor_reg
    reg [6:0] anchor_reg;
    reg [2:0] up_counter, down_counter;

    // output
    reg [6:0] lock_cycle;

    // state control ------------------------------------- //
    // start_flag
    always@(posedge RESET or negedge PHASE_CLK) begin
        if (RESET)
            start_flag <= 1'b0;
        else
            start_flag <= 1'b1;
    end

    // lock_flag
    always@(posedge RESET or negedge PHASE_CLK) begin
        if (RESET)
            lock_flag <= 1'b0;
        else if (FREQ_LOCK && !lock_flag)
            lock_flag <= 1'b1;
    end

    // pre_state
    always@(posedge RESET or negedge PHASE_CLK) begin
        if (RESET)
            pre_state <= 1'b0;
        else if (P_UP == 1'b0)
            pre_state <= 1'b0;
        else if (P_DOWN == 1'b0)
            pre_state <= 1'b1;
    end

    // step
    always@(posedge RESET or negedge PHASE_CLK) begin
        if (RESET)
            step <= 5'd8;
        else if (step > 5'd1 && POLARITY == 1'b1)
            step <= step >> 1;
    end

    // anchor reg ---------------------------------------- //
    // anchor_reg
    always@(posedge RESET or negedge PHASE_CLK) begin
        if (RESET)
            anchor_reg <= 7'd0;
        else if (FREQ_LOCK && !lock_flag)
            anchor_reg <= DCO_CODE;
        else if (up_counter == 3'd4 && P_UP == 1'b0 && pre_state == 1'b0 && anchor_reg < code_max)
            anchor_reg <= anchor_reg + 7'd1;
        else if (down_counter == 3'd4 && P_DOWN == 1'b0 && pre_state == 1'b1 && anchor_reg > code_min)
            anchor_reg <= anchor_reg - 7'd1;
    end

    // up_counter && down_counter
    always@(posedge RESET or negedge PHASE_CLK) begin
        if (RESET) begin
            up_counter <= 3'd0;
            down_counter <= 3'd0;
        end else if (POLARITY) begin
            up_counter <= 3'd0;
            down_counter <= 3'd0;
        end else if (up_counter == 3'd4 || down_counter == 3'd4) begin
            up_counter <= 3'd0;
            down_counter <= 3'd0;
        end else if (P_UP == 1'b0 && FREQ_LOCK)
            up_counter <= up_counter + 3'd1;
        else if (P_DOWN == 1'b0 && FREQ_LOCK)
            down_counter <= down_counter + 3'd1;
    end

    // output ----------------------------------------------- //
    always@(posedge RESET or negedge PHASE_CLK) begin
        if (RESET)
            DCO_CODE <= 7'd64;
        else if (lock_flag && POLARITY)
            DCO_CODE <= anchor_reg;
        else if (P_UP == 1'b0 && P_DOWN == 1'b1) begin
            if (DCO_CODE >= (code_max - step))
                DCO_CODE <= code_max;
            else
                DCO_CODE <= DCO_CODE + step;
        end else if (P_DOWN == 1'b0 && P_UP == 1'b1) begin
            if (DCO_CODE <= (code_min + step))
                DCO_CODE <= code_min;
            else
                DCO_CODE <= DCO_CODE - step;
        end
    end

    // POLARITY
    always@(posedge RESET or negedge PHASE_CLK) begin
        if (RESET)
            POLARITY <= 1'b0;
        else if (start_flag && P_UP == 1'b0 && pre_state == 1'b0)
            POLARITY <= 1'b1;
        else if (start_flag && P_DOWN == 1'b0 && pre_state == 1'b0)
            POLARITY <= 1'b0;
    end

    // FREQ_LOCK
    always@(posedge RESET or negedge PHASE_CLK) begin
        if (RESET)
            FREQ_LOCK <= 1'b0;
        else if (step == 5'd1)
            FREQ_LOCK <= 1'b1;
    end

    // lock_cycle
    always@(posedge RESET or negedge PHASE_CLK) begin
        if (RESET)
            lock_cycle <= 7'd0;
        else if (start_flag && FREQ_LOCK == 1'b0)
            lock_cycle <= lock_cycle + 7'd1;
        else
            lock_cycle <= 7'd0;
    end

endmodule
