package systolic_array;

import FIFO::*;
import SpecialFIFOs::*;

import MAC_types ::*;
import MAC_with_wrapper ::*;

interface Ifc_systolic_array;
method Action get_A1(Input_16 a);
method Action get_B1(Input_16 b);
method Action get_C1(Input_32 c);
method Action get_S1_or_S2(Input_1 s1_or_s2);
method ActionValue#(Bit#(32)) output_MAC();

endinterface: Ifc_systolic_array

(* synthesize *)
module mksystolic_array(Ifc_systolic_array);

    FIFO#(Input_16)     inpA1_fifo <- mkPipelineFIFO();
    FIFO#(Input_16)     inpB1_fifo <- mkPipelineFIFO();
    FIFO#(Input_32)     inpC1_fifo <- mkPipelineFIFO();
    FIFO#(Input_1)      inpS1_fifo <- mkPipelineFIFO();
    FIFO#(Bit#(32))     out2_fifo  <- mkPipelineFIFO();
    
    Ifc_MAC_with_wrapper  mac_1   <- mkMAC_with_wrapper;
    Ifc_MAC_with_wrapper  mac_2   <- mkMAC_with_wrapper;
    
    rule start;
        Input_16 inp_A = inpA1_fifo.first();
        //Input_16 inp_B = inpB1_fifo.first();
        Input_32 inp_C = inpC1_fifo.first();
        Input_1  inp_S = inpS1_fifo.first();
        
        mac_1.get_A(inp_A);
        //mac_1.get_B(inp_B);
        mac_1.get_C(inp_C);
        mac_1.get_S1_or_S2(inp_S);
    	
    	inpA1_fifo.deq();
    	//inpB1_fifo.deq();
    	inpC1_fifo.deq();
    	inpS1_fifo.deq();
    endrule
    
    rule startB;
        
        Input_16 inp_B = inpB1_fifo.first();
        mac_1.get_B(inp_B);
    	inpB1_fifo.deq();
    endrule
    
    rule start3;
        Bit#(32) temp <- mac_1.output_MAC();
        Bit#(32) inp_C = temp;
        mac_2.get_C(unpack(inp_C));
    endrule
    
    rule start2;
        Input_16 inp_A = mac_1.relay_A();
        Input_1  inp_S = mac_1.relay_S();
        
        mac_2.get_A(inp_A);
        mac_2.get_S1_or_S2(inp_S);
    endrule
    
    rule start2B;
        Input_16 inp_B = mac_1.relay_B();
        mac_2.get_B(inp_B);
    endrule
    
    rule start4;
        Bit#(32) temp <- mac_2.output_MAC();
        out2_fifo.enq(temp);
    endrule

    method Action get_A1(Input_16 a);
        inpA1_fifo.enq(a);
    endmethod

    method Action get_B1(Input_16 b);
        inpB1_fifo.enq(b);
    endmethod
    
    method Action get_C1(Input_32 c);
        inpC1_fifo.enq(c);
    endmethod

    method Action get_S1_or_S2(Input_1 s1_or_s2);
        inpS1_fifo.enq(s1_or_s2);
    endmethod 
    
    method ActionValue#(Bit#(32)) output_MAC();
      	Bit#(32) out = out2_fifo.first();
	out2_fifo.deq();
	return out;
    endmethod 


endmodule: mksystolic_array
endpackage

