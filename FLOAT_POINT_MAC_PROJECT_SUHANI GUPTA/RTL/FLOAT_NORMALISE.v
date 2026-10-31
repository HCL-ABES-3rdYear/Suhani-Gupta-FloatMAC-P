
module FLOAT_NORMALISE (
    input         sign_add,
    input  [8:0]  exp_add,
    input  [47:0] mant_add,
    output reg        sign_norm,
    output reg [8:0]  exp_norm,
    output reg [47:0] mant_norm
);

integer i;
reg [47:0] temp_mant;
reg [8:0]  temp_exp;
reg        found_one;

always @(*) begin
    sign_norm = sign_add;
    exp_norm  = exp_add;
    mant_norm = mant_add;
    temp_mant = mant_add;
    temp_exp  = exp_add;
    found_one = 1'b0;

    // Case 1: Zero
    if (mant_add == 48'b0) begin
        sign_norm = 1'b0;
        exp_norm  = 9'b0;
        mant_norm = 48'b0;
    end

    // Case 2: Leading bit at position 47
    else if (mant_add[47] == 1'b1) begin
        mant_norm = mant_add >> 1;
        exp_norm  = exp_add + 1'b1;
    end

    // Case 3: Normalize left
    else begin
        for (i = 46; i >= 0; i = i - 1) begin
            if (!found_one && mant_add[i]) begin
                temp_mant = mant_add << (46 - i);
                temp_exp  = exp_add - (46 - i);
                found_one = 1'b1;
            end
        end

        mant_norm = temp_mant;
        exp_norm  = temp_exp;
    end
end

endmodule
