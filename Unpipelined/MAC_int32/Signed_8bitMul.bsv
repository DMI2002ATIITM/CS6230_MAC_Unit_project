package Signed_8bitMul;

interface Ifc_Signed_8bitMul;
method Action get_A(Bit#(8) a);
method Action get_B(Bit#(8) b);
method ActionValue #(Bit#(16)) output_Mul();
endinterface: Ifc_Signed_8bitMul

(* synthesize *)
module mkSigned_8bitMul(Ifc_Signed_8bitMul);
Reg#(Bit#(8)) rg_A <- mkReg(0);
Reg#(Bit#(8)) rg_B <- mkReg(0);
Reg#(Bit#(16)) rg_AB <- mkReg(0);
Reg#(Bool) got_A <- mkReg(False);
Reg#(Bool) got_B <- mkReg(False);
Reg#(Bool) completed <- mkReg(False);
Reg#(Bit#(16)) partial_store <- mkReg(0);

rule rl_multiply(got_A && got_B && rg_B != 8'd0);
completed <= False;
if(rg_B[0] == 1)
begin
	partial_store <= partial_store + signExtend(rg_A); // TODO Must implement "+" as adder
end
rg_A <= rg_A << 1;
rg_B <= rg_B >> 1;
endrule

method Action get_A(Bit#(8) a) if(! got_A);
rg_A <= a;
got_A <= True;
endmethod 

method Action get_B(Bit#(8) b) if(! got_B);
rg_B <= b;
got_B <= True;
endmethod 

method ActionValue #(Bit#(16)) output_Mul();
if(rg_B == 8'd0)
begin
	got_A <= False;
	got_B <= False;
	completed <= True;
	rg_AB <= partial_store;
end
return rg_AB;
endmethod 



endmodule:mkSigned_8bitMul
endpackage
