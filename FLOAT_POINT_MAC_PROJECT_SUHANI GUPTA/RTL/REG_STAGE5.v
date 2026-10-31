
module REG_STAGE5 (
    input clk,
    input rst,

    input        sign_r,
    input [8:0]  exp_r,
    input [23:0] mant_r,

    output reg        sign_r_reg,
    output reg [8:0]  exp_r_reg,
    output reg [23:0] mant_r_reg);

always @(posedge clk) begin
    if (rst) begin
        sign_r_reg <= 1'b0;
        exp_r_reg  <= 9'b0;
        mant_r_reg <= 24'b0;
    end
    else begin
        sign_r_reg <= sign_r;
        exp_r_reg  <= exp_r;
        mant_r_reg <= mant_r;
    end
end
endmodule
