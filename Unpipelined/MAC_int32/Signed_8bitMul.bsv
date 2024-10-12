package Signed_8bitMul;

interface Ifc_Signed_8bitMul;
method Action get_A(Bit#(8) a);
method Action get_B(Bit#(8) b);
method ActionValue #(Bit#(16)) output_Mul();
endinterface: Ifc_Signed_8bitMul

(* synthesize *)
module mkSigned_8bitMul(Ifc_Signed_8bitMul);
Reg#(Bit#(16)) rg_A <- mkReg(0);
Reg#(Bit#(16)) rg_B <- mkReg(0);
Reg#(Bit#(16)) rg_AB <- mkReg(0);
Reg#(Bool) got_A <- mkReg(False);
Reg#(Bool) got_B <- mkReg(False);
Reg#(Bool) completed <- mkReg(False);
Reg#(Bit#(16)) partial_store <- mkReg(0);
Reg#(Bit#(5)) count <- mkReg(16);

rule rl_multiply(got_A && got_B && count != 5'd0);
if(rg_B[0] == 1)
begin
	partial_store <= partial_store + rg_A; // TODO Must implement "+" as adder
end
rg_A <= rg_A << 1;
rg_B <= rg_B >> 1;
count <= count - 1; 
if(count == 5'd1)
begin
	completed <= True;
end
endrule

method Action get_A(Bit#(8) a) if(! got_A);
completed <= False;
rg_A <= signExtend(a);
got_A <= True;
endmethod 

method Action get_B(Bit#(8) b) if(! got_B);
rg_B <= signExtend(b);
got_B <= True;
endmethod 

method ActionValue #(Bit#(16)) output_Mul();
if(completed == True)
begin
	got_A <= False;
	got_B <= False;
	rg_AB <= partial_store;
	partial_store <= 0;
	count <= 16;
end
return signExtend(rg_AB);
endmethod 



endmodule:mkSigned_8bitMul
endpackage
