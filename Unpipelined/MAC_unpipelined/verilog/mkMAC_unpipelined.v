//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Sat Oct 26 21:29:20 IST 2024
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_A                      O     1
// RDY_get_B                      O     1
// RDY_get_C                      O     1
// RDY_get_S1_or_S2               O     1
// output_MAC                     O    32 reg
// RDY_output_MAC                 O     1 reg
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_A_a                        I    16 reg
// get_B_b                        I    16 reg
// get_C_c                        I    32 reg
// get_S1_or_S2_s1_or_s2          I     1 reg
// EN_get_A                       I     1
// EN_get_B                       I     1
// EN_get_C                       I     1
// EN_get_S1_or_S2                I     1
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

module mkMAC_unpipelined(CLK,
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

  // value method output_MAC
  output [31 : 0] output_MAC;
  output RDY_output_MAC;

  // signals for module outputs
  wire [31 : 0] output_MAC;
  wire RDY_get_A, RDY_get_B, RDY_get_C, RDY_get_S1_or_S2, RDY_output_MAC;

  // register called_MAC
  reg called_MAC;
  wire called_MAC_D_IN, called_MAC_EN;

  // register float_output
  reg [31 : 0] float_output;
  wire [31 : 0] float_output_D_IN;
  wire float_output_EN;

  // register got_A
  reg got_A;
  wire got_A_D_IN, got_A_EN;

  // register got_B
  reg got_B;
  wire got_B_D_IN, got_B_EN;

  // register got_C
  reg got_C;
  wire got_C_D_IN, got_C_EN;

  // register got_output
  reg got_output;
  wire got_output_D_IN, got_output_EN;

  // register got_s1_or_s2
  reg got_s1_or_s2;
  wire got_s1_or_s2_D_IN, got_s1_or_s2_EN;

  // register int_output
  reg [31 : 0] int_output;
  wire [31 : 0] int_output_D_IN;
  wire int_output_EN;

  // register mac_completed
  reg mac_completed;
  wire mac_completed_D_IN, mac_completed_EN;

  // register mac_output
  reg [31 : 0] mac_output;
  wire [31 : 0] mac_output_D_IN;
  wire mac_output_EN;

  // register rg_S1_or_S2
  reg rg_S1_or_S2;
  wire rg_S1_or_S2_D_IN, rg_S1_or_S2_EN;

  // register rg_a
  reg [15 : 0] rg_a;
  wire [15 : 0] rg_a_D_IN;
  wire rg_a_EN;

  // register rg_b
  reg [15 : 0] rg_b;
  wire [15 : 0] rg_b_D_IN;
  wire rg_b_EN;

  // register rg_c
  reg [31 : 0] rg_c;
  wire [31 : 0] rg_c_D_IN;
  wire rg_c_EN;

  // ports of submodule float_MAC
  wire [31 : 0] float_MAC_foutput_MAC, float_MAC_get_C_c;
  wire [15 : 0] float_MAC_get_A_a, float_MAC_get_B_b;
  wire float_MAC_EN_get_A,
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
       int_MAC_RDY_get_A,
       int_MAC_RDY_get_B,
       int_MAC_RDY_get_C,
       int_MAC_RDY_ioutput_MAC;

  // rule scheduling signals
  wire CAN_FIRE_RL_call_MAC,
       CAN_FIRE_RL_deassert_got_output,
       CAN_FIRE_RL_get_output_from_floatMAC,
       CAN_FIRE_RL_get_output_from_intMAC,
       CAN_FIRE_get_A,
       CAN_FIRE_get_B,
       CAN_FIRE_get_C,
       CAN_FIRE_get_S1_or_S2,
       WILL_FIRE_RL_call_MAC,
       WILL_FIRE_RL_deassert_got_output,
       WILL_FIRE_RL_get_output_from_floatMAC,
       WILL_FIRE_RL_get_output_from_intMAC,
       WILL_FIRE_get_A,
       WILL_FIRE_get_B,
       WILL_FIRE_get_C,
       WILL_FIRE_get_S1_or_S2;

  // remaining internal signals
  wire float_MAC_RDY_get_B_AND_float_MAC_RDY_get_A_AN_ETC___d11,
       got_A_2_AND_got_B_3_4_AND_got_C_5_6_AND_got_s1_ETC___d18;

  // action method get_A
  assign RDY_get_A = !got_A ;
  assign CAN_FIRE_get_A = !got_A ;
  assign WILL_FIRE_get_A = EN_get_A ;

  // action method get_B
  assign RDY_get_B = !got_B ;
  assign CAN_FIRE_get_B = !got_B ;
  assign WILL_FIRE_get_B = EN_get_B ;

  // action method get_C
  assign RDY_get_C = !got_C ;
  assign CAN_FIRE_get_C = !got_C ;
  assign WILL_FIRE_get_C = EN_get_C ;

  // action method get_S1_or_S2
  assign RDY_get_S1_or_S2 = !got_s1_or_s2 ;
  assign CAN_FIRE_get_S1_or_S2 = !got_s1_or_s2 ;
  assign WILL_FIRE_get_S1_or_S2 = EN_get_S1_or_S2 ;

  // value method output_MAC
  assign output_MAC = mac_output ;
  assign RDY_output_MAC = got_output ;

  // submodule float_MAC
  mkMAC_fp32 float_MAC(.CLK(CLK),
		       .RST_N(RST_N),
		       .get_A_a(float_MAC_get_A_a),
		       .get_B_b(float_MAC_get_B_b),
		       .get_C_c(float_MAC_get_C_c),
		       .EN_get_A(float_MAC_EN_get_A),
		       .EN_get_B(float_MAC_EN_get_B),
		       .EN_get_C(float_MAC_EN_get_C),
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
		      .RDY_get_A(int_MAC_RDY_get_A),
		      .RDY_get_B(int_MAC_RDY_get_B),
		      .RDY_get_C(int_MAC_RDY_get_C),
		      .ioutput_MAC(int_MAC_ioutput_MAC),
		      .RDY_ioutput_MAC(int_MAC_RDY_ioutput_MAC));

  // rule RL_call_MAC
  assign CAN_FIRE_RL_call_MAC =
	     float_MAC_RDY_get_B_AND_float_MAC_RDY_get_A_AN_ETC___d11 &&
	     got_A_2_AND_got_B_3_4_AND_got_C_5_6_AND_got_s1_ETC___d18 &&
	     !called_MAC ;
  assign WILL_FIRE_RL_call_MAC = CAN_FIRE_RL_call_MAC ;

  // rule RL_get_output_from_intMAC
  assign CAN_FIRE_RL_get_output_from_intMAC =
	     int_MAC_RDY_ioutput_MAC &&
	     got_A_2_AND_got_B_3_4_AND_got_C_5_6_AND_got_s1_ETC___d18 &&
	     called_MAC &&
	     !got_output &&
	     !rg_S1_or_S2 ;
  assign WILL_FIRE_RL_get_output_from_intMAC =
	     CAN_FIRE_RL_get_output_from_intMAC ;

  // rule RL_get_output_from_floatMAC
  assign CAN_FIRE_RL_get_output_from_floatMAC =
	     float_MAC_RDY_foutput_MAC &&
	     got_A_2_AND_got_B_3_4_AND_got_C_5_6_AND_got_s1_ETC___d18 &&
	     called_MAC &&
	     !got_output &&
	     rg_S1_or_S2 ;
  assign WILL_FIRE_RL_get_output_from_floatMAC =
	     CAN_FIRE_RL_get_output_from_floatMAC ;

  // rule RL_deassert_got_output
  assign CAN_FIRE_RL_deassert_got_output = got_output ;
  assign WILL_FIRE_RL_deassert_got_output = got_output ;

  // register called_MAC
  assign called_MAC_D_IN = !got_output ;
  assign called_MAC_EN = got_output || WILL_FIRE_RL_call_MAC ;

  // register float_output
  assign float_output_D_IN = 32'h0 ;
  assign float_output_EN = 1'b0 ;

  // register got_A
  assign got_A_D_IN = !got_output ;
  assign got_A_EN = got_output || EN_get_A ;

  // register got_B
  assign got_B_D_IN = !got_output ;
  assign got_B_EN = got_output || EN_get_B ;

  // register got_C
  assign got_C_D_IN = !got_output ;
  assign got_C_EN = got_output || EN_get_C ;

  // register got_output
  assign got_output_D_IN = !got_output ;
  assign got_output_EN =
	     got_output || WILL_FIRE_RL_get_output_from_floatMAC ||
	     WILL_FIRE_RL_get_output_from_intMAC ;

  // register got_s1_or_s2
  assign got_s1_or_s2_D_IN = !got_output ;
  assign got_s1_or_s2_EN = got_output || EN_get_S1_or_S2 ;

  // register int_output
  assign int_output_D_IN = 32'h0 ;
  assign int_output_EN = 1'b0 ;

  // register mac_completed
  assign mac_completed_D_IN = 1'b0 ;
  assign mac_completed_EN = 1'b0 ;

  // register mac_output
  assign mac_output_D_IN =
	     WILL_FIRE_RL_get_output_from_intMAC ?
	       int_MAC_ioutput_MAC :
	       float_MAC_foutput_MAC ;
  assign mac_output_EN =
	     WILL_FIRE_RL_get_output_from_intMAC ||
	     WILL_FIRE_RL_get_output_from_floatMAC ;

  // register rg_S1_or_S2
  assign rg_S1_or_S2_D_IN = get_S1_or_S2_s1_or_s2 ;
  assign rg_S1_or_S2_EN = EN_get_S1_or_S2 ;

  // register rg_a
  assign rg_a_D_IN = get_A_a ;
  assign rg_a_EN = EN_get_A ;

  // register rg_b
  assign rg_b_D_IN = get_B_b ;
  assign rg_b_EN = EN_get_B ;

  // register rg_c
  assign rg_c_D_IN = get_C_c ;
  assign rg_c_EN = EN_get_C ;

  // submodule float_MAC
  assign float_MAC_get_A_a = rg_a ;
  assign float_MAC_get_B_b = rg_b ;
  assign float_MAC_get_C_c = rg_c ;
  assign float_MAC_EN_get_A = WILL_FIRE_RL_call_MAC && rg_S1_or_S2 ;
  assign float_MAC_EN_get_B = WILL_FIRE_RL_call_MAC && rg_S1_or_S2 ;
  assign float_MAC_EN_get_C = WILL_FIRE_RL_call_MAC && rg_S1_or_S2 ;

  // submodule int_MAC
  assign int_MAC_get_A_a = rg_a ;
  assign int_MAC_get_B_b = rg_b ;
  assign int_MAC_get_C_c = rg_c ;
  assign int_MAC_EN_get_A = WILL_FIRE_RL_call_MAC && !rg_S1_or_S2 ;
  assign int_MAC_EN_get_B = WILL_FIRE_RL_call_MAC && !rg_S1_or_S2 ;
  assign int_MAC_EN_get_C = WILL_FIRE_RL_call_MAC && !rg_S1_or_S2 ;

  // remaining internal signals
  assign float_MAC_RDY_get_B_AND_float_MAC_RDY_get_A_AN_ETC___d11 =
	     float_MAC_RDY_get_B && float_MAC_RDY_get_A &&
	     float_MAC_RDY_get_C &&
	     int_MAC_RDY_get_B &&
	     int_MAC_RDY_get_A &&
	     int_MAC_RDY_get_C ;
  assign got_A_2_AND_got_B_3_4_AND_got_C_5_6_AND_got_s1_ETC___d18 =
	     got_A && got_B && got_C && got_s1_or_s2 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        called_MAC <= `BSV_ASSIGNMENT_DELAY 1'd0;
	float_output <= `BSV_ASSIGNMENT_DELAY 32'd0;
	got_A <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_B <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_C <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_output <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_s1_or_s2 <= `BSV_ASSIGNMENT_DELAY 1'd0;
	int_output <= `BSV_ASSIGNMENT_DELAY 32'd0;
	mac_completed <= `BSV_ASSIGNMENT_DELAY 1'd0;
	mac_output <= `BSV_ASSIGNMENT_DELAY 32'd0;
	rg_S1_or_S2 <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rg_a <= `BSV_ASSIGNMENT_DELAY 16'd0;
	rg_b <= `BSV_ASSIGNMENT_DELAY 16'd0;
	rg_c <= `BSV_ASSIGNMENT_DELAY 32'd0;
      end
    else
      begin
        if (called_MAC_EN)
	  called_MAC <= `BSV_ASSIGNMENT_DELAY called_MAC_D_IN;
	if (float_output_EN)
	  float_output <= `BSV_ASSIGNMENT_DELAY float_output_D_IN;
	if (got_A_EN) got_A <= `BSV_ASSIGNMENT_DELAY got_A_D_IN;
	if (got_B_EN) got_B <= `BSV_ASSIGNMENT_DELAY got_B_D_IN;
	if (got_C_EN) got_C <= `BSV_ASSIGNMENT_DELAY got_C_D_IN;
	if (got_output_EN)
	  got_output <= `BSV_ASSIGNMENT_DELAY got_output_D_IN;
	if (got_s1_or_s2_EN)
	  got_s1_or_s2 <= `BSV_ASSIGNMENT_DELAY got_s1_or_s2_D_IN;
	if (int_output_EN)
	  int_output <= `BSV_ASSIGNMENT_DELAY int_output_D_IN;
	if (mac_completed_EN)
	  mac_completed <= `BSV_ASSIGNMENT_DELAY mac_completed_D_IN;
	if (mac_output_EN)
	  mac_output <= `BSV_ASSIGNMENT_DELAY mac_output_D_IN;
	if (rg_S1_or_S2_EN)
	  rg_S1_or_S2 <= `BSV_ASSIGNMENT_DELAY rg_S1_or_S2_D_IN;
	if (rg_a_EN) rg_a <= `BSV_ASSIGNMENT_DELAY rg_a_D_IN;
	if (rg_b_EN) rg_b <= `BSV_ASSIGNMENT_DELAY rg_b_D_IN;
	if (rg_c_EN) rg_c <= `BSV_ASSIGNMENT_DELAY rg_c_D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    called_MAC = 1'h0;
    float_output = 32'hAAAAAAAA;
    got_A = 1'h0;
    got_B = 1'h0;
    got_C = 1'h0;
    got_output = 1'h0;
    got_s1_or_s2 = 1'h0;
    int_output = 32'hAAAAAAAA;
    mac_completed = 1'h0;
    mac_output = 32'hAAAAAAAA;
    rg_S1_or_S2 = 1'h0;
    rg_a = 16'hAAAA;
    rg_b = 16'hAAAA;
    rg_c = 32'hAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkMAC_unpipelined

