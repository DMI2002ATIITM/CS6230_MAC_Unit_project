package bf16_mul;

interface Ifc_bf16_mul;
method Action get_A(Bit#(16) a);
method Action get_B(Bit#(16) b);
method Bit#(16) out_AB();
endinterface: Ifc_bf16_mul

typedef struct {
    Bit#(1) sign;
    Bit#(8) exponent;
    Bit#(7) fraction;
} Bfnum deriving (Bits, Eq);

(* synthesize *)
module mkbf16_mul(Ifc_bf16_mul);
    Reg#(Bfnum) bf_a <- mkReg(Bfnum{ sign: 1'd0, exponent: 8'd0, fraction: 7'd0 });
    Reg#(Bfnum) bf_b <- mkReg(Bfnum{ sign: 1'd0, exponent: 8'd0, fraction: 7'd0 });
    Reg#(Bfnum) bf_c <- mkReg(Bfnum{ sign: 1'd0, exponent: 8'd0, fraction: 7'd0 });
    Reg#(Bool) got_A <- mkReg(False);
    Reg#(Bool) got_B <- mkReg(False);

    method Action get_A(Bit#(16) a) if (!got_A);
        got_A <= True;
        bf_a <= Bfnum{ sign: a[15], exponent: a[14:7], fraction: a[6:0] };
    endmethod

    method Action get_B(Bit#(16) b) if (!got_B);
        got_B <= True;
        bf_b <= Bfnum{ sign: b[15], exponent: b[14:7], fraction: b[6:0] };
    endmethod

    method Bit#(16) out_AB();
        return 16'd0; 
    endmethod

endmodule: mkbf16_mul
endpackage

