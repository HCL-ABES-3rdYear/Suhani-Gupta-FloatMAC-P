`timescale 1ns / 1ps

module tb_float_addition;

    reg sign_m;
    reg sign_c;

    reg [8:0] exp_m;
    reg [7:0] exp_c;

    reg [47:0] mant_m;
    reg [23:0] mant_c;

    wire sign_add;
    wire [8:0] exp_add;
    wire [47:0] mant_add;


    FLOAT_ADDITION DUT (
        .sign_m(sign_m),
        .sign_c(sign_c),

        .exp_m(exp_m),
        .exp_c(exp_c),

        .mant_m(mant_m),
        .mant_c(mant_c),

        .sign_add(sign_add),
        .exp_add(exp_add),
        .mant_add(mant_add)
    );


    initial begin

        sign_m = 0;
        exp_m  = 9'd127;
        mant_m = 48'h600000000000;

        sign_c = 0;
        exp_c  = 8'd127;
        mant_c = 24'hA00000;

        #100;

        $display("--------------------------------");
        $display("ADDITION TEST 1");
        $display("sign_add = %b", sign_add);
        $display("exp_add  = %d", exp_add);
        $display("mant_add = %h", mant_add);

        sign_m = 0;
        exp_m  = 9'd128;
        mant_m = 48'h400000000000;
        sign_c = 0;
        exp_c  = 8'd127;
        mant_c = 24'h800000;
        #100;
        $display("--------------------------------");
        $display("ADDITION TEST 2");
        $display("sign_add = %b", sign_add);
        $display("exp_add  = %d", exp_add);
        $display("mant_add = %h", mant_add);

        sign_m = 0;
        exp_m  = 9'd128;
        mant_m = 48'h400000000000;

        sign_c = 1;
        exp_c  = 8'd127;
        mant_c = 24'h800000;
        #100;
        $display("--------------------------------");
        $display("ADDITION TEST 3");
        $display("sign_add = %b", sign_add);
        $display("exp_add  = %d", exp_add);
        $display("mant_add = %h", mant_add);
        $display("--------------------------------");
        $display("ADDITION TEST COMPLETE");
        $finish;
    end
endmodule