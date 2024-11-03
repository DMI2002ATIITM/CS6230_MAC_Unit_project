package Signed_16bitAdd;

interface Ifc_Signed_16bitAdd;
method Action get_A(Bit#(16) a);
method Action get_B(Bit#(16) b);
method ActionValue #(Bit#(16)) output_Add();
endinterface: Ifc_Signed_16bitAdd

(* synthesize *)
module mkSigned_16bitAdd(Ifc_Signed_16bitAdd);
Reg#(Bit#(16)) rg_A <- mkReg(0);
Reg#(Bit#(16)) rg_B <- mkReg(0);
Reg#(Bit#(16)) rg_Add <- mkReg(0);
Reg#(Bit#(16)) rg_Carry <- mkReg(0);

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
//outp[4] = carry;

return outp;
endfunction:rca


method Action get_A(Bit#(16) a);
rg_A <= a;
endmethod 

method Action get_B(Bit#(16) b);
rg_B <= b;
endmethod 

method ActionValue #(Bit#(16)) output_Add();
return rca(rg_A,rg_B);
endmethod 

endmodule:mkSigned_16bitAdd
endpackage
