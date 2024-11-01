package MAC_types;

typedef struct {
  Bit#(16) val;
} Input_16
deriving(Bits, Eq);

typedef struct {
  Bit#(32) val;
} Input_32
deriving(Bits, Eq);

typedef struct {
  Bit#(1) val;
} Input_1
deriving(Bits, Eq);

endpackage
