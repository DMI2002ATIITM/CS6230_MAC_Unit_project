package MAC_fp32;

import bf16_mul ::*;
import fp32_add ::*;

interface Ifc_MAC_fp32;
method Action get_A(Bit#(16) a);
method Action get_B(Bit#(16) b);
method Action get_C(Bit#(32) c);
//method Action get_S1_or_S2(Bit#(1) s1_or_s2);
method Fpnum foutput_MAC();
endinterface: Ifc_MAC_fp32

(* synthesize *)
module mkMAC_fp32(Ifc_MAC_fp32);
	
    // Float multiplication
    Ifc_bf16_mul fmul <- mkbf16_mul;
    Reg#(Bool) got_A <- mkReg(False);
    Reg#(Bool) got_B <- mkReg(False);
    Reg#(Bool) got_C <- mkReg(False);
    //Reg#(Bool) got_s1_or_s2 <- mkReg(False);
    Reg#(Bool) mul_initiated <- mkReg(False);
    Reg#(Bool) mul_completed <- mkReg(False);
    //Reg#(Bit#(1)) rg_S1_or_S2 <- mkReg(0);
    Reg#(Bit#(16)) rg_a <- mkReg(0); 
    Reg#(Bit#(16)) rg_b <- mkReg(0);  
    Reg#(Bit#(16)) rg_ab <- mkReg(0); 
    
    // Float addition
    Ifc_fp32_add fadd <- mkfp32_add;
    Reg#(Bit#(32)) rg_c <- mkReg(0); 
    Reg#(Bool) fmac_completed <- mkReg(False);
    Reg#(Bool) add_initiated <- mkReg(False);
    Reg#(Fpnum) mac_output <- mkReg(Fpnum{ sign: 1'd0, exponent: 8'd0, fraction: 23'd0}); 
        
    rule do_mul(got_A == True && got_B == True && got_C == True && mul_initiated == False);
        mul_initiated <= True;
    	fmul.get_A(rg_a);
    	fmul.get_B(rg_b);	
    endrule
    
    rule get_mulres(mul_initiated == True);
    	mul_completed <= True;
    	rg_ab <= pack(fmul.out_AB());
    endrule
    
    rule do_add(got_A == True && got_B == True && got_C == True && mul_completed == True && add_initiated == False);
    	add_initiated <= True;
    	fadd.get_A(rg_ab);
    	fadd.get_B(rg_c);
    endrule
    
    rule get_addres(add_initiated == True);
    	fmac_completed <= True;
    	mac_output <= fadd.out_AaddB();
    endrule
    
    rule restore_mac(fmac_completed == True);
    	fmac_completed <= False;
    	mul_initiated <= False;
    	add_initiated <= False;
    	mul_completed <= False;
    	got_A <= False;
    	got_B <= False;
    	got_C <= False;
    endrule
    
    method Action get_A(Bit#(16) a) if (!got_A);
        got_A <= True;
        rg_a <= a;
    endmethod

    method Action get_B(Bit#(16) b) if (!got_B);
        got_B <= True;
        rg_b <= b;
    endmethod
    
    method Action get_C(Bit#(32) c) if (!got_C);
        got_C <= True;
        rg_c <= c;
    endmethod

    //method Action get_S1_or_S2(Bit#(1) s1_or_s2) if(!got_s1_or_s2);
    //    got_s1_or_s2 <= True;
    //    rg_S1_or_S2 <= s1_or_s2;
    //endmethod 

    method Fpnum foutput_MAC() if(fmac_completed == True);
        return mac_output;
    endmethod 

endmodule: mkMAC_fp32
endpackage
