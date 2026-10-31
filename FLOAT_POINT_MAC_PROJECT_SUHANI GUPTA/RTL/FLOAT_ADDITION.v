
module FLOAT_ADDITION(
input sign_m,sign_c,
input [8:0]exp_m,
input [7:0]exp_c,
input [23:0]mant_c,
input [47:0]mant_m,  
output reg sign_add,
output reg [8:0]exp_add,
output reg [47:0]mant_add );

reg [8:0]exp_diff;
reg [47:0]c_ext;
reg [47:0]m_aligned;
reg [47:0]c_aligned;

//comparison of exponent
always@(*)
begin 
c_ext = {mant_c,23'b0};

if(exp_m > {1'b0,exp_c})
begin
exp_diff = exp_m - {1'b0, exp_c};
m_aligned = mant_m;
c_aligned = c_ext >> exp_diff;
exp_add = exp_m;
end
else if (exp_m <{1'b0, exp_c})
begin
exp_diff ={1'b0, exp_c} - exp_m;
m_aligned = mant_m >> exp_diff;
c_aligned = c_ext;
exp_add = exp_c;
end
else
begin
exp_diff =0;
m_aligned = mant_m;
c_aligned = c_ext;
exp_add = exp_c;
end
end

//calculation of sign & mantissa
always@(*)
begin 
if(sign_m == sign_c)
begin
mant_add = m_aligned + c_aligned;
sign_add = sign_m;
end
else 
begin
if(m_aligned > c_aligned)
begin
mant_add = m_aligned - c_aligned;
sign_add = sign_m;
end
else 
begin 
mant_add = c_aligned - m_aligned;
sign_add = sign_c;
end
end
end

endmodule
