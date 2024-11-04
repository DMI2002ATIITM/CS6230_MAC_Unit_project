package MAC_with_wrapper;

import FIFO::*;
import SpecialFIFOs::*;

import MAC_types ::*;
import MAC_int32_pipelined ::*;
import MAC_fp32_pipelined  ::*;
import bf16_mul_pipelined  ::*;
import fp32_add_pipelined  ::*;

interface Ifc_MAC_with_wrapper;
method Action get_A(Input_16 a);
method Action get_B(Input_16 b);
method Action get_C(Input_32 c);
method Action get_S1_or_S2(Input_1 s1_or_s2);
method ActionValue#(Bit#(32)) output_MAC();
method Input_16 relay_A();
method Input_16 relay_B();
method Input_1 relay_S();
endinterface: Ifc_MAC_with_wrapper

(* synthesize *)
module mkMAC_with_wrapper(Ifc_MAC_with_wrapper);

    Wire#(Input_16) wr_A <- mkWire();

    Wire#(Input_1)  wr_S <- mkWire();

    FIFO#(Input_16)     inpA_fifo <- mkPipelineFIFO();
    FIFO#(Input_16)     inpB_fifo <- mkPipelineFIFO();
    FIFO#(Input_32)     inpC_fifo <- mkPipelineFIFO();
    FIFO#(Input_1)      inpS_fifo <- mkPipelineFIFO();
    FIFO#(Bit#(32))     out_fifo  <- mkPipelineFIFO();
    
    Reg#(Bit#(32)) int_output <- mkReg(0);
    Reg#(Input_1) rg_S1_or_S2 <- mkReg(Input_1{val: 1'd0});
    Reg#(Fpnum) float_output <- mkReg(Fpnum{ sign: 1'd0, exponent: 8'd0, fraction: 23'd0}); 
    Reg#(Bool) got_output <- mkReg(False);
    Reg#(Input_16) rg_B <- mkReg(Input_16{val: 16'd0});
    Reg#(Input_16) send_B <- mkReg(Input_16{val: 16'd0});
    Reg#(Bool) first_data <- mkReg(True);
    Reg#(Bool) send_nxt <- mkReg(False);
    
    Ifc_MAC_int_pipelined  int_MAC   <- mkMAC_int32_pipelined;
    Ifc_MAC_fp32_pipelined float_MAC <- mkMAC_fp32_pipelined;
    
    rule call_MAC;
        Input_16 inp_A = inpA_fifo.first();

        Input_32 inp_C = inpC_fifo.first();
        Input_1  inp_S = inpS_fifo.first();
        
        wr_A <= inp_A;

        wr_S <= inp_S;
        
    	if(inp_S.val == 1'd0)
    	begin
    		int_MAC.get_A(inp_A);
    		int_MAC.get_B(rg_B);
    		int_MAC.get_C(inp_C);
    	end
    	else
    	begin
    		float_MAC.get_A(inp_A);
    		float_MAC.get_B(rg_B);
    		float_MAC.get_C(inp_C);
    	end
    	rg_S1_or_S2.val <= inp_S.val;
    	inpA_fifo.deq();

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

    rule deassert_send_nxt(send_nxt == True);
    	send_nxt <= False;
    endrule

    method Action get_A(Input_16 a);
        inpA_fifo.enq(a);
    endmethod

    method Action get_B(Input_16 b);
    	if(first_data == True)
    	begin
	    	rg_B <= b;
	    	first_data <= False;
    	end
    	else
    	begin
    		send_B <= rg_B;
    		rg_B <= b;
    		send_nxt <= True;
    	end
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
    
    method Input_16 relay_A();
    	return wr_A;
    endmethod
    
    method Input_16 relay_B() if (send_nxt == True);
    	return send_B;
    endmethod
    
    method Input_1 relay_S();
    	return wr_S;
    endmethod

endmodule: mkMAC_with_wrapper
endpackage

