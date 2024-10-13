package MAC_int32;

interface Ifc_MAC_int;
method Action get_A(Bit#(16) a);
method Action get_B(Bit#(16) b);
method Action get_C(Bit#(32) c);
method Action get_S1_or_S2(Bit#(1) s1_or_s2);
method Bit#(32) output_MAC();
endinterface: Ifc_MAC_int

(* synthesize *)
module mkMAC_int32(Ifc_MAC_int);
Reg#(Bit#(16)) rg_A <- mkReg(0);
Reg#(Bit#(16)) rg_B <- mkReg(0);
Reg#(Bit#(32)) rg_temp <- mkReg(0);
Reg#(Bit#(32)) rg_C <- mkReg(0);
Reg#(Bit#(1)) rg_S1_or_S2 <- mkReg(0);
Reg#(Bit#(32)) rg_MAC <- mkReg(0);
Reg#(Bool) got_A <- mkReg(False);
Reg#(Bool) got_B <- mkReg(False);
Reg#(Bool) got_C <- mkReg(False);
Reg#(Bool) got_s1_or_s2 <- mkReg(False);

Reg#(Bool) mac_completed <- mkReg(False);
Reg#(Bool) mul_completed <- mkReg(False);


Reg#(Bit#(5)) count <- mkReg(16);
Reg#(Bit#(16)) partial_store <- mkReg(0);

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

function Bit#(32) rca_32bit(Bit#(32) ab, Bit#(32) c);
Bit#(32) outp = 0;
Bit#(1) carry = 0;
outp[0] = ab[0] ^ c[0];
carry = ab[0] & c[0];
for(Integer i = 1; i < 32; i = i + 1)
begin
	outp[i] = ab[i] ^ c[i] ^ carry;
	carry = (ab[i] & c[i]) | (ab[i] ^ c[i]) & carry;
end

return outp;
endfunction:rca_32bit

rule rl_multiply(got_A && got_B && got_C && got_s1_or_s2 && count != 5'd0);
if(rg_B[0] == 1)
begin
	partial_store <= rca(partial_store , rg_A);
end
rg_A <= rg_A << 1;
rg_B <= rg_B >> 1;
count <= count - 1; 
endrule

rule mul_done(count == 5'd0);
	mul_completed <= True;
	count <= 16;
	rg_temp <= signExtend(partial_store);
	partial_store <= 0;
endrule

rule add(mul_completed == True);
	mul_completed <= False;
	rg_MAC <= rca_32bit(rg_temp,rg_C);
	mac_completed <= True;
endrule

rule reset(mac_completed == True);
	got_A <= False;
	got_B <= False;
	got_C <= False;
	got_s1_or_s2 <= False;
	mac_completed <= False;
endrule


method Action get_A(Bit#(16) a) if(! got_A);
got_A <= True;
rg_A <= a;
endmethod 

method Action get_B(Bit#(16) b) if(! got_B);
got_B <= True;
rg_B <= b;
endmethod 

method Action get_C(Bit#(32) c) if(! got_C);
got_C <= True;
rg_C <= c;
endmethod 

method Action get_S1_or_S2(Bit#(1) s1_or_s2) if(! got_s1_or_s2);
got_s1_or_s2 <= True;
rg_S1_or_S2 <= s1_or_s2;
endmethod 

method Bit#(32) output_MAC() if(mac_completed == True);
return rg_MAC;
endmethod 

endmodule:mkMAC_int32
endpackage
