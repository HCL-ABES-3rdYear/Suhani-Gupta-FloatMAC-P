
`timescale 1ns / 1ps

module FLOAT_POINT_MAC_throughput_tb;

    reg clk_0;
    reg rst_0;
    reg [31:0] a_0, b_0, c_0;
    wire [31:0] fp_result_0;

    reg [31:0] test_a [0:6];
    reg [31:0] test_b [0:6];
    reg [31:0] test_c [0:6];
    reg [31:0] expected [0:6];

    integer i;
    integer j;
    integer pass_count;
    integer fail_count;

    FLOAT_POINT_MAC_wrapper dut (
        .a_0(a_0),
        .b_0(b_0),
        .c_0(c_0),
        .clk_0(clk_0),
        .rst_0(rst_0),
        .fp_result_0(fp_result_0)
    );

    initial clk_0 = 1'b0;
    always #5 clk_0 = ~clk_0;

    initial begin
        pass_count = 0;
        fail_count = 0;

        a_0 = 0;
        b_0 = 0;
        c_0 = 0;
        rst_0 = 1;

        // Test vectors and expected IEEE-754 results
        test_a[0] = 32'h3FC00000;
        test_b[0] = 32'h3F800000;
        test_c[0] = 32'h3FA00000;
        expected[0] = 32'h40300000; // 2.75

        test_a[1] = 32'h40000000;
        test_b[1] = 32'h40400000;
        test_c[1] = 32'h3F800000;
        expected[1] = 32'h40E00000; // 7.0

        test_a[2] = 32'h40200000;
        test_b[2] = 32'h40000000;
        test_c[2] = 32'hBF800000;
        expected[2] = 32'h40800000; // 4.0

        test_a[3] = 32'hC0000000;
        test_b[3] = 32'h40400000;
        test_c[3] = 32'h3F800000;
        expected[3] = 32'hC0A00000; // -5.0

        test_a[4] = 32'h3F800000;
        test_b[4] = 32'h3F800000;
        test_c[4] = 32'hBF800000;
        expected[4] = 32'h00000000; // 0.0

        test_a[5] = 32'h3F000000;
        test_b[5] = 32'h3F000000;
        test_c[5] = 32'h3F000000;
        expected[5] = 32'h3F400000; // 0.75

        test_a[6] = 32'h3F800000;
        test_b[6] = 32'h40000000;
        test_c[6] = 32'hBF800000;
        expected[6] = 32'h3F800000; // 1.0

        $display("======================================");
        $display(" FLOATMAC-P THROUGHPUT TEST");
        $display("======================================");

        repeat (3) @(posedge clk_0);
        @(negedge clk_0);
        rst_0 = 0;

        // Apply one new input tuple per clock cycle.
        for (i = 0; i < 7; i = i + 1) begin
            @(negedge clk_0);
            a_0 = test_a[i];
            b_0 = test_b[i];
            c_0 = test_c[i];

            @(posedge clk_0);
            #1;

            // Five registered stages: first result appears
            // after the fifth rising edge following input 0.
            if (i >= 4) begin
                if (fp_result_0 === expected[i-4]) begin
                    $display("PASS: Input %0d, Result = %h",
                             i-4, fp_result_0);
                    pass_count = pass_count + 1;
                end
                else begin
                    $display("FAIL: Input %0d, Expected = %h, Actual = %h",
                             i-4, expected[i-4], fp_result_0);
                    fail_count = fail_count + 1;
                end
            end
        end

        // Drain the remaining pipeline results.
        for (j = 3; j < 7; j = j + 1) begin
            @(posedge clk_0);
            #1;

            if (fp_result_0 === expected[j]) begin
                $display("PASS: Input %0d, Result = %h",
                         j, fp_result_0);
                pass_count = pass_count + 1;
            end
            else begin
                $display("FAIL: Input %0d, Expected = %h, Actual = %h",
                         j, expected[j], fp_result_0);
                fail_count = fail_count + 1;
            end
        end

        $display("--------------------------------------");
        $display("Total checked: %0d", pass_count + fail_count);
        $display("Passed       : %0d", pass_count);
        $display("Failed       : %0d", fail_count);
        $display("--------------------------------------");

        if (fail_count == 0)
            $display("THROUGHPUT TEST PASSED");
        else
            $display("THROUGHPUT TEST FAILED");

        $finish;
    end

endmodule
