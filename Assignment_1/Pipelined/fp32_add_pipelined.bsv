package fp32_add_pipelined;

import FIFO::*;
import SpecialFIFOs::*;

import MAC_types ::*;

interface Ifc_fp32_add_pipelined;
method Action get_A(Bit#(16) a);
method Action get_B(Bit#(32) b);
method ActionValue#(Fpnum) out_AaddB();
endinterface: Ifc_fp32_add_pipelined

(* synthesize *)
module mkfp32_add_pipelined(Ifc_fp32_add_pipelined);

    FIFO#(Bit#(16))     inpA_fifo <- mkPipelineFIFO();
    FIFO#(Bit#(32))     inpB_fifo <- mkPipelineFIFO();
    FIFO#(Fpnum)        out_fifo  <- mkPipelineFIFO();

    Reg#(Fpnum) fp_a <- mkReg(Fpnum{ sign: 1'd0, exponent: 8'd0, fraction: 23'd0}); 
    Reg#(Fpnum) fp_b <- mkReg(Fpnum{ sign: 1'd0, exponent: 8'd0, fraction: 23'd0}); 
    
    Reg#(Bit#(8)) expdiff <- mkReg(0);
    Reg#(Bit#(50)) temp_A <- mkReg(0);
    Reg#(Bit#(50)) temp_B <- mkReg(0);
    Reg#(Bit#(50)) temp_sum <- mkReg(0);
    Reg#(Bit#(31)) add_res_with_adj_exp <- mkReg(0);
    Reg#(Bit#(1)) sign_c <- mkReg(0);
    
    Reg#(Bool) init_done <- mkReg(False);
    Reg#(Bool) operands_swapped_if_needed <- mkReg(False);
    Reg#(Bool) expdiff_calculated <- mkReg(False);
    Reg#(Bool) add_prep_done <- mkReg(False);
    Reg#(Bool) do_add <- mkReg(False);
    Reg#(Bool) do_sub <- mkReg(False);    
    Reg#(Bool) add_done <- mkReg(False);
    Reg#(Bool) round_addition_result <- mkReg(False); 
    Reg#(Bool) round_subtraction_result <- mkReg(False); 
    Reg#(Bool) round_done <- mkReg(False);
    Reg#(Bool) adj_sub <- mkReg(False);    
    Reg#(Bool) adj_done <- mkReg(False);
    Reg#(Bool) assembled_answer <- mkReg(False);
    Reg#(Bool) handle_zero <- mkReg(False);      
    Reg#(Bool) handle_oneinpzero <- mkReg(False);
    
    function Bit#(50) add_50bits(Bit#(50) a, Bit#(50) b);
	Bit#(50) outp = 50'b0;
	Bit#(1) carry = 1'b0;
	outp[0] = a[0] ^ b[0];
	carry = a[0] & b[0];
	for(Integer i = 1; i < 50; i = i + 1)
	begin
		outp[i] = a[i] ^ b[i] ^ carry;
		carry = (a[i] & b[i]) | (a[i] ^ b[i]) & carry;
	end

	return outp;
    endfunction:add_50bits
    
    function Bit#(31) add_31bits(Bit#(31) a, Bit#(31) b);
	Bit#(31) outp = 31'b0;
	Bit#(1) carry = 1'b0;
	outp[0] = a[0] ^ b[0];
	carry = a[0] & b[0];
	for(Integer i = 1; i < 31; i = i + 1)
	begin
		outp[i] = a[i] ^ b[i] ^ carry;
		carry = (a[i] & b[i]) | (a[i] ^ b[i]) & carry;
	end

	return outp;
    endfunction:add_31bits
        
    function Bit#(25) add_25bits(Bit#(25) a, Bit#(25) b);
	Bit#(25) outp = 25'b0;
	Bit#(1) carry = 1'b0;
	outp[0] = a[0] ^ b[0];
	carry = a[0] & b[0];
	for(Integer i = 1; i < 25; i = i + 1)
	begin
		outp[i] = a[i] ^ b[i] ^ carry;
		carry = (a[i] & b[i]) | (a[i] ^ b[i]) & carry;
	end

	return outp;
    endfunction:add_25bits
    
    function Bit#(8) add_8bits(Bit#(8) a, Bit#(8) c);
	Bit#(8) outp = 0;
	Bit#(1) carry = 0;
	outp[0] = a[0] ^ c[0];
	carry = a[0] & c[0];
	for(Integer i = 1; i < 8; i = i + 1)
	begin
		outp[i] = a[i] ^ c[i] ^ carry;
		carry = (a[i] & c[i]) | (a[i] ^ c[i]) & carry;
	end

	return outp;
    endfunction:add_8bits
    
    function Bit#(8) twos_compliment(Bit#(8) num);
	Bit#(8) mask = 8'hFF;
	Bit#(8) temp = 8'd0;
	temp = num ^ mask;
	temp = add_8bits(temp,1);
	return temp;
    endfunction:twos_compliment
    
    function Bit#(8) sub_8bits(Bit#(8) a, Bit#(8) b);
	Bit#(8) outp = 8'b0;
	Bit#(1) carry = 1'b0;
	Bit#(8) comp_b = 8'b0;
	comp_b = (b ^ '1) + 1;
	outp[0] = a[0] ^ comp_b[0];
	carry = a[0] & comp_b[0];
	for(Integer i = 1; i < 8; i = i + 1)
	begin
		outp[i] = a[i] ^ comp_b[i] ^ carry;
		carry = (a[i] & comp_b[i]) | (a[i] ^ comp_b[i]) & carry;
	end

	return outp;
    endfunction:sub_8bits
    
    function Bit#(50) sub_50bits(Bit#(50) a, Bit#(50) b);
	Bit#(50) outp = 50'b0;
	Bit#(1) carry = 1'b0;
	Bit#(50) comp_b = 50'b0;
	comp_b = (b ^ '1) + 1;
	outp[0] = a[0] ^ comp_b[0];
	carry = a[0] & comp_b[0];
	for(Integer i = 1; i < 50; i = i + 1)
	begin
		outp[i] = a[i] ^ comp_b[i] ^ carry;
		carry = (a[i] & comp_b[i]) | (a[i] ^ comp_b[i]) & carry;
	end

	return outp;
    endfunction:sub_50bits
    
    function Bit#(31) round_afteradd(Bit#(50) add_out, Bit#(8) exp);
	Bit#(31) outp = 31'b0;
	Bit#(1) round_bit = 1'b0;
	Bit#(24) rem_nocarry = 24'b0;
	Bit#(25) rem_withcarry = 25'b0;
	Bit#(25) carry_type_a = 25'b0;	 
	Bit#(25) carry_type_b = 25'b0;	 
	
	if(add_out[49] == 1'd1) // If carry is generated during addition
	begin
		exp = add_8bits(exp, 8'b1);
		round_bit = add_out[25];
		// If round bit is 0 truncate the remaining bits
		if(round_bit == 1'd0)
		begin
			outp = zeroExtend(add_out[48:26]);
		end
		// If round bit is 1 do the following
		else
		begin
		      rem_withcarry = add_out[24:0]; // To check the remaining bits
		      if(rem_withcarry == 25'd0 && add_out[26] == 1'd0) // If remaining bits are 0 and LSB is also 0
		      begin
  			      	outp = zeroExtend(add_out[48:26]); // Truncate the rest
		      end
		      else
		      begin // If remaining bits are non zero
		      		carry_type_b = add_25bits(zeroExtend(add_out[49:26]) , 25'b1); // Add one to round up
		      		if(carry_type_b[24] == 1) // See if the above addition results in a carry
		      		begin
		      			exp = add_8bits(exp, 8'b1); // Adjust exponent
		      			outp = zeroExtend(carry_type_b[23:1]);
		      		end
		      		else
		      		begin // If there is no carry while rounding up
		      			outp = zeroExtend(carry_type_b[22:0]);
		      		end
		      end
		end 
		
	end
	else  // If carry is not generated during addition
	begin
		round_bit = add_out[24];
		// If round bit is 0 truncate the remaining bits
		if(round_bit == 1'd0)
		begin
			outp = zeroExtend(add_out[47:25]);
		end
		// If round bit is 1 do the following
		else
		begin
		      rem_nocarry = add_out[23:0]; // To check the remaining bits
		      if(rem_nocarry == 24'd0 && add_out[25] == 1'd0) // If remaining bits are 0 and LSB is also 0
		      begin
  			      	outp = zeroExtend(add_out[47:25]); // Truncate the rest
		      end
		      else
		      begin // If remaining bits are non zero
		      		carry_type_a = add_25bits(add_out[49:25], 25'b1); // Add one to round up
		      		if(carry_type_a[24] == 1) // See if the above addition results in a carry
		      		begin
		      			exp = add_8bits(exp, 8'b1); // Adjust exponent
		      			outp = zeroExtend(carry_type_a[23:1]);
		      		end
		      		else
		      		begin // If there is no carry while rounding up
		      			outp = zeroExtend(carry_type_a[22:0]);
		      		end
		      end
		end 
		
	end
	outp = add_31bits(outp, (zeroExtend(exp) << 23));
    return outp;
    endfunction:round_afteradd
    
    function Bit#(31) round_aftersub(Bit#(50) sub_out, Bit#(8) exp);
	Bit#(31) outp = 31'b0;
	Bit#(1) round_bit = 1'b0;
	Bit#(24) rem_nocarry = 24'b0;
	Bit#(23) rem_bits = 23'b0;
	Bit#(25) carry_type_a = 25'b0;	 
	Bit#(25) carry_type_b = 25'b0;	 
	
	if(sub_out[48] == 1'd0) // If MSB is zero during subtraction
	begin
		exp = exp - 8'b1;
		round_bit = sub_out[23];
		// If round bit is 0 truncate the remaining bits
		if(round_bit == 1'd0)
		begin
			outp = zeroExtend(sub_out[46:24]);
		end
		// If round bit is 1 do the following
		else
		begin
		      rem_bits = sub_out[22:0]; // To check the remaining bits
		      if(rem_bits == 23'd0 && sub_out[24] == 1'd0) // If remaining bits are 0 and LSB is also 0
		      begin
  			      	outp = zeroExtend(sub_out[46:24]); // Truncate the rest
		      end
		      else
		      begin // If remaining bits are non zero
		      		carry_type_b = add_25bits(zeroExtend(sub_out[47:23]) , 25'b1); // Add one to round up
		      		if(carry_type_b[24] == 1) // See if the above addition results in a carry
		      		begin
		      			exp = add_8bits(exp, 8'b1); // Adjust exponent
		      			outp = zeroExtend(carry_type_b[23:1]);
		      		end
		      		else
		      		begin // If there is no carry while rounding up
		      			outp = zeroExtend(carry_type_b[22:0]);
		      		end
		      end
		end 
		
	end
	else  // If MSB is not zero after subtraction
	begin
		round_bit = sub_out[24];
		// If round bit is 0 truncate the remaining bits
		if(round_bit == 1'd0)
		begin
			outp = zeroExtend(sub_out[47:25]);
		end
		// If round bit is 1 do the following
		else
		begin
		      rem_nocarry = sub_out[23:0]; // To check the remaining bits
		      if(rem_nocarry == 24'd0 && sub_out[25] == 1'd0) // If remaining bits are 0 and LSB is also 0
		      begin
  			      	outp = zeroExtend(sub_out[47:25]); // Truncate the rest
		      end
		      else
		      begin // If remaining bits are non zero
		      		carry_type_a = add_25bits(sub_out[49:25], 25'b1); // Add one to round up
		      		if(carry_type_a[24] == 1) // See if the above addition results in a carry
		      		begin
		      			exp = add_8bits(exp, 8'b1); // Adjust exponent
		      			outp = zeroExtend(carry_type_a[23:1]);
		      		end
		      		else
		      		begin // If there is no carry while rounding up
		      			outp = zeroExtend(carry_type_a[22:0]);
		      		end
		      end
		end 
		
	end
	outp = add_31bits(outp, (zeroExtend(exp) << 23));
    return outp;
    endfunction:round_aftersub
    
    rule init(init_done == False);
        Bit#(16) a = inpA_fifo.first();
        Bit#(32) b = inpB_fifo.first();
        fp_a <= Fpnum{ sign: a[15], exponent: a[14:7], fraction: {a[6:0],16'b0} };
        fp_b <= Fpnum{ sign: b[31], exponent: b[30:23], fraction: b[22:0] };
        inpA_fifo.deq();
        inpB_fifo.deq();
        init_done <= True;
    endrule
    
    rule swap_operands_if_needed(init_done == True && operands_swapped_if_needed == False && handle_zero == False && handle_oneinpzero == False);
    	if(fp_a.exponent == fp_b.exponent && fp_a.fraction == fp_b.fraction && fp_a.sign != fp_b.sign) // Handles special case when addition results in zero
    	begin
    		handle_zero <= True;
	end
    	else if((fp_a.exponent == '0 && fp_a.fraction == '0) || (fp_b.exponent == '0 && fp_b.fraction == '0)) // Handles special case when one of the inputs is zero
    	begin
    		if(fp_b.exponent == '0 && fp_b.fraction == '0)
    		begin
    			fp_b.sign <= '0;
    		end 
    		handle_oneinpzero <= True;
    	end
    	else 
    	begin 
	    	if(fp_a.exponent < fp_b.exponent)
	    	begin
	    		fp_a <= fp_b;
	    		fp_b <= fp_a;	
	    	end
	    	else if(fp_a.exponent == fp_b.exponent)
	    	begin
	    		if(fp_a.fraction < fp_b.fraction)
	    		begin
	    			fp_a <= fp_b;
	    			fp_b <= fp_a;
	    		end
	    	end
    	end
    	operands_swapped_if_needed <= True;
    endrule
    
    rule calculate_expdiff(init_done == True && operands_swapped_if_needed == True && expdiff_calculated == False && handle_zero == False && handle_oneinpzero == False);
    	temp_A <= {2'b01, fp_a.fraction, 25'b0};
    	temp_B <= {2'b01, fp_b.fraction, 25'b0};
    	expdiff_calculated <= True;
    	expdiff <= add_8bits(fp_a.exponent, twos_compliment(fp_b.exponent));
    endrule
    
    rule add_prep(init_done == True && operands_swapped_if_needed == True && expdiff_calculated == True && add_prep_done == False && handle_zero == False && handle_oneinpzero == False);
    	add_prep_done <= True;
    	if(fp_a.sign == fp_b.sign)
    	begin
    		sign_c <= fp_a.sign;
	    	temp_B <= temp_B >> expdiff;
	    	do_add <= True;
    	end
    	else
    	begin
	    	sign_c <= fp_a.sign;
	    	temp_B <= temp_B >> expdiff;
	    	do_sub <= True;
    	end
    endrule
    
    rule add(init_done == True && operands_swapped_if_needed == True && expdiff_calculated == True && add_prep_done == True && do_add == True && handle_zero == False && handle_oneinpzero == False);
    	do_add <= False;
    	temp_sum <= add_50bits(temp_A, temp_B);
    	round_addition_result <= True;
    endrule
    
    rule sub(init_done == True && operands_swapped_if_needed == True && expdiff_calculated == True && add_prep_done == True && do_sub == True && handle_zero == False && handle_oneinpzero == False);
    	do_sub <= False;
    	temp_sum <= sub_50bits(temp_A, temp_B);
	adj_sub <= True;
    endrule
    
    rule adjust_subres(init_done == True && operands_swapped_if_needed == True && expdiff_calculated == True && add_prep_done == True && adj_sub == True && adj_done == False && handle_zero == False && handle_oneinpzero == False);
	if(temp_sum[48] == 1'b1)
	begin
		adj_done <= True;
		round_subtraction_result <= True;
	end
	else
	begin
		fp_a.exponent <= sub_8bits(fp_a.exponent, 8'b1);
		temp_sum <= temp_sum << 1;
	end
    
    endrule
    
    rule round_add(init_done == True && operands_swapped_if_needed == True && expdiff_calculated == True && round_addition_result == True && round_done == False && handle_zero == False && handle_oneinpzero == False);
    	round_done <= True;
    	add_res_with_adj_exp <= round_afteradd(temp_sum,fp_a.exponent);
    endrule
    
    rule round_sub(init_done == True && operands_swapped_if_needed == True && expdiff_calculated == True && round_subtraction_result == True && round_done == False && handle_zero == False && handle_oneinpzero == False);
    	round_done <= True;
    	add_res_with_adj_exp <= round_aftersub(temp_sum,fp_a.exponent);
    endrule
    
    rule assemble_answer(init_done == True && operands_swapped_if_needed == True && expdiff_calculated == True && round_done == True && assembled_answer == False && handle_zero == False && handle_oneinpzero == False);
    	assembled_answer <= True;    	
    	out_fifo.enq(Fpnum{ sign: sign_c, exponent: add_res_with_adj_exp[30:23], fraction: add_res_with_adj_exp[22:0] });
    endrule
    
    rule handle_zero_case(handle_zero == True && handle_oneinpzero == False);
    	handle_zero <= False;
    	assembled_answer <= True;
    	out_fifo.enq(Fpnum{ sign: '0, exponent: '0, fraction: '0});
    endrule
    
    rule handle_oneinpzero_case(handle_oneinpzero == True);
    	handle_oneinpzero <= False;
    	assembled_answer <= True;
    	out_fifo.enq(Fpnum{ sign: fp_a.sign | fp_b.sign, exponent: fp_a.exponent | fp_b.exponent, fraction: fp_a.fraction | fp_b.fraction});
    endrule
    
    rule deassert_assembled_answer(assembled_answer == True);
    	assembled_answer <= False;
    	operands_swapped_if_needed <= False;
    	expdiff_calculated <= False;
    	add_done <= False;
    	round_addition_result <= False;
    	round_subtraction_result <= False;
    	do_add <= False;
    	do_sub <= False;
    	round_done <= False;
    	add_res_with_adj_exp <= 31'd0;
    	temp_sum <= 50'd0;
    	add_prep_done <= False;
    	adj_done <= False;
    	adj_sub <= False;
    	handle_zero <= False;
    	handle_oneinpzero <= False;
    	init_done <= False;
    endrule
    
    method Action get_A(Bit#(16) a);
        inpA_fifo.enq(a);
    endmethod

    method Action get_B(Bit#(32) b);
        inpB_fifo.enq(b);
    endmethod

    method ActionValue#(Fpnum) out_AaddB() if(assembled_answer == True);
        Fpnum out = out_fifo.first();
        out_fifo.deq();
        return out; 
    endmethod

endmodule: mkfp32_add_pipelined
endpackage
