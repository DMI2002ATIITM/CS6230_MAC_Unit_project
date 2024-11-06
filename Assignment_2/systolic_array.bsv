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
method Action get_B2(Input_16 b);
method Action get_B3(Input_16 b);
method Action get_B4(Input_16 b);

method Action get_C1(Input_32 c);
method Action get_C2(Input_32 c);
method Action get_C3(Input_32 c);
method Action get_C4(Input_32 c);

method Action get_S1(Input_1 s);
method Action get_S2(Input_1 s);
method Action get_S3(Input_1 s);
method Action get_S4(Input_1 s);

method ActionValue#(Bit#(32)) output1_MAC();
method ActionValue#(Bit#(32)) output2_MAC();
method ActionValue#(Bit#(32)) output3_MAC();
method ActionValue#(Bit#(32)) output4_MAC();

endinterface: Ifc_systolic_array

(* synthesize *)
module mksystolic_array(Ifc_systolic_array);

    FIFO#(Input_16)     inpA1_fifo <- mkPipelineFIFO();
    FIFO#(Input_16)     inpA2_fifo <- mkPipelineFIFO();
    FIFO#(Input_16)     inpA3_fifo <- mkPipelineFIFO();
    FIFO#(Input_16)     inpA4_fifo <- mkPipelineFIFO();
    
    FIFO#(Input_16)     inpB1_fifo <- mkPipelineFIFO();
    FIFO#(Input_16)     inpB2_fifo <- mkPipelineFIFO();
    FIFO#(Input_16)     inpB3_fifo <- mkPipelineFIFO();
    FIFO#(Input_16)     inpB4_fifo <- mkPipelineFIFO();
    
    FIFO#(Input_32)     inpC1_fifo <- mkPipelineFIFO();
    FIFO#(Input_32)     inpC2_fifo <- mkPipelineFIFO();
    FIFO#(Input_32)     inpC3_fifo <- mkPipelineFIFO();
    FIFO#(Input_32)     inpC4_fifo <- mkPipelineFIFO();
    
    FIFO#(Input_1)      inpS1_fifo <- mkPipelineFIFO();
    FIFO#(Input_1)      inpS2_fifo <- mkPipelineFIFO();
    FIFO#(Input_1)      inpS3_fifo <- mkPipelineFIFO();
    FIFO#(Input_1)      inpS4_fifo <- mkPipelineFIFO();
    
    FIFO#(Bit#(32))     out1_fifo  <- mkPipelineFIFO();
    FIFO#(Bit#(32))     out2_fifo  <- mkPipelineFIFO();
    FIFO#(Bit#(32))     out3_fifo  <- mkPipelineFIFO();
    FIFO#(Bit#(32))     out4_fifo  <- mkPipelineFIFO();
    
    Ifc_MAC_with_wrapper  mac_1    <- mkMAC_with_wrapper;
    Ifc_MAC_with_wrapper  mac_2    <- mkMAC_with_wrapper;
    Ifc_MAC_with_wrapper  mac_3    <- mkMAC_with_wrapper;
    Ifc_MAC_with_wrapper  mac_4    <- mkMAC_with_wrapper;
    
    Ifc_MAC_with_wrapper  mac_5    <- mkMAC_with_wrapper;
    Ifc_MAC_with_wrapper  mac_6    <- mkMAC_with_wrapper;
    Ifc_MAC_with_wrapper  mac_7    <- mkMAC_with_wrapper;
    Ifc_MAC_with_wrapper  mac_8    <- mkMAC_with_wrapper;
    
    Ifc_MAC_with_wrapper  mac_9    <- mkMAC_with_wrapper;
    Ifc_MAC_with_wrapper  mac_10   <- mkMAC_with_wrapper;
    Ifc_MAC_with_wrapper  mac_11   <- mkMAC_with_wrapper;
    Ifc_MAC_with_wrapper  mac_12   <- mkMAC_with_wrapper;
    
    Ifc_MAC_with_wrapper  mac_13    <- mkMAC_with_wrapper;
    Ifc_MAC_with_wrapper  mac_14   <- mkMAC_with_wrapper;
    Ifc_MAC_with_wrapper  mac_15   <- mkMAC_with_wrapper;
    Ifc_MAC_with_wrapper  mac_16   <- mkMAC_with_wrapper;
    

