
module tb_float_multiplier;

    reg sign_a;
    reg sign_b;

    reg [7:0] exp_a;
    reg [7:0] exp_b;

    reg [23:0] mant_a;
    reg [23:0] mant_b;

    wire sign_m;
    wire [8:0] exp_m;
    wire [47:0] mant_m;


    FLOAT_MULTIPLIER DUT (
        .sign_a(sign_a),
        .sign_b(sign_b),

        .exp_a(exp_a),
        .exp_b(exp_b),

        .mant_a(mant_a),
        .mant_b(mant_b),

        .sign_m(sign_m),
        .exp_m(exp_m),
        .mant_m(mant_m)
    );


    initial begin
        sign_a = 0;
        sign_b = 0;

        exp_a = 8'd127;
        exp_b = 8'd127;

        mant_a = 24'hC00000;
        mant_b = 24'h800000;

        #100;

        $display("--------------------------------");
        $display("MULTIPLIER TEST 1");
        $display("sign_m = %b", sign_m);
        $display("exp_m  = %d", exp_m);
        $display("mant_m = %h", mant_m);
        sign_a = 0;
        sign_b = 0;
        exp_a = 8'd128;
        exp_b = 8'd128;
        mant_a = 24'h800000;
        mant_b = 24'hC00000;

        #100;

        $display("--------------------------------");
        $display("MULTIPLIER TEST 2");
        $display("sign_m = %b", sign_m);
        $display("exp_m  = %d", exp_m);
        $display("mant_m = %h", mant_m);

        sign_a = 1;
        sign_b = 0;

        exp_a = 8'd128;
        exp_b = 8'd128;

        mant_a = 24'h800000;
        mant_b = 24'hC00000;

        #100;

        $display("--------------------------------");
        $display("MULTIPLIER TEST 3");
        $display("sign_m = %b", sign_m);
        $display("exp_m  = %d", exp_m);
        $display("mant_m = %h", mant_m);


        $display("--------------------------------");
        $display("MULTIPLIER TEST COMPLETE");

        $finish;

    end

endmodule