package MAC_fp32_pipelined;

import FIFO::*;
import SpecialFIFOs::*;

import MAC_types ::*;
import bf16_mul_pipelined ::*;
import fp32_add_pipelined ::*;

interface Ifc_MAC_fp32_pipelined;
method Action get_A(Input_16 a);
method Action get_B(Input_16 b);
method Action get_C(Input_32 c);
method ActionValue#(Bit#(32)) foutput_MAC();
endinterface: Ifc_MAC_fp32_pipelined

(* synthesize *)
module mkMAC_fp32_pipelined(Ifc_MAC_fp32_pipelined);

    FIFO#(Input_16)     inpA_fifo <- mkPipelineFIFO();
    FIFO#(Input_16)     inpB_fifo <- mkPipelineFIFO();
    FIFO#(Input_32)     inpC_fifo <- mkPipelineFIFO();
    FIFO#(Bit#(16))     ab_fifo   <- mkPipelineFIFO();
    FIFO#(Bit#(32))     abc_fifo  <- mkPipelineFIFO();
	
    // Float multiplication
    Ifc_bf16_mul_pipelined fmul <- mkbf16_mul_pipelined;
    Reg#(Bit#(16)) rg_a <- mkReg(0); 
    Reg#(Bit#(16)) rg_b <- mkReg(0);  
    Reg#(Bool) mul_initiated <- mkReg(False);
    
    // Float addition
    Ifc_fp32_add_pipelined fadd <- mkfp32_add_pipelined;
    Reg#(Bit#(32)) rg_c <- mkReg(0); 
    Reg#(Bool) init_done <- mkReg(False);
    Reg#(Bool) add_initiated <- mkReg(False);
    Reg#(Bool) fmac_completed <- mkReg(False);
    
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
        Bfnum mulres_temp <- fmul.out_AB();
    	ab_fifo.enq(pack(mulres_temp));
    endrule
    
    rule do_add;
        Bit#(16) ab = ab_fifo.first();
        ab_fifo.deq();
    	fadd.get_A(ab);
    	fadd.get_B(rg_c);
    	add_initiated <= True;
    endrule
    
    rule get_addres(add_initiated == True);
        Fpnum addres_temp <- fadd.out_AaddB();
    	abc_fifo.enq(pack(addres_temp));
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

endmodule: mkMAC_fp32_pipelined
endpackage