///////////////////////////////////////////////////////////////////////////////////////////////////    
    // Handling input A for all MACs
    
    // First row A input
    rule get_ext_inpA1;
    	Input_16 inp_A = inpA1_fifo.first();
    	mac_1.get_A(inp_A);
    	inpA1_fifo.deq();
    endrule
    
    rule relay_a_1_5;
        Input_16  inp_A = mac_1.relay_A();
        mac_5.get_A(inp_A);
    endrule
    
    rule relay_a_5_9;
        Input_16  inp_A = mac_5.relay_A();
        mac_9.get_A(inp_A);
    endrule
    
    rule relay_a_9_13;
        Input_16  inp_A = mac_9.relay_A();
        mac_13.get_A(inp_A);
    endrule
    
    // Second row A input
    rule get_ext_inpA2;
    	Input_16 inp_A = inpA2_fifo.first();
    	mac_2.get_A(inp_A);
    	inpA2_fifo.deq();
    endrule
    
    rule relay_a_2_6;
        Input_16  inp_A = mac_2.relay_A();
        mac_6.get_A(inp_A);
    endrule
    
    rule relay_a_6_10;
        Input_16  inp_A = mac_6.relay_A();
        mac_10.get_A(inp_A);
    endrule
    
    rule relay_a_10_14;
        Input_16  inp_A = mac_10.relay_A();
        mac_14.get_A(inp_A);
    endrule
    
    // Third row A input
    rule get_ext_inpA3;
    	Input_16 inp_A = inpA3_fifo.first();
    	mac_3.get_A(inp_A);
    	inpA3_fifo.deq();
    endrule
    
    rule relay_a_3_7;
        Input_16  inp_A = mac_3.relay_A();
        mac_7.get_A(inp_A);
    endrule
    
    rule relay_a_7_11;
        Input_16  inp_A = mac_7.relay_A();
        mac_11.get_A(inp_A);
    endrule
    
    rule relay_a_11_15;
        Input_16  inp_A = mac_11.relay_A();
        mac_15.get_A(inp_A);
    endrule
    
    // Fourth row A input
    rule get_ext_inpA4;
    	Input_16 inp_A = inpA4_fifo.first();
    	mac_4.get_A(inp_A);
    	inpA4_fifo.deq();
    endrule
    
    rule relay_a_4_8;
        Input_16  inp_A = mac_4.relay_A();
        mac_8.get_A(inp_A);
    endrule
    
    rule relay_a_8_12;
        Input_16  inp_A = mac_8.relay_A();
        mac_12.get_A(inp_A);
    endrule
    
    rule relay_a_12_16;
        Input_16  inp_A = mac_12.relay_A();
        mac_16.get_A(inp_A);
    endrule
///////////////////////////////////////////////////////////////////////////////////////////////////    



///////////////////////////////////////////////////////////////////////////////////////////////////    
    // Handling input B for all MACs
    
    // First column B input
    rule get_ext_inpB1;    
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
    
    // Second column B input
    rule get_ext_inpB2;    
        Input_16 inp_B = inpB2_fifo.first();
        mac_5.get_B(inp_B);
    	inpB2_fifo.deq();
    endrule
    
    rule relay_b_5_6;
        Input_16 inp_B = mac_5.relay_B();
        mac_6.get_B(inp_B);
    endrule
    
    rule relay_b_6_7;
        Input_16 inp_B = mac_6.relay_B();
        mac_7.get_B(inp_B);
    endrule
    
    rule relay_b_7_8;
        Input_16 inp_B = mac_7.relay_B();
        mac_8.get_B(inp_B);
    endrule
    
    // Third column B input
    rule get_ext_inpB3;    
        Input_16 inp_B = inpB3_fifo.first();
        mac_9.get_B(inp_B);
    	inpB3_fifo.deq();
    endrule
    
    rule relay_b_9_10;
        Input_16 inp_B = mac_9.relay_B();
        mac_10.get_B(inp_B);
    endrule
    
    rule relay_b_10_11;
        Input_16 inp_B = mac_10.relay_B();
        mac_11.get_B(inp_B);
    endrule
    
    rule relay_b_11_12;
        Input_16 inp_B = mac_11.relay_B();
        mac_12.get_B(inp_B);
    endrule
    
    // Fourth column B input
    rule get_ext_inpB4;    
        Input_16 inp_B = inpB4_fifo.first();
        mac_13.get_B(inp_B);
    	inpB4_fifo.deq();
    endrule
    
    rule relay_b_13_14;
        Input_16 inp_B = mac_13.relay_B();
        mac_14.get_B(inp_B);
    endrule
    
    rule relay_b_14_15;
        Input_16 inp_B = mac_14.relay_B();
        mac_15.get_B(inp_B);
    endrule
    
    rule relay_b_15_16;
        Input_16 inp_B = mac_15.relay_B();
        mac_16.get_B(inp_B);
    endrule
