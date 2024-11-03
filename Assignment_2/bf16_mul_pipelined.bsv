package bf16_mul_pipelined;

import FIFO::*;
import SpecialFIFOs::*;

import MAC_types ::*;

interface Ifc_bf16_mul_pipelined;
method Action get_A(Bit#(16) a);
method Action get_B(Bit#(16) b);
method ActionValue#(Bfnum) out_AB();
endinterface: Ifc_bf16_mul_pipelined

(* synthesize *)
module mkbf16_mul_pipelined(Ifc_bf16_mul_pipelined);

    FIFO#(Bit#(16))     inpA_fifo <- mkPipelineFIFO();
    FIFO#(Bit#(16))     inpB_fifo <- mkPipelineFIFO();
    FIFO#(Bfnum)        out_fifo  <- mkPipelineFIFO();

    Reg#(Bfnum) bf_a <- mkReg(Bfnum{ sign: 1'd0, exponent: 8'd0, fraction: 7'd0}); 
    Reg#(Bfnum) bf_b <- mkReg(Bfnum{ sign: 1'd0, exponent: 8'd0, fraction: 7'd0});
     
    Reg#(Bit#(16)) temp_prod <- mkReg(0);
    Reg#(Bit#(16)) temp_A <- mkReg(0);
    Reg#(Bit#(16)) temp_B <- mkReg(0);
    Reg#(Bit#(1)) sign_c <- mkReg(0);
    Reg#(Bit#(8)) exp_c <- mkReg(0);
    Reg#(Bit#(7)) man_c <- mkReg(0);
    Reg#(Bit#(16)) final_output <- mkReg(0);
    Reg#(Bit#(15)) man_c_and_final_exp <- mkReg(0);
    Reg#(Bit#(4)) count <- mkReg(8);
    
    Reg#(Bool) init_done <- mkReg(False);
    Reg#(Bool) sign_calculated <- mkReg(False);
    Reg#(Bool) expone_calculated <- mkReg(False);
    Reg#(Bool) calculate_mantissa <- mkReg(False);
    Reg#(Bool) rounding_done <- mkReg(False);
    Reg#(Bool) assembled_answer <- mkReg(False);
    Reg#(Bool) handle_zero <- mkReg(False);
    Reg#(Bool) handled_zero <- mkReg(False);
    
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
    
    rule init(init_done == False);
        Bit#(16) a = inpA_fifo.first();
        Bit#(16) b = inpB_fifo.first();
        bf_a <= Bfnum{ sign: a[15], exponent: a[14:7], fraction: a[6:0] };
        bf_b <= Bfnum{ sign: b[15], exponent: b[14:7], fraction: b[6:0] };
        inpA_fifo.deq();
        inpB_fifo.deq();
        init_done <= True;
    endrule       
    
    rule calculate_sign(init_done == True && sign_calculated == False && handle_zero == False);
    	if((bf_a.exponent == '0 && bf_a.fraction == '0) || (bf_b.exponent == '0 && bf_b.fraction == '0)) // To handle if one of the inputs is zero
    	begin
    		handle_zero <= True;
    	end
    	else
    	begin
	    	sign_calculated <= True;
	    	sign_c <= bf_a.sign ^ bf_b.sign;
    	end
    endrule
    
    rule handle_case_zero(init_done == True && handle_zero == True && handled_zero == False);
    	assembled_answer <= True;
    	handled_zero <= True;
    	out_fifo.enq(Bfnum{ sign: '0, exponent: '0, fraction: '0 });
    endrule
    
    rule calculate_expone(init_done == True && sign_calculated == True && expone_calculated == False && handle_zero == False);
    	expone_calculated <= True;
    	calculate_mantissa <= True;
    	exp_c <= add_exponents(bf_a.exponent , bf_b.exponent);
   	temp_A <= zeroExtend({1'b1,bf_a.fraction});
    	temp_B <= zeroExtend({1'b1,bf_b.fraction});
    endrule
    
    rule rl_multiply(init_done == True && count != 4'd0 && sign_calculated == True && expone_calculated == True && calculate_mantissa == True && handle_zero == False);
	if(temp_B[0] == 1)
	begin
		temp_prod <= rca(temp_prod , zeroExtend(temp_A));
	end
	temp_A <= temp_A << 1;
	temp_B <= temp_B >> 1;
	count <= count - 1; 
    endrule
    
    rule round_nearest(init_done == True && sign_calculated == True && expone_calculated == True && calculate_mantissa == True && count == 4'd0 && rounding_done == False && handle_zero == False);
    	rounding_done <= True;
    	man_c_and_final_exp <= round(temp_prod, exp_c);
    endrule
    
    rule assemble_answer(init_done == True && sign_calculated == True && expone_calculated == True && calculate_mantissa == True && rounding_done == True && assembled_answer == False && handle_zero == False);
    	assembled_answer <= True;
    	out_fifo.enq(Bfnum{ sign: sign_c, exponent: man_c_and_final_exp[14:7], fraction: man_c_and_final_exp[6:0] });
    endrule
    
    rule deassert_assembled_answer(assembled_answer == True);
    	sign_calculated <= False;
    	expone_calculated <= False;
    	calculate_mantissa <= False;
    	rounding_done <= False;
    	count <= 4'd8;
    	temp_prod <= 16'd0;
    	handle_zero <= False;
    	assembled_answer <= False;
    	handled_zero <= False;
    	init_done <= False;
    endrule

    method Action get_A(Bit#(16) a);
        inpA_fifo.enq(a);
    endmethod

    method Action get_B(Bit#(16) b);
        inpB_fifo.enq(b);
    endmethod

    method ActionValue#(Bfnum) out_AB() if(assembled_answer == True);
        Bfnum out = out_fifo.first();
        out_fifo.deq();
        return out; 
    endmethod

endmodule: mkbf16_mul_pipelined
endpackage

