module tb_float_mac;
    reg [31:0] a_0;
    reg [31:0] b_0;
    reg [31:0] c_0;
    wire [31:0] fp_result_0;

    FLOATING_POINT_MAC_wrapper DUT (
        .a_0(a_0),
        .b_0(b_0),
        .c_0(c_0),
        .fp_result_0(fp_result_0)
    );
    initial begin
        a_0 = 32'h3FC00000;
        b_0 = 32'h3F800000;
        c_0 = 32'h3FA00000;
        #100;
        $display("----------------------------------------");
        $display("TEST 1");
        $display("A      = %h", a_0);
        $display("B      = %h", b_0);
        $display("C      = %h", c_0);
        $display("RESULT = %h", fp_result_0);
        $display("EXPECT = 40300000");
        
        a_0 = 32'h40000000;
        b_0 = 32'h40400000;
        c_0 = 32'h3F800000;
        #100;
        $display("----------------------------------------");
        $display("TEST 2");
        $display("A      = %h", a_0);
        $display("B      = %h", b_0);
        $display("C      = %h", c_0);
        $display("RESULT = %h", fp_result_0);
        $display("EXPECT = 40E00000");

        a_0 = 32'h40200000;
        b_0 = 32'h40000000;
        c_0 = 32'hBF800000;
        #100;
        $display("----------------------------------------");
        $display("TEST 3");
        $display("A      = %h", a_0);
        $display("B      = %h", b_0);
        $display("C      = %h", c_0);
        $display("RESULT = %h", fp_result_0);
        $display("EXPECT = 40800000");

        a_0 = 32'hC0000000;
        b_0 = 32'h40400000;
        c_0 = 32'h3F800000;
        #100;
        $display("----------------------------------------");
        $display("TEST 4");
        $display("A      = %h", a_0);
        $display("B      = %h", b_0);
        $display("C      = %h", c_0);
        $display("RESULT = %h", fp_result_0);
        $display("EXPECT = C0A00000");
        $display("----------------------------------------");
        $display("ALL TESTS COMPLETED");
        $finish;
    end
endmodule

