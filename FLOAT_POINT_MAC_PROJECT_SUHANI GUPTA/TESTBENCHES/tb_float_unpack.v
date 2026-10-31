`timescale 1ns / 1ps

module tb_float_unpack;

    reg [31:0] a;
    reg [31:0] b;
    reg [31:0] c;

    wire sign_a;
    wire sign_b;
    wire sign_c;

    wire [7:0] exp_a;
    wire [7:0] exp_b;
    wire [7:0] exp_c;

    wire [23:0] mant_a;
    wire [23:0] mant_b;
    wire [23:0] mant_c;


    FLOAT_UNPACK DUT (
        .a(a),
        .b(b),
        .c(c),

        .sign_a(sign_a),
        .sign_b(sign_b),
        .sign_c(sign_c),

        .exp_a(exp_a),
        .exp_b(exp_b),
        .exp_c(exp_c),

        .mant_a(mant_a),
        .mant_b(mant_b),
        .mant_c(mant_c)
    );


    initial begin

        // =========================================
        // TEST 1
        // A = 1.5
        // B = 1.0
        // C = 1.25
        // =========================================

        a = 32'h3FC00000;
        b = 32'h3F800000;
        c = 32'h3FA00000;

        #100;

        $display("--------------------------------");
        $display("UNPACK TEST 1");
        $display("sign_a = %b", sign_a);
        $display("exp_a  = %h", exp_a);
        $display("mant_a = %h", mant_a);

        $display("sign_b = %b", sign_b);
        $display("exp_b  = %h", exp_b);
        $display("mant_b = %h", mant_b);

        $display("sign_c = %b", sign_c);
        $display("exp_c  = %h", exp_c);
        $display("mant_c = %h", mant_c);


        // =========================================
        // TEST 2
        // A = -2.0
        // B = 3.0
        // C = -1.0
        // =========================================

        a = 32'hC0000000;
        b = 32'h40400000;
        c = 32'hBF800000;

        #100;

        $display("--------------------------------");
        $display("UNPACK TEST 2");
        $display("sign_a = %b", sign_a);
        $display("exp_a  = %h", exp_a);
        $display("mant_a = %h", mant_a);

        $display("sign_b = %b", sign_b);
        $display("exp_b  = %h", exp_b);
        $display("mant_b = %h", mant_b);

        $display("sign_c = %b", sign_c);
        $display("exp_c  = %h", exp_c);
        $display("mant_c = %h", mant_c);


        $display("--------------------------------");
        $display("UNPACK TEST COMPLETE");

        $finish;

    end

endmodule