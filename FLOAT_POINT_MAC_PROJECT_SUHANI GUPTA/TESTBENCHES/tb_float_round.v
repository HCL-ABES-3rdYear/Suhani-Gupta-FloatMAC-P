module tb_float_round;

    // -----------------------------------------
    // Inputs to FLOAT_ROUND
    // -----------------------------------------

    reg        sign_norm;
    reg [8:0]  exp_norm;
    reg [47:0] mant_norm;

    // -----------------------------------------
    // Outputs from FLOAT_ROUND
    // -----------------------------------------

    wire        sign_round;
    wire [8:0]  exp_round;
    wire [23:0] mant_round;


    // -----------------------------------------
    // Instantiate FLOAT_ROUND
    // -----------------------------------------

    FLOAT_ROUND DUT (
        .sign_norm(sign_norm),
        .exp_norm(exp_norm),
        .mant_norm(mant_norm),

        .sign_r(sign_round),
        .exp_r(exp_round),
        .mant_r(mant_round)
    );


    // -----------------------------------------
    // TEST CASES
    // -----------------------------------------

    initial begin

        // =========================================
        // TEST 1: NO ROUNDING
        //
        // Retained = 400000
        // Guard    = 0
        // Round    = 0
        // Sticky   = 0
        //
        // Expected:
        // sign = 0
        // exp  = 07F
        // mant = 400000
        // =========================================

        sign_norm = 1'b0;
        exp_norm  = 9'd127;
        mant_norm = 48'h400000000000;

        #100;

        $display("----------------------------------------");
        $display("TEST 1 - NO ROUNDING");
        $display("sign_round = %b", sign_round);
        $display("exp_round  = %h", exp_round);
        $display("mant_round = %h", mant_round);


        // =========================================
        // TEST 2: ROUND UP
        //
        // Retained = 400000
        // Guard    = 1
        // Round    = 0
        // Sticky   = 1
        //
        // round_up = 1
        //
        // Expected:
        // mant = 400001
        // =========================================

        sign_norm = 1'b0;
        exp_norm  = 9'd127;
        mant_norm = 48'h400000600001;

        #100;

        $display("----------------------------------------");
        $display("TEST 2 - ROUND UP");
        $display("sign_round = %b", sign_round);
        $display("exp_round  = %h", exp_round);
        $display("mant_round = %h", mant_round);


        // =========================================
        // TEST 3: EXACT HALF - EVEN
        //
        // Retained LSB = 0
        // Guard        = 1
        // Round        = 0
        // Sticky       = 0
        //
        // Round-to-nearest-even:
        // NO ROUNDING
        //
        // Expected:
        // mant = 400000
        // =========================================

        sign_norm = 1'b0;
        exp_norm  = 9'd127;
        mant_norm = 48'h400000400000;

        #100;

        $display("----------------------------------------");
        $display("TEST 3 - HALF EVEN");
        $display("sign_round = %b", sign_round);
        $display("exp_round  = %h", exp_round);
        $display("mant_round = %h", mant_round);


        // =========================================
        // TEST 4: EXACT HALF - ODD
        //
        // Retained LSB = 1
        // Guard        = 1
        // Round        = 0
        // Sticky       = 0
        //
        // Round-to-nearest-even:
        // ROUND UP
        //
        // Expected:
        // mant = 400002
        // =========================================

        sign_norm = 1'b0;
        exp_norm  = 9'd127;
        mant_norm = 48'h400001400000;

        #100;

        $display("----------------------------------------");
        $display("TEST 4 - HALF ODD");
        $display("sign_round = %b", sign_round);
        $display("exp_round  = %h", exp_round);
        $display("mant_round = %h", mant_round);


        // =========================================
        // TEST 5: ROUNDING OVERFLOW
        //
        // Retained = 7FFFFF
        // Guard    = 1
        // Sticky   = 1
        //
        // Rounding causes carry.
        //
        // Expected:
        // mant = 800000
        // exp  = 080
        // =========================================

        sign_norm = 1'b0;
        exp_norm  = 9'd127;
        mant_norm = 48'h7FFFFF800001;

        #100;

        $display("----------------------------------------");
        $display("TEST 5 - ROUNDING OVERFLOW");
        $display("sign_round = %b", sign_round);
        $display("exp_round  = %h", exp_round);
        $display("mant_round = %h", mant_round);


        // =========================================
        // TEST 6: NEGATIVE NUMBER
        //
        // Check sign propagation.
        //
        // Expected:
        // sign = 1
        // =========================================

        sign_norm = 1'b1;
        exp_norm  = 9'd127;
        mant_norm = 48'h7FFFFFC00001;

        #100;

        $display("----------------------------------------");
        $display("TEST 6 - NEGATIVE");
        $display("sign_round = %b", sign_round);
        $display("exp_round  = %h", exp_round);
        $display("mant_round = %h", mant_round);


        // =========================================
        // END SIMULATION
        // =========================================

        $display("----------------------------------------");
        $display("FLOAT_ROUND TEST COMPLETE");

        $finish;

    end

endmodule