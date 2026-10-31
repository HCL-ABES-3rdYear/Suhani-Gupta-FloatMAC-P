`timescale 1ns / 1ps

module tb_float_pack;

    reg        sign_r;
    reg [8:0]  exp_r;
    reg [23:0] mant_r;

    wire [31:0] fp_result;

    FLOAT_PACK DUT (
        .sign_r(sign_r),
        .exp_r(exp_r),
        .mant_r(mant_r),
        .fp_result(fp_result)  );


    initial begin

        sign_r = 1'b0;
        exp_r  = 9'd127;
        mant_r = 24'h800000;

        #100;

        $display("--------------------------------");
        $display("TEST 1 - +1.0");
        $display("fp_result = %h", fp_result);
        $display("EXPECTED  = 3F800000");
        sign_r = 1'b0;
        exp_r  = 9'd127;
        mant_r = 24'hC00000;

        #100;

        $display("--------------------------------");
        $display("TEST 2 - +1.5");
        $display("fp_result = %h", fp_result);
        $display("EXPECTED  = 3FC00000");
        
        sign_r = 1'b0;
        exp_r  = 9'd128;
        mant_r = 24'h800000;

        #100;

        $display("--------------------------------");
        $display("TEST 3 - +2.0");
        $display("fp_result = %h", fp_result);
        $display("EXPECTED  = 40000000");

        sign_r = 1'b1;
        exp_r  = 9'd127;
        mant_r = 24'h800000;

        #100;

        $display("--------------------------------");
        $display("TEST 4 - -1.0");
        $display("fp_result = %h", fp_result);
        $display("EXPECTED  = BF800000");

        sign_r = 1'b0;
        exp_r  = 9'd128;
        mant_r = 24'hB00000;

        #100;

        $display("--------------------------------");
        $display("TEST 5 - +2.75");
        $display("fp_result = %h", fp_result);
        $display("EXPECTED  = 40300000");

        sign_r = 1'b1;
        exp_r  = 9'd129;
        mant_r = 24'hA00000;

        #100;

        $display("--------------------------------");
        $display("TEST 6 - -5.0");
        $display("fp_result = %h", fp_result);
        $display("EXPECTED  = C0A00000");


        // =========================================
        // TEST 7: ZERO
        //
        // Expected = 00000000
        // =========================================

        sign_r = 1'b0;
        exp_r  = 9'd0;
        mant_r = 24'h000000;

        #100;

        $display("--------------------------------");
        $display("TEST 7 - ZERO");
        $display("fp_result = %h", fp_result);
        $display("EXPECTED  = 00000000");

        sign_r = 1'b0;
        exp_r  = 9'd129;
        mant_r = 24'hC00000;

        #100;

        $display("--------------------------------");
        $display("TEST 8 - +6.0");
        $display("fp_result = %h", fp_result);
        $display("EXPECTED  = 40C00000");


        $display("--------------------------------");
        $display("FLOAT_PACK TEST COMPLETE");

        $finish;

    end

endmodule