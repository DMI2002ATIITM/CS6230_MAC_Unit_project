package MAC_unpipelined;

import MAC_int32 ::*;
import MAC_fp32 ::*;
import bf16_mul ::*;
import fp32_add ::*;

interface Ifc_MAC_unpipelined;
method Action get_A(Bit#(16) a);
method Action get_B(Bit#(16) b);
method Action get_C(Bit#(32) c);
method Action get_S1_or_S2(Bit#(1) s1_or_s2);
method Bit#(32) output_MAC();
endinterface: Ifc_MAC_unpipelined

(* synthesize *)
module mkMAC_unpipelined(Ifc_MAC_unpipelined);

    Reg#(Bool) got_A <- mkReg(False);
    Reg#(Bool) got_B <- mkReg(False);
    Reg#(Bool) got_C <- mkReg(False);
    Reg#(Bool) got_s1_or_s2 <- mkReg(False);
    Reg#(Bit#(16)) rg_a <- mkReg(0);
    Reg#(Bit#(16)) rg_b <- mkReg(0);
    Reg#(Bit#(32)) rg_c <- mkReg(0);
    Reg#(Bit#(1)) rg_S1_or_S2 <- mkReg(0);
    Reg#(Bool) mac_completed <- mkReg(False);
    Reg#(Bit#(32)) mac_output <- mkReg(0);
    Reg#(Bool) called_MAC <- mkReg(False);
    Reg#(Bool) got_output <- mkReg(False);
    Reg#(Bit#(32)) int_output <- mkReg(0);
    Reg#(Fpnum) float_output <- mkReg(Fpnum{ sign: 1'd0, exponent: 8'd0, fraction: 23'd0}); 
    
    Ifc_MAC_int int_MAC <- mkMAC_int32;
    Ifc_MAC_fp32 float_MAC <- mkMAC_fp32;
    
    rule call_MAC(got_A == True && got_B == True && got_C == True && got_s1_or_s2 == True && called_MAC == False);
    	called_MAC <= True;
    	if(rg_S1_or_S2 == 1'd0)
    	begin
    		int_MAC.get_A(rg_a);
    		int_MAC.get_B(rg_b);
    		int_MAC.get_C(rg_c);
    	end
    	else
    	begin
    		float_MAC.get_A(rg_a);
    		float_MAC.get_B(rg_b);
    		float_MAC.get_C(rg_c);
    	end
    endrule
    
    rule get_output_from_intMAC(got_A == True && got_B == True && got_C == True && got_s1_or_s2 == True && called_MAC == True && got_output == False && rg_S1_or_S2 == 1'd0);
    	got_output <= True;
    	mac_output <= pack(int_MAC.ioutput_MAC());
    endrule
    
    rule get_output_from_floatMAC(got_A == True && got_B == True && got_C == True && got_s1_or_s2 == True && called_MAC == True && got_output == False && rg_S1_or_S2 == 1'd1);
    	got_output <= True;
	mac_output <= pack(float_MAC.foutput_MAC());
    endrule

    rule deassert_got_output(got_output == True);
    	got_A <= False;
    	got_B <= False;
    	got_C <= False;
    	got_s1_or_s2 <= False;
    	called_MAC <= False;
    	got_output <= False;
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

    method Action get_S1_or_S2(Bit#(1) s1_or_s2) if(!got_s1_or_s2);
        got_s1_or_s2 <= True;
        rg_S1_or_S2 <= s1_or_s2;
    endmethod 

    method Bit#(32) output_MAC() if(got_output == True);
        return mac_output;
    endmethod 

endmodule: mkMAC_unpipelined
endpackage

