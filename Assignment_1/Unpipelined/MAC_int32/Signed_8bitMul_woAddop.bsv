package Signed_8bitMul_woAddop;

interface Ifc_Signed_8bitMul_woAddop;
method Action get_A(Bit#(8) a);
method Action get_B(Bit#(8) b);
method Maybe#(Bit#(16)) output_Mul();
endinterface: Ifc_Signed_8bitMul_woAddop

(* synthesize *)
module mkSigned_8bitMul_woAddop(Ifc_Signed_8bitMul_woAddop);
Reg#(Bit#(16)) rg_A <- mkReg(0);
Reg#(Bit#(16)) rg_B <- mkReg(0);
Reg#(Maybe#(Bit#(16))) rg_AB <- mkReg(tagged Invalid);
Reg#(Bool) got_A <- mkReg(False);
Reg#(Bool) got_B <- mkReg(False);
Reg#(Bool) completed <- mkReg(False);
Reg#(Bit#(16)) partial_store <- mkReg(0);
Reg#(Bit#(5)) count <- mkReg(16);

function Bit#(16) rca(Bit#(16) a, Bit#(16) b);
Bit#(16) outp = 0;
Bit#(1) carry = 0;
outp[0] = a[0] ^ b[0];
carry = a[0] & b[0];
for(Integer i = 1; i < 16; i = i + 1)
begin
	outp[i] = a[i] ^ b[i] ^ carry;
	carry = (a[i] & b[i]) | (a[i] ^ b[i]) & carry;
end

return outp;
endfunction:rca

rule rl_multiply(got_A && got_B && count != 5'd0);
if(rg_B[0] == 1)
begin
	partial_store <= rca(partial_store , rg_A);
end
rg_A <= rg_A << 1;
rg_B <= rg_B >> 1;
count <= count - 1; 
//if(count == 5'd1)
//begin
//	completed <= True;
//end
endrule

rule reset_state(count == 5'd0);
got_A <= False;
got_B <= False;
rg_AB <= tagged Valid partial_store;
partial_store <= 0;
count <= 16;
completed <= False;
endrule

method Action get_A(Bit#(8) a) if(! got_A);
rg_AB <= tagged Invalid;
rg_A <= signExtend(a);
got_A <= True;
endmethod 

method Action get_B(Bit#(8) b) if(! got_B);
rg_B <= signExtend(b);
got_B <= True;
endmethod 

method Maybe#(Bit#(16)) output_Mul() if(isValid(rg_AB));
return rg_AB;
endmethod 



endmodule:mkSigned_8bitMul_woAddop
endpackage
