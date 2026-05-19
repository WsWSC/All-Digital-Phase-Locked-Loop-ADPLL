//-----------------------------------------------------//
//- Advanced Digital IC Design                        -//
//-                                                   -//
//- Demo2: DCO Modeling                               -//
//-                                                   -//
//-----------------------------------------------------//

`timescale 1ns/1ps

module DCO(RESET_, DCO_CODE_0, DCO_CODE_1, DCO_CODE_2, DCO_CODE_3, DCO_CODE_4, DCO_CODE_5, DCO_CODE_6, DCO_OUT);

    input RESET_;   // RESET = 0, DCO is reset, RESET = 1, DCO works
    input DCO_CODE_0, DCO_CODE_1, DCO_CODE_2, DCO_CODE_3, DCO_CODE_4, DCO_CODE_5, DCO_CODE_6;   // DCO control code
    output DCO_OUT;   // DCO output clock

    reg DCO_OUT;
    wire [6:0] DCO_CODE = {DCO_CODE_6, DCO_CODE_5, DCO_CODE_4, DCO_CODE_3, DCO_CODE_2, DCO_CODE_1, DCO_CODE_0};
    real period;

    initial begin
        DCO_OUT <= 1'b0;
        period <= 15.47118;
    end

    always@(DCO_CODE) begin
        case(DCO_CODE)
            7'd0  : period <= 15.47118;    7'd1  : period <= 12.95332;
            7'd2  : period <= 9.625579;    7'd3  : period <= 7.923416;
            7'd4  : period <= 7.094822;    7'd5  : period <= 6.586445;
            7'd6  : period <= 5.397113;    7'd7  : period <= 4.983758;
            7'd8  : period <= 4.490782;    7'd9  : period <= 4.128419;

            7'd10 : period <= 3.913594;    7'd11 : period <= 3.592788;
            7'd12 : period <= 3.368167;    7'd13 : period <= 3.209708;
            7'd14 : period <= 2.645041;    7'd15 : period <= 2.859179;
            7'd16 : period <= 2.496068;    7'd17 : period <= 2.406054;
            7'd18 : period <= 2.270531;    7'd19 : period <= 2.095360;

            7'd20 : period <= 1.953664;    7'd21 : period <= 1.839039;
            7'd22 : period <= 1.753034;    7'd23 : period <= 1.661255;
            7'd24 : period <= 1.603448;    7'd25 : period <= 1.516444;
            7'd26 : period <= 1.484819;    7'd27 : period <= 1.457689;
            7'd28 : period <= 1.402513;    7'd29 : period <= 1.377006;

            7'd30 : period <= 1.307111;    7'd31 : period <= 1.263722;
            7'd32 : period <= 1.245408;    7'd33 : period <= 1.225850;
            7'd34 : period <= 1.191168;    7'd35 : period <= 1.157014;
            7'd36 : period <= 1.142049;    7'd37 : period <= 1.098859;
            7'd38 : period <= 1.071625;    7'd39 : period <= 1.047230;

            7'd40 : period <= 1.035447;    7'd41 : period <= 1.024255;
            7'd42 : period <= 1.016506;    7'd43 : period <= 1.004516;
            7'd44 : period <= 0.9941507;   7'd45 : period <= 0.9732488;
            7'd46 : period <= 0.9537857;   7'd47 : period <= 0.9349234;
            7'd48 : period <= 0.9275408;   7'd49 : period <= 0.9099443;

            7'd50 : period <= 0.8944290;   7'd51 : period <= 0.8801194;
            7'd52 : period <= 0.8659096;   7'd53 : period <= 0.8552728;
            7'd54 : period <= 0.8396999;   7'd55 : period <= 0.8278537;
            7'd56 : period <= 0.8156088;   7'd57 : period <= 0.8043971;
            7'd58 : period <= 0.7981079;   7'd59 : period <= 0.7839706;
			
            7'd60 : period <= 0.7588592;   7'd61 : period <= 0.7535138;
            7'd62 : period <= 0.7472303;   7'd63 : period <= 0.7430251;
            7'd64 : period <= 0.7358736;   7'd65 : period <= 0.7284906;
            7'd66 : period <= 0.7237285;   7'd67 : period <= 0.7178415;
            7'd68 : period <= 0.7101650;   7'd69 : period <= 0.7051947;
			
            7'd70 : period <= 0.6989703;   7'd71 : period <= 0.6923062;
            7'd72 : period <= 0.6841997;   7'd73 : period <= 0.6798919;
            7'd74 : period <= 0.6738198;   7'd75 : period <= 0.6661954;
            7'd76 : period <= 0.6607397;   7'd77 : period <= 0.6546213;
            7'd78 : period <= 0.6472565;   7'd79 : period <= 0.6408371;
			
            7'd80 : period <= 0.6341203;   7'd81 : period <= 0.6285207;
            7'd82 : period <= 0.6231986;   7'd83 : period <= 0.6179512;
            7'd84 : period <= 0.6130174;   7'd85 : period <= 0.6081479;
            7'd86 : period <= 0.6035216;   7'd87 : period <= 0.5988653;
            7'd88 : period <= 0.5942605;   7'd89 : period <= 0.5898051;
            7'd90 : period <= 0.5852876;   7'd91 : period <= 0.5807448;
            7'd92 : period <= 0.5765234;   7'd93 : period <= 0.5721031;
            7'd94 : period <= 0.5676909;   7'd95 : period <= 0.5634013;
            7'd96 : period <= 0.5591657;   7'd97 : period <= 0.5549120;
            7'd98 : period <= 0.5506985;   7'd99 : period <= 0.5465227;
			
            7'd100 : period <= 0.7505607;  7'd101 : period <= 0.7453550;
            7'd102 : period <= 0.7404937;  7'd103 : period <= 0.7366056;
            7'd104 : period <= 0.7328589;  7'd105 : period <= 0.7288757;
            7'd106 : period <= 0.7250997;  7'd107 : period <= 0.7209711;
            7'd108 : period <= 0.7178205;  7'd109 : period <= 0.7136457;

            7'd110 : period <= 0.7089255;  7'd111 : period <= 0.7056896;
            7'd112 : period <= 0.7024690;  7'd113 : period <= 0.6996237;
            7'd114 : period <= 0.6953778;  7'd115 : period <= 0.6921013;
            7'd116 : period <= 0.6881015;  7'd117 : period <= 0.6857753;
            7'd118 : period <= 0.6816899;  7'd119 : period <= 0.6797003;

            7'd120 : period <= 0.6756415;  7'd121 : period <= 0.6719861;
            7'd122 : period <= 0.6689706;  7'd123 : period <= 0.6671913;
            7'd124 : period <= 0.6644127;  7'd125 : period <= 0.6604556;
            7'd126 : period <= 0.6586317;  7'd127 : period <= 0.6548645;

        endcase
    end

    always@(posedge RESET_) begin : dco_run
        forever begin : dco_set
            DCO_OUT = ~DCO_OUT;
            #(period / 2.0);
        end
    end

    always@(negedge RESET_) begin
        DCO_OUT = 1'b0;
        disable dco_run; // turn off DCO when RESET_=0
    end

endmodule
