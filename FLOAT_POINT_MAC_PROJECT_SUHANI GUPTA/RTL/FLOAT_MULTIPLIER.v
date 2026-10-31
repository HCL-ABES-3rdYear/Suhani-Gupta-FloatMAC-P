
module FLOAT_MULTIPLIER(
input sign_a,sign_b,
input [7:0]exp_a,exp_b,
input [23:0]mant_a,mant_b,
output sign_m,
output [8:0]exp_m,
output [47:0]mant_m );

assign sign_m = sign_a^sign_b;
assign exp_m = exp_a+exp_b - 127;
assign mant_m = mant_a*mant_b;

endmodule
