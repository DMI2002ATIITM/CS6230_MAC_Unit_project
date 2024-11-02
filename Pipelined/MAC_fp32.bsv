package MAC_fp32;

import FIFO::*;
import SpecialFIFOs::*;

import MAC_types ::*;
import bf16_mul ::*;
import fp32_add ::*;

interface Ifc_MAC_fp32;
method Action get_A(Input_16 a);
method Action get_B(Input_16 b);
method Action get_C(Input_32 c);
method ActionValue#(Bit#(32)) foutput_MAC();
endinterface: Ifc_MAC_fp32

(* synthesize *)
module mkMAC_fp32(Ifc_MAC_fp32);

    FIFO#(Input_16)     inpA_fifo <- mkPipelineFIFO();
    FIFO#(Input_16)     inpB_fifo <- mkPipelineFIFO();
    FIFO#(Input_32)     inpC_fifo <- mkPipelineFIFO();
    FIFO#(Bit#(16))     ab_fifo <- mkPipelineFIFO();
    FIFO#(Bit#(32))     abc_fifo <- mkPipelineFIFO();
	
    // Float multiplication
    Ifc_bf16_mul fmul <- mkbf16_mul;
    Reg#(Bool) mul_initiated <- mkReg(False);
    Reg#(Bit#(16)) rg_a <- mkReg(0); 
    Reg#(Bit#(16)) rg_b <- mkReg(0);  
    
    // Float addition
    Ifc_fp32_add fadd <- mkfp32_add;
    Reg#(Bit#(32)) rg_c <- mkReg(0); 
    Reg#(Bool) fmac_completed <- mkReg(False);
    Reg#(Bool) add_initiated <- mkReg(False);
    Reg#(Bool) init_done <- mkReg(False);
    
    rule init(init_done == False);
        rg_a <= pack(inpA_fifo.first());
        rg_b <= pack(inpB_fifo.first());
        rg_c <= pack(inpC_fifo.first());
        inpA_fifo.deq();
        inpB_fifo.deq();
        inpC_fifo.deq();
        init_done <= True;
    endrule
        
    rule do_mul(init_done == True && mul_initiated == False);
    	fmul.get_A(rg_a);
    	fmul.get_B(rg_b);	
        mul_initiated <= True;
    endrule
    
    rule get_mulres;
    	ab_fifo.enq(pack(fmul.out_AB()));
    endrule
    
    rule do_add;
        Bit#(16) ab = ab_fifo.first();
        ab_fifo.deq();
    	fadd.get_A(ab);
    	fadd.get_B(rg_c);
    	add_initiated <= True;
    endrule
    
    rule get_addres(add_initiated == True);
    	abc_fifo.enq(pack(fadd.out_AaddB()));
    	fmac_completed <= True;
    endrule
    
    rule restore_mac(fmac_completed == True);
    	fmac_completed <= False;
    	mul_initiated <= False;
    	add_initiated <= False;
    	init_done <= False;
    endrule
    
    method Action get_A(Input_16 a);
        inpA_fifo.enq(a);
    endmethod

    method Action get_B(Input_16 b);
        inpB_fifo.enq(b);
    endmethod
    
    method Action get_C(Input_32 c);
        inpC_fifo.enq(c);
    endmethod

    method ActionValue#(Bit#(32)) foutput_MAC();
        Bit#(32) out = abc_fifo.first();
        abc_fifo.deq();
        return out;
    endmethod 

endmodule: mkMAC_fp32
endpackage