///////////////////////////////////////////////////////////////////////////////////////////////////


    
///////////////////////////////////////////////////////////////////////////////////////////////////    
    // Handling input C for all MACs    
    
    // First column C input
    rule get_ext_inpC1;
        Input_32 inp_C = inpC1_fifo.first();
        mac_1.get_C(inp_C);
    	inpC1_fifo.deq();
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
    
    // Second column C input
    rule get_ext_inpC2;
        Input_32 inp_C = inpC2_fifo.first();
        mac_5.get_C(inp_C);
    	inpC2_fifo.deq();
    endrule
    
    rule relay_c_5_6;
        Bit#(32) temp <- mac_5.output_MAC();
        Bit#(32) inp_C = temp;
        mac_6.get_C(unpack(inp_C));
    endrule
    
    rule relay_c_6_7;
        Bit#(32) temp <- mac_6.output_MAC();
        Bit#(32) inp_C = temp;
        mac_7.get_C(unpack(inp_C));
    endrule
    
    rule relay_c_7_8;
        Bit#(32) temp <- mac_7.output_MAC();
        Bit#(32) inp_C = temp;
        mac_8.get_C(unpack(inp_C));
    endrule
    
    // Third column C input
    rule get_ext_inpC3;
        Input_32 inp_C = inpC3_fifo.first();
        mac_9.get_C(inp_C);
    	inpC3_fifo.deq();
    endrule
    
    rule relay_c_9_10;
        Bit#(32) temp <- mac_9.output_MAC();
        Bit#(32) inp_C = temp;
        mac_10.get_C(unpack(inp_C));
    endrule
    
    rule relay_c_10_11;
        Bit#(32) temp <- mac_10.output_MAC();
        Bit#(32) inp_C = temp;
        mac_11.get_C(unpack(inp_C));
    endrule
    
    rule relay_c_11_12;
        Bit#(32) temp <- mac_11.output_MAC();
        Bit#(32) inp_C = temp;
        mac_12.get_C(unpack(inp_C));
    endrule
    
    // Fourth column C input
    rule get_ext_inpC4;
        Input_32 inp_C = inpC4_fifo.first();
        mac_13.get_C(inp_C);
    	inpC4_fifo.deq();
    endrule
    
    rule relay_c_13_14;
        Bit#(32) temp <- mac_13.output_MAC();
        Bit#(32) inp_C = temp;
        mac_14.get_C(unpack(inp_C));
    endrule
    
    rule relay_c_14_15;
        Bit#(32) temp <- mac_14.output_MAC();
        Bit#(32) inp_C = temp;
        mac_15.get_C(unpack(inp_C));
    endrule
    
    rule relay_c_15_16;
        Bit#(32) temp <- mac_15.output_MAC();
        Bit#(32) inp_C = temp;
        mac_16.get_C(unpack(inp_C));
    endrule
///////////////////////////////////////////////////////////////////////////////////////////////////   



