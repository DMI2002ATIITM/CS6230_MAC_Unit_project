package MAC_int32;

interface Ifc_MAC_int;
method Action get_A(Bit#(16) a);
method Action get_B(Bit#(16) b);
method Action get_C(Bit#(32) c);
method Action get_S1_or_S2(Bit#(1) s1_or_s2);
method Bit#(32) output_MAC();
endinterface: Ifc_MAC_int

// Select Lower 8 bits for S1

(* synthesize *)
module mkMAC_int32(Ifc_MAC_int);
Reg#(Bit#(16)) rg_A <- mkReg(0);
Reg#(Bit#(16)) rg_B <- mkReg(0);
Reg#(Bit#(32)) rg_C <- mkReg(0);
Reg#(Bit#(1)) rg_S1_or_S2 <- mkReg(0);
Reg#(Bit#(32)) rg_MAC <- mkReg(0);

method Action get_A(Bit#(16) a);
rg_A <= a;
endmethod 

method Action get_B(Bit#(16) b);
rg_B <= b;
endmethod 

method Action get_C(Bit#(32) c);
rg_C <= c;
endmethod 

method Action get_S1_or_S2(Bit#(1) s1_or_s2);
rg_S1_or_S2 <= s1_or_s2;
endmethod 

method Bit#(32) output_MAC();
return rg_MAC;
endmethod 



endmodule:mkMAC_int32
endpackage
