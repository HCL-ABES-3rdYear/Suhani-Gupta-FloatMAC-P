module FLOAT_ROUND(
input        sign_norm,
input  [8:0] exp_norm,
input  [47:0] mant_norm,
output reg        sign_r,
output reg [8:0]  exp_r,
output reg [23:0] mant_r);

reg [23:0]retained;
reg g_bit;
reg r_bit;
reg s_bit;
reg lsb_bit;
reg round_up;
reg [24:0]r_ext;

always@(*)
begin
sign_r = sign_norm;
exp_r = exp_norm;
retained = mant_norm[46:23];

g_bit = mant_norm[22];
r_bit = mant_norm[21];
s_bit = |mant_norm[20:0];
lsb_bit = mant_norm[23];

round_up = g_bit & (r_bit | s_bit | lsb_bit);
r_ext = {1'b0, retained} + round_up;
if (round_up && retained == 24'hFFFFFF)
begin
mant_r = r_ext[24:1];
exp_r = exp_norm + 1'b1; 
end
else 
begin
mant_r = r_ext[23:0];
end
end
endmodule