///////////////////////////////////////////////////////////////////////////////////////////////////           
    // Handling input S for all MACs
    
    // First column S input
    rule get_ext_inpS1;
        Input_1  inp_S = inpS1_fifo.first();
        mac_1.get_S1_or_S2(inp_S);
    	inpS1_fifo.deq();
    endrule
    
    rule relay_s_1_2;
        Input_1  inp_S = mac_1.relay_S();
        mac_2.get_S1_or_S2(inp_S);
    endrule
    
    rule relay_s_2_3;
        Input_1  inp_S = mac_2.relay_S();
        mac_3.get_S1_or_S2(inp_S);
    endrule
    
    rule relay_s_3_4;
        Input_1  inp_S = mac_3.relay_S();
        mac_4.get_S1_or_S2(inp_S);
    endrule
    
    // Second column S input
    rule get_ext_inpS2;
        Input_1  inp_S = inpS2_fifo.first();
        mac_5.get_S1_or_S2(inp_S);
    	inpS2_fifo.deq();
    endrule
    
    rule relay_s_5_6;
        Input_1  inp_S = mac_5.relay_S();
        mac_6.get_S1_or_S2(inp_S);
    endrule
    
    rule relay_s_6_7;
        Input_1  inp_S = mac_6.relay_S();
        mac_7.get_S1_or_S2(inp_S);
    endrule
    
    rule relay_s_7_8;
        Input_1  inp_S = mac_7.relay_S();
        mac_8.get_S1_or_S2(inp_S);
    endrule
    
    // Third column S input
    rule get_ext_inpS3;
        Input_1  inp_S = inpS3_fifo.first();
        mac_9.get_S1_or_S2(inp_S);
    	inpS3_fifo.deq();
    endrule
    
    rule relay_s_9_10;
        Input_1  inp_S = mac_9.relay_S();
        mac_10.get_S1_or_S2(inp_S);
    endrule
    
    rule relay_s_10_11;
        Input_1  inp_S = mac_10.relay_S();
        mac_11.get_S1_or_S2(inp_S);
    endrule
    
    rule relay_s_11_12;
        Input_1  inp_S = mac_11.relay_S();
        mac_12.get_S1_or_S2(inp_S);
    endrule
    
    // Fourth column S input
    rule get_ext_inpS4;
        Input_1  inp_S = inpS4_fifo.first();
        mac_13.get_S1_or_S2(inp_S);
    	inpS4_fifo.deq();
    endrule
    
    rule relay_s_13_14;
        Input_1  inp_S = mac_13.relay_S();
        mac_14.get_S1_or_S2(inp_S);
    endrule
    
    rule relay_s_14_15;
        Input_1  inp_S = mac_14.relay_S();
        mac_15.get_S1_or_S2(inp_S);
    endrule
    
    rule relay_s_15_16;
        Input_1  inp_S = mac_15.relay_S();
        mac_16.get_S1_or_S2(inp_S);
    endrule
///////////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////////    
    // Handling outputs for all MACs
    
    // First column output
    rule outp1;
        Bit#(32) temp <- mac_4.output_MAC();
        out1_fifo.enq(temp);
    endrule
    
    // Second column output
    rule outp2;
        Bit#(32) temp <- mac_8.output_MAC();
        out2_fifo.enq(temp);
    endrule
    
    // Third column output
    rule outp3;
        Bit#(32) temp <- mac_12.output_MAC();
        out3_fifo.enq(temp);
    endrule
    
    // Fourth column output
    rule outp4;
        Bit#(32) temp <- mac_16.output_MAC();
        out4_fifo.enq(temp);
    endrule
///////////////////////////////////////////////////////////////////////////////////////////////////    
    
    

///////////////////////////////////////////////////////////////////////////////////////////////////
    // Methods
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
    
    method Action get_B2(Input_16 b);
        inpB2_fifo.enq(b);
    endmethod
    
    method Action get_B3(Input_16 b);
        inpB3_fifo.enq(b);
    endmethod
    
    method Action get_B4(Input_16 b);
        inpB4_fifo.enq(b);
    endmethod
    
    method Action get_C1(Input_32 c);
        inpC1_fifo.enq(c);
    endmethod
    
    method Action get_C2(Input_32 c);
        inpC2_fifo.enq(c);
    endmethod
    
    method Action get_C3(Input_32 c);
        inpC3_fifo.enq(c);
    endmethod
    
    method Action get_C4(Input_32 c);
        inpC4_fifo.enq(c);
    endmethod

    method Action get_S1(Input_1 s1_or_s2);
        inpS1_fifo.enq(s1_or_s2);
    endmethod
    
    method Action get_S2(Input_1 s1_or_s2);
        inpS2_fifo.enq(s1_or_s2);
    endmethod 
    
    method Action get_S3(Input_1 s1_or_s2);
        inpS3_fifo.enq(s1_or_s2);
    endmethod 
    
    method Action get_S4(Input_1 s1_or_s2);
        inpS4_fifo.enq(s1_or_s2);
    endmethod 
    
    method ActionValue#(Bit#(32)) output1_MAC();
      	Bit#(32) out = out1_fifo.first();
	out1_fifo.deq();
	return out;
    endmethod 

    method ActionValue#(Bit#(32)) output2_MAC();
      	Bit#(32) out = out2_fifo.first();
	out2_fifo.deq();
	return out;
    endmethod
    
    method ActionValue#(Bit#(32)) output3_MAC();
      	Bit#(32) out = out3_fifo.first();
	out3_fifo.deq();
	return out;
    endmethod
    
    method ActionValue#(Bit#(32)) output4_MAC();
      	Bit#(32) out = out4_fifo.first();
	out4_fifo.deq();
	return out;
    endmethod

endmodule: mksystolic_array
endpackage

