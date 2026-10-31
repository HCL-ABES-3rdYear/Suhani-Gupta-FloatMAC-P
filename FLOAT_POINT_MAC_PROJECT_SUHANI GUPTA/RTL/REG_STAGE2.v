module REG_STAGE2 (
    input clk,
    input rst,
    input        sign_m,
    input [8:0]  exp_m,
    input [47:0] mant_m,
    input        sign_c_in,
    input [7:0]  exp_c_in,
    input [23:0] mant_c_in,
    
    output reg        sign_m_reg,
    output reg [8:0]  exp_m_reg,
    output reg [47:0] mant_m_reg,
    output reg        sign_c_reg2,
    output reg [7:0]  exp_c_reg2,
    output reg [23:0] mant_c_reg2);

always @(posedge clk) begin
    if (rst) begin
        sign_m_reg  <= 1'b0;
        exp_m_reg   <= 9'b0;
        mant_m_reg  <= 48'b0;

        sign_c_reg2 <= 1'b0;
        exp_c_reg2  <= 8'b0;
        mant_c_reg2 <= 24'b0;
    end
    else begin
        sign_m_reg  <= sign_m;
        exp_m_reg   <= exp_m;
        mant_m_reg  <= mant_m;

        sign_c_reg2 <= sign_c_in;
        exp_c_reg2  <= exp_c_in;
        mant_c_reg2 <= mant_c_in;
    end
end
endmodule