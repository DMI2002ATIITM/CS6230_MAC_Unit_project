package bf16_mul;

interface Ifc_bf16_mul;
method Action get_A(Bit#(16) a);
method Action get_B(Bit#(16) b);
method Bfnum out_AB();
endinterface: Ifc_bf16_mul

typedef struct {
    Bit#(1) sign;
    Bit#(8) exponent;
    Bit#(7) fraction;
} Bfnum deriving (Bits, Eq);

(* synthesize *)
module mkbf16_mul(Ifc_bf16_mul);
    Reg#(Bfnum) bf_a <- mkReg(Bfnum{ sign: 1'd0, exponent: 8'd0, fraction: 7'd0}); 
    Reg#(Bfnum) bf_b <- mkReg(Bfnum{ sign: 1'd0, exponent: 8'd0, fraction: 7'd0}); 
    Reg#(Bfnum) bf_c <- mkReg(Bfnum{ sign: 1'd0, exponent: 8'd0, fraction: 7'd0}); 
    Reg#(Bool) got_A <- mkReg(False);
    Reg#(Bool) got_B <- mkReg(False);
    Reg#(Bool) sign_calculated <- mkReg(False);
    Reg#(Bool) expone_calculated <- mkReg(False);
    Reg#(Bool) calculate_mantissa <- mkReg(False);
    Reg#(Bit#(16)) temp_prod <- mkReg(0);
    Reg#(Bool) rounding_done <- mkReg(False);
    Reg#(Bit#(16)) temp_A <- mkReg(0);
    Reg#(Bit#(16)) temp_B <- mkReg(0);
    Reg#(Bit#(1)) sign_c <- mkReg(0);
    Reg#(Bit#(8)) exp_c <- mkReg(0);
    Reg#(Bit#(7)) man_c <- mkReg(0);
    Reg#(Bit#(16)) final_output <- mkReg(0);
    Reg#(Bool) assembled_answer <- mkReg(False);
    Reg#(Bit#(15)) man_c_and_final_exp <- mkReg(0);
    Reg#(Bit#(5)) count <- mkReg(8);
    
    function Bit#(16) rca(Bit#(16) a, Bit#(16) b);
	Bit#(16) outp = 0;
	Bit#(1) carry = 0;
	outp[0] = a[0] ^ b[0];
	carry = a[0] & b[0];
	for(Integer i = 1; i < 16; i = i + 1)
	begin
		outp[i] = a[i] ^ b[i] ^ carry;
		carry = (a[i] & b[i]) | (a[i] ^ b[i]) & carry;
	end

	return outp;
    endfunction:rca
    
    function Bit#(8) add_exponents(Bit#(8) a, Bit#(8) b);
	Bit#(8) outp_inter = 8'b0;
	Bit#(8) outp = 8'b0;
	Bit#(8) bias = 8'b10000001;
	Bit#(1) carry = 1'b0;
	outp_inter[0] = a[0] ^ b[0];
	carry = a[0] & b[0];
	for(Integer i = 1; i < 8; i = i + 1)
	begin
		outp_inter[i] = a[i] ^ b[i] ^ carry;
		carry = (a[i] & b[i]) | (a[i] ^ b[i]) & carry;
	end
	
	carry = 1'b0;
	outp[0] = outp_inter[0] ^ bias[0];
	carry = outp_inter[0] & bias[0];
	for(Integer i = 1; i < 8; i = i + 1)
	begin
		outp[i] = outp_inter[i] ^ bias[i] ^ carry;
		carry = (outp_inter[i] & bias[i]) | (outp_inter[i] ^ bias[i]) & carry;
	end

	return outp;
    endfunction:add_exponents
    
    function Bit#(8) add_8bits(Bit#(8) a, Bit#(8) b);
	Bit#(8) outp = 8'b0;
	Bit#(1) carry = 1'b0;
	outp[0] = a[0] ^ b[0];
	carry = a[0] & b[0];
	for(Integer i = 1; i < 8; i = i + 1)
	begin
		outp[i] = a[i] ^ b[i] ^ carry;
		carry = (a[i] & b[i]) | (a[i] ^ b[i]) & carry;
	end

	return outp;
    endfunction:add_8bits
    
    function Bit#(9) add_9bits(Bit#(9) a, Bit#(9) b);
	Bit#(9) outp = 9'b0;
	Bit#(1) carry = 1'b0;
	outp[0] = a[0] ^ b[0];
	carry = a[0] & b[0];
	for(Integer i = 1; i < 9; i = i + 1)
	begin
		outp[i] = a[i] ^ b[i] ^ carry;
		carry = (a[i] & b[i]) | (a[i] ^ b[i]) & carry;
	end

	return outp;
    endfunction:add_9bits


    function Bit#(15) add_15bits(Bit#(15) a, Bit#(15) b);
	Bit#(15) outp = 15'b0;
	Bit#(1) carry = 1'b0;
	outp[0] = a[0] ^ b[0];
	carry = a[0] & b[0];
	for(Integer i = 1; i < 15; i = i + 1)
	begin
		outp[i] = a[i] ^ b[i] ^ carry;
		carry = (a[i] & b[i]) | (a[i] ^ b[i]) & carry;
	end

	return outp;
    endfunction:add_15bits
    
    function Bit#(15) round(Bit#(16) prod_out, Bit#(8) exp);
	Bit#(15) outp = 15'b0;
	Bit#(1) round_bit = 1'b0;
	Bit#(6) rem_nocarry = 6'b0;
	Bit#(7) rem_withcarry = 7'b0;
	Bit#(9) carry_type_a = 9'b0;	 
	Bit#(9) carry_type_b = 9'b0;	 
	
	if(prod_out[15] == 1'd1) // If carry is generated during multiplication
	begin
		exp = add_8bits(exp, 8'b1);
		round_bit = prod_out[7];
		// If round bit is 0 truncate the remaining bits
		if(round_bit == 1'd0)
		begin
			outp = zeroExtend(prod_out[14:8]);
		end
		// If round bit is 1 do the following
		else
		begin
		      rem_withcarry = prod_out[6:0]; // To check the remaining bits
		      if(rem_withcarry == 7'd0 && prod_out[8] == 1'd0) // If remaining bits are 0 and LSB is also 0
		      begin
  			      	outp = zeroExtend(prod_out[14:8]); // Truncate the rest
		      end
		      else
		      begin // If remaining bits are non zero
		      		carry_type_b = add_9bits(zeroExtend(prod_out[15:8]) , 9'b1); // Add one to round up
		      		if(carry_type_b[8] == 1) // See if the above addition results in a carry
		      		begin
		      			exp = add_8bits(exp, 8'b1); // Adjust exponent
		      			outp = zeroExtend(carry_type_b[7:1]);
		      		end
		      		else
		      		begin // If there is no carry while rounding up
		      			outp = zeroExtend(carry_type_b[6:0]);
		      		end
		      end
		end 
		
	end
	else  // If carry is not generated during multiplication
	begin
		round_bit = prod_out[6];
		// If round bit is 0 truncate the remaining bits
		if(round_bit == 1'd0)
		begin
			outp = zeroExtend(prod_out[13:7]);
		end
		// If round bit is 1 do the following
		else
		begin
		      rem_nocarry = prod_out[5:0]; // To check the remaining bits
		      if(rem_nocarry == 6'd0 && prod_out[7] == 1'd0) // If remaining bits are 0 and LSB is also 0
		      begin
  			      	outp = zeroExtend(prod_out[13:7]); // Truncate the rest
		      end
		      else
		      begin // If remaining bits are non zero
		      		carry_type_a = add_9bits(prod_out[15:7], 9'b1); // Add one to round up
		      		if(carry_type_a[8] == 1) // See if the above addition results in a carry
		      		begin
		      			exp = add_8bits(exp, 8'b1); // Adjust exponent
		      			outp = zeroExtend(carry_type_a[7:1]);
		      		end
		      		else
		      		begin // If there is no carry while rounding up
		      			outp = zeroExtend(carry_type_a[6:0]);
		      		end
		      end
		end 
		
	end
	outp = add_15bits(outp, (zeroExtend(exp) << 7));
    return outp;
    endfunction:round
    
    rule calculate_sign(got_A == True && got_B == True && sign_calculated == False);
    	assembled_answer <= False;
    	sign_calculated <= True;
    	sign_c <= bf_a.sign ^ bf_b.sign;
    endrule
    
    rule calculate_expone(got_A == True && got_B == True && sign_calculated == True && expone_calculated == False);
    	expone_calculated <= True;
    	calculate_mantissa <= True;
    	exp_c <= add_exponents(bf_a.exponent , bf_b.exponent);
   	temp_A <= zeroExtend({1'b1,bf_a.fraction});
    	temp_B <= zeroExtend({1'b1,bf_b.fraction});
    endrule
    
    rule rl_multiply(got_A == True && got_B == True && count != 5'd0 && sign_calculated == True && expone_calculated == True && calculate_mantissa == True);
	if(temp_B[0] == 1)
	begin
		temp_prod <= rca(temp_prod , zeroExtend(temp_A));
	end
	temp_A <= temp_A << 1;
	temp_B <= temp_B >> 1;
	count <= count - 1; 
    endrule
    
    rule round_nearest(got_A == True && got_B == True && sign_calculated == True && expone_calculated == True && calculate_mantissa == True && count == 5'd0 && rounding_done == False);
    	rounding_done <= True;
    	man_c_and_final_exp <= round(temp_prod, exp_c);
    	
    endrule
    
    rule assemble_answer(got_A == True && got_B == True && sign_calculated == True && expone_calculated == True && calculate_mantissa == True && rounding_done == True && assembled_answer == False);
    	assembled_answer <= True;
    	got_A <= False;
    	got_B <= False;
    	sign_calculated <= False;
    	expone_calculated <= False;
    	calculate_mantissa <= False;
    	rounding_done <= False;
    	count <= 5'd8;
    	temp_prod <= 16'd0;
    	bf_c <= Bfnum{ sign: sign_c, exponent: man_c_and_final_exp[14:7], fraction: man_c_and_final_exp[6:0] };
    endrule

    method Action get_A(Bit#(16) a) if (!got_A);
        got_A <= True;
        bf_a <= Bfnum{ sign: a[15], exponent: a[14:7], fraction: a[6:0] };
    endmethod

    method Action get_B(Bit#(16) b) if (!got_B);
        got_B <= True;
        bf_b <= Bfnum{ sign: b[15], exponent: b[14:7], fraction: b[6:0] };
    endmethod

    method Bfnum out_AB() if(assembled_answer == True);
        return bf_c; 
    endmethod

endmodule: mkbf16_mul
endpackage

