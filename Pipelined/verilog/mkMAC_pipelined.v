//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Sat Nov  2 14:13:33 IST 2024
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_A                      O     1
// RDY_get_B                      O     1
// RDY_get_C                      O     1
// RDY_get_S1_or_S2               O     1
// output_MAC                     O    32
// RDY_output_MAC                 O     1
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_A_a                        I    16
// get_B_b                        I    16
// get_C_c                        I    32
// get_S1_or_S2_s1_or_s2          I     1
// EN_get_A                       I     1
// EN_get_B                       I     1
// EN_get_C                       I     1
// EN_get_S1_or_S2                I     1
// EN_output_MAC                  I     1
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkMAC_pipelined(CLK,
		       RST_N,

		       get_A_a,
		       EN_get_A,
		       RDY_get_A,

		       get_B_b,
		       EN_get_B,
		       RDY_get_B,

		       get_C_c,
		       EN_get_C,
		       RDY_get_C,

		       get_S1_or_S2_s1_or_s2,
		       EN_get_S1_or_S2,
		       RDY_get_S1_or_S2,

		       EN_output_MAC,
		       output_MAC,
		       RDY_output_MAC);
  input  CLK;
  input  RST_N;

  // action method get_A
  input  [15 : 0] get_A_a;
  input  EN_get_A;
  output RDY_get_A;

  // action method get_B
  input  [15 : 0] get_B_b;
  input  EN_get_B;
  output RDY_get_B;

  // action method get_C
  input  [31 : 0] get_C_c;
  input  EN_get_C;
  output RDY_get_C;

  // action method get_S1_or_S2
  input  get_S1_or_S2_s1_or_s2;
  input  EN_get_S1_or_S2;
  output RDY_get_S1_or_S2;

  // actionvalue method output_MAC
  input  EN_output_MAC;
  output [31 : 0] output_MAC;
  output RDY_output_MAC;

  // signals for module outputs
  wire [31 : 0] output_MAC;
  wire RDY_get_A, RDY_get_B, RDY_get_C, RDY_get_S1_or_S2, RDY_output_MAC;

  // inlined wires
  wire [32 : 0] inpC_fifo_rv_port0__write_1,
		inpC_fifo_rv_port1__read,
		inpC_fifo_rv_port1__write_1,
		inpC_fifo_rv_port2__read,
		out_fifo_rv_port1__read,
		out_fifo_rv_port1__write_1,
		out_fifo_rv_port2__read;
  wire [16 : 0] inpA_fifo_rv_port0__write_1,
		inpA_fifo_rv_port1__read,
		inpA_fifo_rv_port1__write_1,
		inpA_fifo_rv_port2__read,
		inpB_fifo_rv_port1__read,
		inpB_fifo_rv_port1__write_1,
		inpB_fifo_rv_port2__read;
  wire [1 : 0] inpS_fifo_rv_port0__write_1,
	       inpS_fifo_rv_port1__read,
	       inpS_fifo_rv_port1__write_1,
	       inpS_fifo_rv_port2__read;
  wire inpA_fifo_rv_EN_port0__write,
       inpB_fifo_rv_EN_port0__write,
       inpC_fifo_rv_EN_port0__write,
       out_fifo_rv_EN_port1__write;

  // register float_output
  reg [31 : 0] float_output;
  wire [31 : 0] float_output_D_IN;
  wire float_output_EN;

  // register got_output
  reg got_output;
  wire got_output_D_IN, got_output_EN;

  // register inpA_fifo_rv
  reg [16 : 0] inpA_fifo_rv;
  wire [16 : 0] inpA_fifo_rv_D_IN;
  wire inpA_fifo_rv_EN;

  // register inpB_fifo_rv
  reg [16 : 0] inpB_fifo_rv;
  wire [16 : 0] inpB_fifo_rv_D_IN;
  wire inpB_fifo_rv_EN;

  // register inpC_fifo_rv
  reg [32 : 0] inpC_fifo_rv;
  wire [32 : 0] inpC_fifo_rv_D_IN;
  wire inpC_fifo_rv_EN;

  // register inpS_fifo_rv
  reg [1 : 0] inpS_fifo_rv;
  wire [1 : 0] inpS_fifo_rv_D_IN;
  wire inpS_fifo_rv_EN;

  // register int_output
  reg [31 : 0] int_output;
  wire [31 : 0] int_output_D_IN;
  wire int_output_EN;

  // register out_fifo_rv
  reg [32 : 0] out_fifo_rv;
  wire [32 : 0] out_fifo_rv_D_IN;
  wire out_fifo_rv_EN;

  // register rg_S1_or_S2
  reg rg_S1_or_S2;
  wire rg_S1_or_S2_D_IN, rg_S1_or_S2_EN;

  // ports of submodule float_MAC
  wire [31 : 0] float_MAC_foutput_MAC, float_MAC_get_C_c;
  wire [15 : 0] float_MAC_get_A_a, float_MAC_get_B_b;
  wire float_MAC_EN_foutput_MAC,
       float_MAC_EN_get_A,
       float_MAC_EN_get_B,
       float_MAC_EN_get_C,
       float_MAC_RDY_foutput_MAC,
       float_MAC_RDY_get_A,
       float_MAC_RDY_get_B,
       float_MAC_RDY_get_C;

  // ports of submodule int_MAC
  wire [31 : 0] int_MAC_get_C_c, int_MAC_ioutput_MAC;
  wire [15 : 0] int_MAC_get_A_a, int_MAC_get_B_b;
  wire int_MAC_EN_get_A,
       int_MAC_EN_get_B,
       int_MAC_EN_get_C,
       int_MAC_EN_ioutput_MAC,
       int_MAC_RDY_get_A,
       int_MAC_RDY_get_B,
       int_MAC_RDY_get_C,
       int_MAC_RDY_ioutput_MAC;

  // rule scheduling signals
  wire CAN_FIRE_RL_call_MAC,
       CAN_FIRE_RL_get_output_from_floatMAC,
       CAN_FIRE_RL_get_output_from_intMAC,
       CAN_FIRE_get_A,
       CAN_FIRE_get_B,
       CAN_FIRE_get_C,
       CAN_FIRE_get_S1_or_S2,
       CAN_FIRE_output_MAC,
       WILL_FIRE_RL_call_MAC,
       WILL_FIRE_RL_get_output_from_floatMAC,
       WILL_FIRE_RL_get_output_from_intMAC,
       WILL_FIRE_get_A,
       WILL_FIRE_get_B,
       WILL_FIRE_get_C,
       WILL_FIRE_get_S1_or_S2,
       WILL_FIRE_output_MAC;

  // inputs to muxes for submodule ports
  wire [32 : 0] MUX_out_fifo_rv_port1__write_1__VAL_1,
		MUX_out_fifo_rv_port1__write_1__VAL_2;

  // remaining internal signals
  wire float_MAC_RDY_get_B_AND_float_MAC_RDY_get_A__0_ETC___d19,
       inpA_fifo_rv_port0__read_BIT_16_AND_inpB_fifo__ETC___d22;

  // action method get_A
  assign RDY_get_A = !inpA_fifo_rv_port1__read[16] ;
  assign CAN_FIRE_get_A = !inpA_fifo_rv_port1__read[16] ;
  assign WILL_FIRE_get_A = EN_get_A ;

  // action method get_B
  assign RDY_get_B = !inpB_fifo_rv_port1__read[16] ;
  assign CAN_FIRE_get_B = !inpB_fifo_rv_port1__read[16] ;
  assign WILL_FIRE_get_B = EN_get_B ;

  // action method get_C
  assign RDY_get_C = !inpC_fifo_rv_port1__read[32] ;
  assign CAN_FIRE_get_C = !inpC_fifo_rv_port1__read[32] ;
  assign WILL_FIRE_get_C = EN_get_C ;

  // action method get_S1_or_S2
  assign RDY_get_S1_or_S2 = !inpS_fifo_rv_port1__read[1] ;
  assign CAN_FIRE_get_S1_or_S2 = !inpS_fifo_rv_port1__read[1] ;
  assign WILL_FIRE_get_S1_or_S2 = EN_get_S1_or_S2 ;

  // actionvalue method output_MAC
  assign output_MAC = out_fifo_rv[31:0] ;
  assign RDY_output_MAC = out_fifo_rv[32] ;
  assign CAN_FIRE_output_MAC = out_fifo_rv[32] ;
  assign WILL_FIRE_output_MAC = EN_output_MAC ;

  // submodule float_MAC
  mkMAC_fp32 float_MAC(.CLK(CLK),
		       .RST_N(RST_N),
		       .get_A_a(float_MAC_get_A_a),
		       .get_B_b(float_MAC_get_B_b),
		       .get_C_c(float_MAC_get_C_c),
		       .EN_get_A(float_MAC_EN_get_A),
		       .EN_get_B(float_MAC_EN_get_B),
		       .EN_get_C(float_MAC_EN_get_C),
		       .EN_foutput_MAC(float_MAC_EN_foutput_MAC),
		       .RDY_get_A(float_MAC_RDY_get_A),
		       .RDY_get_B(float_MAC_RDY_get_B),
		       .RDY_get_C(float_MAC_RDY_get_C),
		       .foutput_MAC(float_MAC_foutput_MAC),
		       .RDY_foutput_MAC(float_MAC_RDY_foutput_MAC));

  // submodule int_MAC
  mkMAC_int32 int_MAC(.CLK(CLK),
		      .RST_N(RST_N),
		      .get_A_a(int_MAC_get_A_a),
		      .get_B_b(int_MAC_get_B_b),
		      .get_C_c(int_MAC_get_C_c),
		      .EN_get_A(int_MAC_EN_get_A),
		      .EN_get_B(int_MAC_EN_get_B),
		      .EN_get_C(int_MAC_EN_get_C),
		      .EN_ioutput_MAC(int_MAC_EN_ioutput_MAC),
		      .RDY_get_A(int_MAC_RDY_get_A),
		      .RDY_get_B(int_MAC_RDY_get_B),
		      .RDY_get_C(int_MAC_RDY_get_C),
		      .ioutput_MAC(int_MAC_ioutput_MAC),
		      .RDY_ioutput_MAC(int_MAC_RDY_ioutput_MAC));

  // rule RL_get_output_from_intMAC
  assign CAN_FIRE_RL_get_output_from_intMAC =
	     int_MAC_RDY_ioutput_MAC && !out_fifo_rv_port1__read[32] &&
	     !rg_S1_or_S2 ;
  assign WILL_FIRE_RL_get_output_from_intMAC =
	     CAN_FIRE_RL_get_output_from_intMAC ;

  // rule RL_get_output_from_floatMAC
  assign CAN_FIRE_RL_get_output_from_floatMAC =
	     float_MAC_RDY_foutput_MAC && !out_fifo_rv_port1__read[32] &&
	     rg_S1_or_S2 ;
  assign WILL_FIRE_RL_get_output_from_floatMAC =
	     CAN_FIRE_RL_get_output_from_floatMAC ;

  // rule RL_call_MAC
  assign CAN_FIRE_RL_call_MAC =
	     inpS_fifo_rv[1] &&
	     inpA_fifo_rv_port0__read_BIT_16_AND_inpB_fifo__ETC___d22 ;
  assign WILL_FIRE_RL_call_MAC = CAN_FIRE_RL_call_MAC ;

  // inputs to muxes for submodule ports
  assign MUX_out_fifo_rv_port1__write_1__VAL_1 =
	     { 1'd1, int_MAC_ioutput_MAC } ;
  assign MUX_out_fifo_rv_port1__write_1__VAL_2 =
	     { 1'd1, float_MAC_foutput_MAC } ;

  // inlined wires
  assign inpA_fifo_rv_EN_port0__write =
	     inpS_fifo_rv[1] &&
	     inpA_fifo_rv_port0__read_BIT_16_AND_inpB_fifo__ETC___d22 ;
  assign inpA_fifo_rv_port0__write_1 =
	     { 1'd0, 16'bxxxxxxxxxxxxxxxx /* unspecified value */  } ;
  assign inpA_fifo_rv_port1__read =
	     inpA_fifo_rv_EN_port0__write ?
	       inpA_fifo_rv_port0__write_1 :
	       inpA_fifo_rv ;
  assign inpA_fifo_rv_port1__write_1 = { 1'd1, get_A_a } ;
  assign inpA_fifo_rv_port2__read =
	     EN_get_A ?
	       inpA_fifo_rv_port1__write_1 :
	       inpA_fifo_rv_port1__read ;
  assign inpB_fifo_rv_EN_port0__write =
	     inpS_fifo_rv[1] &&
	     inpA_fifo_rv_port0__read_BIT_16_AND_inpB_fifo__ETC___d22 ;
  assign inpB_fifo_rv_port1__read =
	     inpB_fifo_rv_EN_port0__write ?
	       inpA_fifo_rv_port0__write_1 :
	       inpB_fifo_rv ;
  assign inpB_fifo_rv_port1__write_1 = { 1'd1, get_B_b } ;
  assign inpB_fifo_rv_port2__read =
	     EN_get_B ?
	       inpB_fifo_rv_port1__write_1 :
	       inpB_fifo_rv_port1__read ;
  assign inpC_fifo_rv_EN_port0__write =
	     inpS_fifo_rv[1] &&
	     inpA_fifo_rv_port0__read_BIT_16_AND_inpB_fifo__ETC___d22 ;
  assign inpC_fifo_rv_port0__write_1 =
	     { 1'd0,
	       32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx /* unspecified value */  } ;
  assign inpC_fifo_rv_port1__read =
	     inpC_fifo_rv_EN_port0__write ?
	       inpC_fifo_rv_port0__write_1 :
	       inpC_fifo_rv ;
  assign inpC_fifo_rv_port1__write_1 = { 1'd1, get_C_c } ;
  assign inpC_fifo_rv_port2__read =
	     EN_get_C ?
	       inpC_fifo_rv_port1__write_1 :
	       inpC_fifo_rv_port1__read ;
  assign inpS_fifo_rv_port0__write_1 =
	     { 1'd0, 1'bx /* unspecified value */  } ;
  assign inpS_fifo_rv_port1__read =
	     CAN_FIRE_RL_call_MAC ?
	       inpS_fifo_rv_port0__write_1 :
	       inpS_fifo_rv ;
  assign inpS_fifo_rv_port1__write_1 = { 1'd1, get_S1_or_S2_s1_or_s2 } ;
  assign inpS_fifo_rv_port2__read =
	     EN_get_S1_or_S2 ?
	       inpS_fifo_rv_port1__write_1 :
	       inpS_fifo_rv_port1__read ;
  assign out_fifo_rv_port1__read =
	     EN_output_MAC ? inpC_fifo_rv_port0__write_1 : out_fifo_rv ;
  assign out_fifo_rv_EN_port1__write =
	     WILL_FIRE_RL_get_output_from_intMAC ||
	     WILL_FIRE_RL_get_output_from_floatMAC ;
  assign out_fifo_rv_port1__write_1 =
	     WILL_FIRE_RL_get_output_from_intMAC ?
	       MUX_out_fifo_rv_port1__write_1__VAL_1 :
	       MUX_out_fifo_rv_port1__write_1__VAL_2 ;
  assign out_fifo_rv_port2__read =
	     out_fifo_rv_EN_port1__write ?
	       out_fifo_rv_port1__write_1 :
	       out_fifo_rv_port1__read ;

  // register float_output
  assign float_output_D_IN = 32'h0 ;
  assign float_output_EN = 1'b0 ;

  // register got_output
  assign got_output_D_IN = 1'b0 ;
  assign got_output_EN = 1'b0 ;

  // register inpA_fifo_rv
  assign inpA_fifo_rv_D_IN = inpA_fifo_rv_port2__read ;
  assign inpA_fifo_rv_EN = 1'b1 ;

  // register inpB_fifo_rv
  assign inpB_fifo_rv_D_IN = inpB_fifo_rv_port2__read ;
  assign inpB_fifo_rv_EN = 1'b1 ;

  // register inpC_fifo_rv
  assign inpC_fifo_rv_D_IN = inpC_fifo_rv_port2__read ;
  assign inpC_fifo_rv_EN = 1'b1 ;

  // register inpS_fifo_rv
  assign inpS_fifo_rv_D_IN = inpS_fifo_rv_port2__read ;
  assign inpS_fifo_rv_EN = 1'b1 ;

  // register int_output
  assign int_output_D_IN = 32'h0 ;
  assign int_output_EN = 1'b0 ;

  // register out_fifo_rv
  assign out_fifo_rv_D_IN = out_fifo_rv_port2__read ;
  assign out_fifo_rv_EN = 1'b1 ;

  // register rg_S1_or_S2
  assign rg_S1_or_S2_D_IN = inpS_fifo_rv[0] ;
  assign rg_S1_or_S2_EN = CAN_FIRE_RL_call_MAC ;

  // submodule float_MAC
  assign float_MAC_get_A_a = inpA_fifo_rv[15:0] ;
  assign float_MAC_get_B_b = inpB_fifo_rv[15:0] ;
  assign float_MAC_get_C_c = inpC_fifo_rv[31:0] ;
  assign float_MAC_EN_get_A = WILL_FIRE_RL_call_MAC && inpS_fifo_rv[0] ;
  assign float_MAC_EN_get_B = WILL_FIRE_RL_call_MAC && inpS_fifo_rv[0] ;
  assign float_MAC_EN_get_C = WILL_FIRE_RL_call_MAC && inpS_fifo_rv[0] ;
  assign float_MAC_EN_foutput_MAC = CAN_FIRE_RL_get_output_from_floatMAC ;

  // submodule int_MAC
  assign int_MAC_get_A_a = inpA_fifo_rv[15:0] ;
  assign int_MAC_get_B_b = inpB_fifo_rv[15:0] ;
  assign int_MAC_get_C_c = inpC_fifo_rv[31:0] ;
  assign int_MAC_EN_get_A = WILL_FIRE_RL_call_MAC && !inpS_fifo_rv[0] ;
  assign int_MAC_EN_get_B = WILL_FIRE_RL_call_MAC && !inpS_fifo_rv[0] ;
  assign int_MAC_EN_get_C = WILL_FIRE_RL_call_MAC && !inpS_fifo_rv[0] ;
  assign int_MAC_EN_ioutput_MAC = CAN_FIRE_RL_get_output_from_intMAC ;

  // remaining internal signals
  assign float_MAC_RDY_get_B_AND_float_MAC_RDY_get_A__0_ETC___d19 =
	     float_MAC_RDY_get_B && float_MAC_RDY_get_A &&
	     float_MAC_RDY_get_C &&
	     int_MAC_RDY_get_B &&
	     int_MAC_RDY_get_A &&
	     int_MAC_RDY_get_C ;
  assign inpA_fifo_rv_port0__read_BIT_16_AND_inpB_fifo__ETC___d22 =
	     inpA_fifo_rv[16] && inpB_fifo_rv[16] && inpC_fifo_rv[32] &&
	     float_MAC_RDY_get_B_AND_float_MAC_RDY_get_A__0_ETC___d19 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        float_output <= `BSV_ASSIGNMENT_DELAY 32'd0;
	got_output <= `BSV_ASSIGNMENT_DELAY 1'd0;
	inpA_fifo_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 16'bxxxxxxxxxxxxxxxx /* unspecified value */  };
	inpB_fifo_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 16'bxxxxxxxxxxxxxxxx /* unspecified value */  };
	inpC_fifo_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0,
	      32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx /* unspecified value */  };
	inpS_fifo_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 1'bx /* unspecified value */  };
	int_output <= `BSV_ASSIGNMENT_DELAY 32'd0;
	out_fifo_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0,
	      32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx /* unspecified value */  };
	rg_S1_or_S2 <= `BSV_ASSIGNMENT_DELAY 1'd0;
      end
    else
      begin
        if (float_output_EN)
	  float_output <= `BSV_ASSIGNMENT_DELAY float_output_D_IN;
	if (got_output_EN)
	  got_output <= `BSV_ASSIGNMENT_DELAY got_output_D_IN;
	if (inpA_fifo_rv_EN)
	  inpA_fifo_rv <= `BSV_ASSIGNMENT_DELAY inpA_fifo_rv_D_IN;
	if (inpB_fifo_rv_EN)
	  inpB_fifo_rv <= `BSV_ASSIGNMENT_DELAY inpB_fifo_rv_D_IN;
	if (inpC_fifo_rv_EN)
	  inpC_fifo_rv <= `BSV_ASSIGNMENT_DELAY inpC_fifo_rv_D_IN;
	if (inpS_fifo_rv_EN)
	  inpS_fifo_rv <= `BSV_ASSIGNMENT_DELAY inpS_fifo_rv_D_IN;
	if (int_output_EN)
	  int_output <= `BSV_ASSIGNMENT_DELAY int_output_D_IN;
	if (out_fifo_rv_EN)
	  out_fifo_rv <= `BSV_ASSIGNMENT_DELAY out_fifo_rv_D_IN;
	if (rg_S1_or_S2_EN)
	  rg_S1_or_S2 <= `BSV_ASSIGNMENT_DELAY rg_S1_or_S2_D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    float_output = 32'hAAAAAAAA;
    got_output = 1'h0;
    inpA_fifo_rv = 17'h0AAAA;
    inpB_fifo_rv = 17'h0AAAA;
    inpC_fifo_rv = 33'h0AAAAAAAA;
    inpS_fifo_rv = 2'h2;
    int_output = 32'hAAAAAAAA;
    out_fifo_rv = 33'h0AAAAAAAA;
    rg_S1_or_S2 = 1'h0;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkMAC_pipelined

