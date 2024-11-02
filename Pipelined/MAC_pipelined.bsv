package MAC_pipelined;

import FIFO::*;
import SpecialFIFOs::*;

import MAC_types ::*;
import MAC_int32 ::*;
import MAC_fp32 ::*;
import bf16_mul ::*;
import fp32_add ::*;

interface Ifc_MAC_pipelined;
method Action get_A(Input_16 a);
method Action get_B(Input_16 b);
method Action get_C(Input_32 c);
method Action get_S1_or_S2(Input_1 s1_or_s2);
method ActionValue#(Bit#(32)) output_MAC();
endinterface: Ifc_MAC_pipelined

(* synthesize *)
module mkMAC_pipelined(Ifc_MAC_pipelined);

    FIFO#(Input_16)     inpA_fifo <- mkPipelineFIFO();
    FIFO#(Input_16)     inpB_fifo <- mkPipelineFIFO();
    FIFO#(Input_32)     inpC_fifo <- mkPipelineFIFO();
    FIFO#(Input_1)      inpS_fifo <- mkPipelineFIFO();
    FIFO#(Bit#(32))     out_fifo  <- mkPipelineFIFO();
    
    Reg#(Input_1) rg_S1_or_S2 <- mkReg(Input_1{val: 1'd0});
    Reg#(Bool) got_output <- mkReg(False);
    Reg#(Bit#(32)) int_output <- mkReg(0);
    Reg#(Fpnum) float_output <- mkReg(Fpnum{ sign: 1'd0, exponent: 8'd0, fraction: 23'd0}); 
    
    Ifc_MAC_int int_MAC <- mkMAC_int32;
    Ifc_MAC_fp32 float_MAC <- mkMAC_fp32;
    
    rule call_MAC;
        Input_16 inp_A = inpA_fifo.first();
        Input_16 inp_B = inpB_fifo.first();
        Input_32 inp_C = inpC_fifo.first();
        Input_1  inp_S = inpS_fifo.first();
        
    	if(inp_S.val == 1'd0)
    	begin
    		int_MAC.get_A(inp_A);
    		int_MAC.get_B(inp_B);
    		int_MAC.get_C(inp_C);
    	end
    	else
    	begin
    		float_MAC.get_A(inp_A);
    		float_MAC.get_B(inp_B);
    		float_MAC.get_C(inp_C);
    	end
    	rg_S1_or_S2.val <= inp_S.val;
    	inpA_fifo.deq();
    	inpB_fifo.deq();
    	inpC_fifo.deq();
    	inpS_fifo.deq();
    endrule
    
    rule get_output_from_intMAC(rg_S1_or_S2.val == 1'd0);
        Bit#(32) temp <- int_MAC.ioutput_MAC();
    	out_fifo.enq(temp);
    endrule
    
    rule get_output_from_floatMAC(rg_S1_or_S2.val == 1'd1);
        Bit#(32) temp <- float_MAC.foutput_MAC();
	out_fifo.enq(temp);
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

    method Action get_S1_or_S2(Input_1 s1_or_s2);
        inpS_fifo.enq(s1_or_s2);
    endmethod 

    method ActionValue#(Bit#(32)) output_MAC();
      	Bit#(32) out = out_fifo.first();
	out_fifo.deq();
	return out;
    endmethod 

endmodule: mkMAC_pipelined
endpackage

