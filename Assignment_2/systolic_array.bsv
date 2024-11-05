package systolic_array;

import FIFO::*;
import SpecialFIFOs::*;

import MAC_types ::*;
import MAC_with_wrapper ::*;

interface Ifc_systolic_array;
method Action get_A1(Input_16 a);
method Action get_A2(Input_16 a);
method Action get_A3(Input_16 a);
method Action get_A4(Input_16 a);

method Action get_B1(Input_16 b);
method Action get_C1(Input_32 c);
method Action get_S1_or_S2(Input_1 s1_or_s2);
method ActionValue#(Bit#(32)) output_MAC();

endinterface: Ifc_systolic_array

(* synthesize *)
module mksystolic_array(Ifc_systolic_array);

    FIFO#(Input_16)     inpA1_fifo <- mkPipelineFIFO();
    FIFO#(Input_16)     inpA2_fifo <- mkPipelineFIFO();
    FIFO#(Input_16)     inpA3_fifo <- mkPipelineFIFO();
    FIFO#(Input_16)     inpA4_fifo <- mkPipelineFIFO();
    
    FIFO#(Input_16)     inpB1_fifo <- mkPipelineFIFO();
    FIFO#(Input_32)     inpC1_fifo <- mkPipelineFIFO();
    FIFO#(Input_1)      inpS1_fifo <- mkPipelineFIFO();
    FIFO#(Bit#(32))     out_fifo  <- mkPipelineFIFO();
    
    Ifc_MAC_with_wrapper  mac_1   <- mkMAC_with_wrapper;
    Ifc_MAC_with_wrapper  mac_2   <- mkMAC_with_wrapper;
    Ifc_MAC_with_wrapper  mac_3   <- mkMAC_with_wrapper;
    Ifc_MAC_with_wrapper  mac_4   <- mkMAC_with_wrapper;
    
    rule get_ext_inp;
        //Input_16 inp_A = inpA1_fifo.first();
        Input_32 inp_C = inpC1_fifo.first();
        Input_1  inp_S = inpS1_fifo.first();
        
        //mac_1.get_A(inp_A);
        mac_1.get_C(inp_C);
        mac_1.get_S1_or_S2(inp_S);
    	
    	//inpA1_fifo.deq();
    	inpC1_fifo.deq();
    	inpS1_fifo.deq();
    endrule
    
    rule get_inpA1;
    	Input_16 inp_A = inpA1_fifo.first();
    	mac_1.get_A(inp_A);
    	inpA1_fifo.deq();
    endrule
    
    rule get_inpA2;
    	Input_16 inp_A = inpA2_fifo.first();
    	mac_2.get_A(inp_A);
    	inpA2_fifo.deq();
    endrule
    
    rule get_inpA3;
    	Input_16 inp_A = inpA3_fifo.first();
    	mac_3.get_A(inp_A);
    	inpA3_fifo.deq();
    endrule
    
    rule get_inpA4;
    	Input_16 inp_A = inpA4_fifo.first();
    	mac_4.get_A(inp_A);
    	inpA4_fifo.deq();
    endrule
    
    rule relay_as_1_2;
        //Input_16 inp_A = mac_1.relay_A();
        Input_1  inp_S = mac_1.relay_S();
        
        //mac_2.get_A(inp_A);
        mac_2.get_S1_or_S2(inp_S);
    endrule
    
    rule relay_as_2_3;
        //Input_16 inp_A = mac_2.relay_A();
        Input_1  inp_S = mac_2.relay_S();
        
        //mac_3.get_A(inp_A);
        mac_3.get_S1_or_S2(inp_S);
    endrule
    
    rule relay_as_3_4;
        //Input_16 inp_A = mac_3.relay_A();
        Input_1  inp_S = mac_3.relay_S();
        
        //mac_4.get_A(inp_A);
        mac_4.get_S1_or_S2(inp_S);
    endrule
    
    rule relay_c_1_2;
        Bit#(32) temp <- mac_1.output_MAC();
        Bit#(32) inp_C = temp;
        mac_2.get_C(unpack(inp_C));
    endrule
    
    rule relay_c_2_3;
        Bit#(32) temp <- mac_2.output_MAC();
        Bit#(32) inp_C = temp;
        mac_3.get_C(unpack(inp_C));
    endrule
    
    rule relay_c_3_4;
        Bit#(32) temp <- mac_3.output_MAC();
        Bit#(32) inp_C = temp;
        mac_4.get_C(unpack(inp_C));
    endrule
    
    rule outp;
        Bit#(32) temp <- mac_4.output_MAC();
        out_fifo.enq(temp);
    endrule
    
    rule get_ext_inpB;    
        Input_16 inp_B = inpB1_fifo.first();
        mac_1.get_B(inp_B);
    	inpB1_fifo.deq();
    endrule
    
    rule relay_b_1_2;
        Input_16 inp_B = mac_1.relay_B();
        mac_2.get_B(inp_B);
    endrule
    
    rule relay_b_2_3;
        Input_16 inp_B = mac_2.relay_B();
        mac_3.get_B(inp_B);
    endrule
    
    rule relay_b_3_4;
        Input_16 inp_B = mac_3.relay_B();
        mac_4.get_B(inp_B);
    endrule

    method Action get_A1(Input_16 a);
        inpA1_fifo.enq(a);
    endmethod
    
    method Action get_A2(Input_16 a);
        inpA2_fifo.enq(a);
    endmethod
    
    method Action get_A3(Input_16 a);
        inpA3_fifo.enq(a);
    endmethod
    
    method Action get_A4(Input_16 a);
        inpA4_fifo.enq(a);
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
      	Bit#(32) out = out_fifo.first();
	out_fifo.deq();
	return out;
    endmethod 


endmodule: mksystolic_array
endpackage

