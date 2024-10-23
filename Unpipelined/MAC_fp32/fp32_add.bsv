package fp32_add;

interface Ifc_fp32_add;
method Action get_A(Bit#(16) a);
method Action get_B(Bit#(32) b);
method Fpnum out_AaddB();
endinterface: Ifc_fp32_add

typedef struct {
    Bit#(1) sign;
    Bit#(8) exponent;
    Bit#(23) fraction;
} Fpnum deriving (Bits, Eq);

(* synthesize *)
module mkfp32_add(Ifc_fp32_add);
    Reg#(Fpnum) fp_a <- mkReg(Fpnum{ sign: 1'd0, exponent: 8'd0, fraction: 23'd0}); 
    Reg#(Fpnum) fp_b <- mkReg(Fpnum{ sign: 1'd0, exponent: 8'd0, fraction: 23'd0}); 
    Reg#(Fpnum) fp_c <- mkReg(Fpnum{ sign: 1'd0, exponent: 8'd0, fraction: 23'd0}); 
    Reg#(Bool) got_A <- mkReg(False);
    Reg#(Bool) got_B <- mkReg(False); 
    Reg#(Bool) expdiff_calculated <- mkReg(False);
    Reg#(Bit#(8)) expdiff <- mkReg(0);
    
    function Bit#(8) rca_8bit(Bit#(8) a, Bit#(8) c);
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
    endfunction:rca_8bit
    
    function Bit#(8) twos_compliment(Bit#(8) num);
	Bit#(8) mask = 8'hFF;
	Bit#(8) temp = 8'd0;
	temp = num ^ mask;
	temp = rca_8bit(temp,1);
	return temp;
    endfunction:twos_compliment
    
    rule calculate_expdiff(got_A == True && got_B == True && expdiff_calculated == False);
    	expdiff_calculated <= True;
    	expdiff <= rca_8bit(fp_a.exponent, twos_compliment(fp_b.exponent));
    endrule
    
    method Action get_A(Bit#(16) a) if (!got_A);
        got_A <= True;
        fp_a <= Fpnum{ sign: a[15], exponent: a[14:7], fraction: {a[6:0],16'b0} };
    endmethod

    method Action get_B(Bit#(32) b) if (!got_B);
        got_B <= True;
        fp_b <= Fpnum{ sign: b[31], exponent: b[30:23], fraction: b[22:0] };
    endmethod

    method Fpnum out_AaddB();
        return fp_c; 
    endmethod

endmodule: mkfp32_add
endpackage

