module REG_STAGE1 (
    input clk,
    input rst,

    input sign_a,
    input sign_b,
    input sign_c,

    input [7:0]  exp_a,
    input [7:0]  exp_b,
    input [7:0]  exp_c,

    input [23:0] mant_a,
    input [23:0] mant_b,
    input [23:0] mant_c,

    output reg sign_a_reg,
    output reg sign_b_reg,
    output reg sign_c_reg,

    output reg [7:0]  exp_a_reg,
    output reg [7:0]  exp_b_reg,
    output reg [7:0]  exp_c_reg,

    output reg [23:0] mant_a_reg,
    output reg [23:0] mant_b_reg,
    output reg [23:0] mant_c_reg);

always @(posedge clk) begin
    if (rst) begin
        sign_a_reg <= 1'b0;
        sign_b_reg <= 1'b0;
        sign_c_reg <= 1'b0;

        exp_a_reg <= 8'b0;
        exp_b_reg <= 8'b0;
        exp_c_reg <= 8'b0;

        mant_a_reg <= 24'b0;
        mant_b_reg <= 24'b0;
        mant_c_reg <= 24'b0;
    end
    else begin
        sign_a_reg <= sign_a;
        sign_b_reg <= sign_b;
        sign_c_reg <= sign_c;

        exp_a_reg <= exp_a;
        exp_b_reg <= exp_b;
        exp_c_reg <= exp_c;

        mant_a_reg <= mant_a;
        mant_b_reg <= mant_b;
        mant_c_reg <= mant_c;
    end
end
endmodule