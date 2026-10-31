
module FLOAT_UNPACK(
input [31:0]a,b,c,
output sign_a,sign_b,sign_c,
output [7:0]exp_a,exp_b,exp_c,
output reg [23:0]mant_a,mant_b,mant_c);
wire [22:0]frac_a,frac_b, frac_c;

assign sign_a = a[31];
assign sign_b = b[31];
assign sign_c = c[31];

assign exp_a = a[30:23];
assign exp_b = b[30:23];
assign exp_c = c[30:23];

assign frac_a = a[22:0];
assign frac_b = b[22:0];
assign frac_c = c[22:0];

always@(*)
begin 
if(exp_a == 8'd0)
mant_a = {1'b0, frac_a};
else
mant_a = {1'b1, frac_a};

if(exp_b == 8'd0)
mant_b = {1'b0, frac_b};
else
mant_b = {1'b1, frac_b};

if(exp_c == 8'd0)
mant_c = {1'b0, frac_c};
else
mant_c = {1'b1, frac_c};
end

endmodule
