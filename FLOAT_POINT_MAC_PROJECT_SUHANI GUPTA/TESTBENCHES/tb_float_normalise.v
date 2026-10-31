`timescale 1ns / 1ps

module tb_float_normalise;

    reg        sign_add;
    reg [8:0]  exp_add;
    reg [47:0] mant_add;

    wire        sign_norm;
    wire [8:0]  exp_norm;
    wire [47:0] mant_norm;

    FLOAT_NORMALISE DUT (
        .sign_add(sign_add),
        .exp_add(exp_add),
        .mant_add(mant_add),

        .sign_norm(sign_norm),
        .exp_norm(exp_norm),
        .mant_norm(mant_norm)  );

    initial begin

        sign_add = 1'b0;
        exp_add  = 9'd127;
        mant_add = 48'h000000000000;

        #100;

        $display("--------------------------------");
        $display("TEST 1 - ZERO");
        $display("sign_norm = %b", sign_norm);
        $display("exp_norm  = %d", exp_norm);
        $display("mant_norm = %h", mant_norm);


        // =========================================
        // TEST 2: OVERFLOW
        //
        // mantissa starts with 1 at bit 47
        //
        // B00000000000
        //       ? shift right
        // 580000000000
        //
        // exponent: 127 -> 128
        // =========================================

        sign_add = 1'b0;
        exp_add  = 9'd127;
        mant_add = 48'hB00000000000;

        #100;

        $display("--------------------------------");
        $display("TEST 2 - OVERFLOW");
        $display("sign_norm = %b", sign_norm);
        $display("exp_norm  = %d", exp_norm);
        $display("mant_norm = %h", mant_norm);


        // =========================================
        // TEST 3: ALREADY NORMALISED
        //
        // Leading 1 already at bit 46
        //
        // 400000000000
        // =========================================

        sign_add = 1'b0;
        exp_add  = 9'd127;
        mant_add = 48'h400000000000;

        #100;

        $display("--------------------------------");
        $display("TEST 3 - ALREADY NORMALISED");
        $display("sign_norm = %b", sign_norm);
        $display("exp_norm  = %d", exp_norm);
        $display("mant_norm = %h", mant_norm);


        // =========================================
        // TEST 4: LEFT SHIFT REQUIRED
        //
        // 200000000000
        //       ?
        // 400000000000
        //
        // exponent: 127 -> 126
        // =========================================

        sign_add = 1'b0;
        exp_add  = 9'd127;
        mant_add = 48'h200000000000;

        #100;

        $display("--------------------------------");
        $display("TEST 4 - LEFT SHIFT");
        $display("sign_norm = %b", sign_norm);
        $display("exp_norm  = %d", exp_norm);
        $display("mant_norm = %h", mant_norm);


        // =========================================
        // TEST 5: NEGATIVE VALUE
        // =========================================

        sign_add = 1'b1;
        exp_add  = 9'd128;
        mant_add = 48'h500000000000;

        #100;

        $display("--------------------------------");
        $display("TEST 5 - NEGATIVE");
        $display("sign_norm = %b", sign_norm);
        $display("exp_norm  = %d", exp_norm);
        $display("mant_norm = %h", mant_norm);


        $display("--------------------------------");
        $display("NORMALISE TEST COMPLETE");

        $finish;

    end

endmodule