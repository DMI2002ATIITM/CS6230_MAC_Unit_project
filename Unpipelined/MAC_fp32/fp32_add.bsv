package fp32_add;

interface Ifc_fp32_add;
method Action get_A(Bit#(16) a);
method Action get_B(Bit#(32) b);
method Fpnum out_AaddB();
endinterface: Ifc_fp32_add

typedef struct {
    Bit#(1) sign;
    Bit#(8) exponent;
    Bit#(7) fraction;
} Bfnum deriving (Bits, Eq);

typedef struct {
    Bit#(1) sign;
    Bit#(8) exponent;
    Bit#(23) fraction;
} Fpnum deriving (Bits, Eq);


(* synthesize *)
module mkfp32_add(Ifc_fp32_add);
    Reg#(Bfnum) bf_a <- mkReg(Bfnum{ sign: 1'd0, exponent: 8'd0, fraction: 7'd0}); 
    Reg#(Fpnum) fp_b <- mkReg(Fpnum{ sign: 1'd0, exponent: 8'd0, fraction: 23'd0}); 
    Reg#(Fpnum) fp_c <- mkReg(Fpnum{ sign: 1'd0, exponent: 8'd0, fraction: 23'd0}); 
    Reg#(Bool) got_A <- mkReg(False);
    Reg#(Bool) got_B <- mkReg(False);
    
    
    method Action get_A(Bit#(16) a) if (!got_A);
        got_A <= True;
        bf_a <= Bfnum{ sign: a[15], exponent: a[14:7], fraction: a[6:0] };
    endmethod

    method Action get_B(Bit#(32) b) if (!got_B);
        got_B <= True;
        fp_b <= Fpnum{ sign: b[31], exponent: b[30:23], fraction: b[22:0] };
    endmethod

    method Fpnum out_AaddB();
        return fp_c; 
    endmethod

endmodule: mkfp32_add
endpackage

