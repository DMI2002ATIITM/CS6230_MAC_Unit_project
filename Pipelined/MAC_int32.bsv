package MAC_int32;

import FIFO::*;
import SpecialFIFOs::*;

import MAC_types ::*;

interface Ifc_MAC_int;
method Action get_A(Input_16 a);
method Action get_B(Input_16 b);
method Action get_C(Input_32 c);
method ActionValue#(Bit#(32)) ioutput_MAC();
endinterface: Ifc_MAC_int

(* synthesize *)
module mkMAC_int32(Ifc_MAC_int);

FIFO#(Input_16)     inpA_fifo <- mkPipelineFIFO();
FIFO#(Input_16)     inpB_fifo <- mkPipelineFIFO();
FIFO#(Input_32)     inpC_fifo <- mkPipelineFIFO();
FIFO#(Bit#(32))     mulout_fifo <- mkPipelineFIFO();
FIFO#(Bit#(32))     mac_out_fifo <- mkPipelineFIFO();

Reg#(Bit#(16)) rg_A <- mkReg(0);
Reg#(Bit#(16)) rg_B <- mkReg(0);
Reg#(Bit#(32)) rg_C <- mkReg(0);

Reg#(Bool) mul_init_done <- mkReg(False);
Reg#(Bool) imac_completed <- mkReg(False);
Reg#(Bool) add_completed <- mkReg(False);
Reg#(Bool) mul_completed <- mkReg(False);
Reg#(Bool) reset_completed <- mkReg(True);

Reg#(Bit#(4)) count <- mkReg(9);
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

function Bit#(16) rca_16bit(Bit#(16) ab, Bit#(16) c);
Bit#(16) outp = 0;
Bit#(1) carry = 0;
outp[0] = ab[0] ^ c[0];
carry = ab[0] & c[0];
for(Integer i = 1; i < 16; i = i + 1)
begin
	outp[i] = ab[i] ^ c[i] ^ carry;
	carry = (ab[i] & c[i]) | (ab[i] ^ c[i]) & carry;
end

return outp;
endfunction:rca_16bit

function Bit#(16) twos_compliment(Bit#(16) num);
Bit#(16) mask = 16'hFFFF;
Bit#(16) temp = 16'd0;
temp = num ^ mask;
temp = rca_16bit(temp,1);
return temp;
endfunction:twos_compliment

rule rl_multiply(count != 4'd0 && reset_completed == True && mul_init_done == True);
if(rg_B[0] == 1)
begin
	if(count == 4'd1)
	begin
		partial_store <= rca(partial_store , signExtend(twos_compliment(rg_A)));
	end
	else
	begin
		partial_store <= rca(partial_store , signExtend(rg_A));
	end
end
rg_A <= rg_A << 1;
rg_B <= rg_B >> 1;
count <= count - 1; 
endrule

rule mul_done(count == 4'd0 && mul_completed == False && add_completed == False && imac_completed == False);
    reset_completed <= False;
    mul_completed <= True;
    mulout_fifo.enq(signExtend(partial_store));
    partial_store <= 0;
endrule

rule add(mul_completed == True && add_completed == False && imac_completed == False);
    Bit#(32) temp = pack(mulout_fifo.first());
    mulout_fifo.deq();
    mac_out_fifo.enq(rca_32bit(temp,rg_C));
    mul_completed <= False;
    add_completed <= True;
endrule

rule windup(add_completed == True && imac_completed == False);
    add_completed <= False;
    imac_completed <= True;
    count <= 9;
endrule

rule reset(imac_completed == True);
    imac_completed <= False;
    reset_completed <= True;
    mul_init_done <= False;
    add_completed <= False;
endrule

rule mul_init(mul_init_done == False);
    rg_A <= signExtend(pack(inpA_fifo.first())[7:0]);
    rg_B <= signExtend(pack(inpB_fifo.first())[7:0]);
    rg_C <= pack(inpC_fifo.first());
    inpA_fifo.deq();
    inpB_fifo.deq();
    inpC_fifo.deq();
    mul_init_done <= True;
endrule

method Action get_A(Input_16 a);
    inpA_fifo.enq(a);
endmethod 

method Action get_B(Input_16 b);
    inpB_fifo.enq(b);
endmethod 

method Action get_C(Input_32 c);
    inpC_fifo.enq(c);
endmethod 

method ActionValue#(Bit#(32)) ioutput_MAC() if(imac_completed == True);
    Bit#(32) out = mac_out_fifo.first();
    mac_out_fifo.deq();
    return out;
endmethod 

endmodule:mkMAC_int32
endpackage
