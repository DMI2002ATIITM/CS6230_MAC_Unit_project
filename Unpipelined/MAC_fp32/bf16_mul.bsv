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
    Reg#(Bfnum) bf_a <- mkReg(Bfnum{ sign: 1'd0, exponent: 8'd0, fraction: 7'd0}); //b10000000 });
    Reg#(Bfnum) bf_b <- mkReg(Bfnum{ sign: 1'd0, exponent: 8'd0, fraction: 7'd0}); //b10000000 });
    Reg#(Bfnum) bf_c <- mkReg(Bfnum{ sign: 1'd0, exponent: 8'd0, fraction: 7'd0}); //b10000000 });
    Reg#(Bool) got_A <- mkReg(False);
    Reg#(Bool) got_B <- mkReg(False);
    Reg#(Bool) sign_calculated <- mkReg(False);
    Reg#(Bool) expone_calculated <- mkReg(False);
    Reg#(Bool) mantissa_calculated <- mkReg(False);
    Reg#(Bit#(16)) temp_prod <- mkReg(0);
    Reg#(Bool) rounding_done <- mkReg(False);
    Reg#(Bit#(8)) temp_A <- mkReg(0);
    Reg#(Bit#(8)) temp_B <- mkReg(0);
    Reg#(Bit#(1)) sign_c <- mkReg(0);
    Reg#(Bit#(8)) exp_c <- mkReg(0);
    Reg#(Bit#(7)) man_c <- mkReg(0);
    Reg#(Bit#(16)) final_output <- mkReg(0);
    Reg#(Bool) assembled_answer <- mkReg(False);
    Reg#(Bit#(15)) man_c_and_final_exp <- mkReg(0);
    
    function Bit#(15) round(Bit#(16) prod_out, Bit#(8) exp);
	Bit#(15) outp = 0;
	Bit#(1) round_bit = 0;
	Bit#(6) rem_nocarry = 0;
	Bit#(7) rem_withcarry = 0;
	Bit#(9) carry_type_a = 0;	 
	Bit#(9) carry_type_b = 0;	 
	
	if(prod_out[15] == 1'd1) // If carry is generated during multiplication
	begin
		exp = exp + 1;
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
		      		carry_type_b = zeroExtend(prod_out[15:8]) + 1; // Add one to round up
		      		if(carry_type_b[8] == 1) // See if the above addition results in a carry
		      		begin
		      			exp = exp + 1; // Adjust exponent
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
		      		carry_type_a = prod_out[15:7] + 1; // Add one to round up
		      		if(carry_type_a[8] == 1) // See if the above addition results in a carry
		      		begin
		      			exp = exp + 1; // Adjust exponent
		      			outp = zeroExtend(carry_type_a[7:1]);
		      		end
		      		else
		      		begin // If there is no carry while rounding up
		      			outp = zeroExtend(carry_type_a[6:0]);
		      		end
		      end
		end 
		
	end
	outp = outp + (zeroExtend(exp) << 7);
    return outp;
    endfunction:round
    
    rule calculate_sign(got_A == True && got_B == True && sign_calculated == False);
    	assembled_answer <= False;
    	sign_calculated <= True;
    	sign_c <= bf_a.sign ^ bf_b.sign;
    endrule
    
    rule calculate_expone(got_A == True && got_B == True && sign_calculated == True && expone_calculated == False);
    	expone_calculated <= True;
    	exp_c <= bf_a.exponent + bf_b.exponent + 8'b10000001;
    	temp_A <= zeroExtend(bf_a.fraction) + 8'b10000000;
    	temp_B <= zeroExtend(bf_b.fraction) + 8'b10000000;
    endrule
    
    rule calculate_mantissa(got_A == True && got_B == True && sign_calculated == True && expone_calculated == True && mantissa_calculated == False);
    	temp_prod <= zeroExtend(temp_A) * zeroExtend(temp_B);
    	mantissa_calculated <= True;
    endrule
    
    rule round_nearest(got_A == True && got_B == True && sign_calculated == True && expone_calculated == True && mantissa_calculated == True && rounding_done == False);
    	rounding_done <= True;
    	man_c_and_final_exp <= round(temp_prod, exp_c);
    	
    endrule
    
    rule assemble_answer(got_A == True && got_B == True && sign_calculated == True && expone_calculated == True && mantissa_calculated == True && rounding_done == True && assembled_answer == False);
    	assembled_answer <= True;
    	got_A <= False;
    	got_B <= False;
    	sign_calculated <= False;
    	expone_calculated <= False;
    	mantissa_calculated <= False;
    	rounding_done <= False;
    	//final_output <= (sign_c << 15) + (exp_c << 7) + man_c;
    	bf_c <= Bfnum{ sign: sign_c, exponent: man_c_and_final_exp[14:7], fraction: man_c_and_final_exp[6:0] };
    endrule

    method Action get_A(Bit#(16) a) if (!got_A);
        got_A <= True;
//        bf_a.sign <= a[15];
//        bf_a.exponent <= a[14:7];
//        bf_a.fraction <= bf_a.fraction + zeroExtend(a[6:0]);
        bf_a <= Bfnum{ sign: a[15], exponent: a[14:7], fraction: a[6:0] };
//        bf_a <= Bfnum{ sign: a[15], exponent: a[14:7], fraction: bf_a.fraction + zeroExtend(a[6:0]) };
    endmethod

    method Action get_B(Bit#(16) b) if (!got_B);
        got_B <= True;
//        bf_b.sign <= b[15];
//        bf_b.exponent <= b[14:7];
//        bf_b.fraction <= bf_b.fraction + zeroExtend(b[6:0]);
        bf_b <= Bfnum{ sign: b[15], exponent: b[14:7], fraction: b[6:0] };
//	bf_b <= Bfnum{ sign: b[15], exponent: b[14:7], fraction: bf_b.fraction + zeroExtend(b[6:0]) };
    endmethod

    method Bfnum out_AB() if(assembled_answer == True);
        return bf_c; 
    endmethod

endmodule: mkbf16_mul
endpackage

