
`timescale 1ns / 1ps

module FLOAT_POINT_MAC_tb;

    reg clk_0;
    reg rst_0;

    reg [31:0] a_0;
    reg [31:0] b_0;
    reg [31:0] c_0;

    wire [31:0] fp_result_0;

    integer pass_count;
    integer fail_count;

    // Device Under Test
    FLOAT_POINT_MAC_wrapper dut (
        .a_0(a_0),
        .b_0(b_0),
        .c_0(c_0),
        .clk_0(clk_0),
        .rst_0(rst_0),
        .fp_result_0(fp_result_0)
    );

    // 100 MHz simulated clock: 10 ns period
    initial begin
        clk_0 = 1'b0;
    end

    always #5 clk_0 = ~clk_0;

    // Apply inputs, wait for the five-stage pipeline,
    // and compare the result with the expected IEEE-754 value.
    task run_test;
        input [31:0] test_a;
        input [31:0] test_b;
        input [31:0] test_c;
        input [31:0] expected_result;

        begin
            @(negedge clk_0);

            a_0 = test_a;
            b_0 = test_b;
            c_0 = test_c;

            repeat (5) @(posedge clk_0);
            #1;

            if (fp_result_0 === expected_result) begin
                $display(
                    "PASS: A=%h B=%h C=%h RESULT=%h",
                    test_a, test_b, test_c, fp_result_0
                );

                $display("      EXPECTED=%h", expected_result);
                pass_count = pass_count + 1;
            end
            else begin
                $display(
                    "FAIL: A=%h B=%h C=%h",
                    test_a, test_b, test_c
                );

                $display(
                    "      EXPECTED=%h ACTUAL=%h",
                    expected_result, fp_result_0
                );

                fail_count = fail_count + 1;
            end

            $display("------------------------------------------");
        end
    endtask

    // Main test sequence
    initial begin

        rst_0 = 1'b1;

        a_0 = 32'h00000000;
        b_0 = 32'h00000000;
        c_0 = 32'h00000000;

        pass_count = 0;
        fail_count = 0;

        $display("");
        $display("==========================================");
        $display(" FLOATMAC-P FUNCTIONAL TESTBENCH");
        $display(" IEEE-754 SINGLE-PRECISION MAC");
        $display(" Operation: (A * B) + C");
        $display("==========================================");

        // Reset the pipeline
        repeat (3) @(posedge clk_0);

        @(negedge clk_0);
        rst_0 = 1'b0;

        // TEST 1: (1.5 * 1.0) + 1.25 = 2.75
        run_test(
            32'h3FC00000,
            32'h3F800000,
            32'h3FA00000,
            32'h40300000
        );

        // TEST 2: (2.0 * 3.0) + 1.0 = 7.0
        run_test(
            32'h40000000,
            32'h40400000,
            32'h3F800000,
            32'h40E00000
        );

        // TEST 3: (2.5 * 2.0) + (-1.0) = 4.0
        run_test(
            32'h40200000,
            32'h40000000,
            32'hBF800000,
            32'h40800000
        );

        // TEST 4: (-2.0 * 3.0) + 1.0 = -5.0
        run_test(
            32'hC0000000,
            32'h40400000,
            32'h3F800000,
            32'hC0A00000
        );

        // TEST 5: (1.0 * 1.0) + (-1.0) = 0.0
        run_test(
            32'h3F800000,
            32'h3F800000,
            32'hBF800000,
            32'h00000000
        );

        // TEST 6: (0.5 * 0.5) + 0.5 = 0.75
        run_test(
            32'h3F000000,
            32'h3F000000,
            32'h3F000000,
            32'h3F400000
        );

        // TEST 7: (1.0 * 2.0) + (-1.0) = 1.0
        run_test(
            32'h3F800000,
            32'h40000000,
            32'hBF800000,
            32'h3F800000
        );

        // TEST 8: (0.25 * 0.5) + 0.125 = 0.25
        run_test(
            32'h3E800000,
            32'h3F000000,
            32'h3E000000,
            32'h3E800000
        );

        // TEST 9: (1.5 * 2.0) + (-1.0) = 2.0
        run_test(
            32'h3FC00000,
            32'h40000000,
            32'hBF800000,
            32'h40000000
        );

        // TEST 10: (-1.5 * 2.0) + 1.0 = -2.0
        run_test(
            32'hBFC00000,
            32'h40000000,
            32'h3F800000,
            32'hC0000000
        );

        // TEST 11: (2.0 * 0.5) + (-1.0) = 0.0
        run_test(
            32'h40000000,
            32'h3F000000,
            32'hBF800000,
            32'h00000000
        );

        // TEST 12: (1.0 * 1.0) + 0.5 = 1.5
        run_test(
            32'h3F800000,
            32'h3F800000,
            32'h3F000000,
            32'h3FC00000
        );

        // Final summary
        $display("");
        $display("==========================================");
        $display(" SIMULATION SUMMARY");
        $display("==========================================");

        $display("Total tests : %0d", pass_count + fail_count);
        $display("Passed      : %0d", pass_count);
        $display("Failed      : %0d", fail_count);

        $display("==========================================");

        if (fail_count == 0)
            $display("ALL TESTS PASSED!");
        else
            $display("SOME TESTS FAILED. CHECK YOUR RTL.");

        $display("==========================================");

        $finish;
    end

endmodule
