
module REG_STAGE4 (
    input clk,
    input rst,
    input        sign_norm,
    input [8:0]  exp_norm,
    input [47:0] mant_norm,

    output reg        sign_norm_reg,
    output reg [8:0]  exp_norm_reg,
    output reg [47:0] mant_norm_reg);

always @(posedge clk) begin
    if (rst) begin
        sign_norm_reg <= 1'b0;
        exp_norm_reg  <= 9'b0;
        mant_norm_reg <= 48'b0;
    end
    else begin
        sign_norm_reg <= sign_norm;
        exp_norm_reg  <= exp_norm;
        mant_norm_reg <= mant_norm;
    end
end
endmodule
