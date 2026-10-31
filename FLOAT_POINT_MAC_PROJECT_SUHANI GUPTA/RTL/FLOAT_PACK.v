
module FLOAT_PACK(
input sign_r,
input [8:0]exp_r,
input [23:0]mant_r,
output reg  [31:0]fp_result );

always@(*)
begin
if((exp_r == 9'b0) && (mant_r == 24'b0))
fp_result = 32'b0;
else if (exp_r >= 9'd255)
fp_result = {sign_r, 8'hFF, 23'b0};
else if (exp_r <= 9'd0)
fp_result = 32'b0; 
else 
fp_result = {sign_r, exp_r[7:0] , mant_r[22:0]};
end
endmodule
