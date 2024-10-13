//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Sun Oct 13 12:27:53 IST 2024
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_A                      O     1
// RDY_get_B                      O     1
// output_Mul                     O    17 reg
// RDY_output_Mul                 O     1 reg
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_A_a                        I     8
// get_B_b                        I     8
// EN_get_A                       I     1
// EN_get_B                       I     1
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

module mkSigned_8bitMul_woAddop(CLK,
				RST_N,

				get_A_a,
				EN_get_A,
				RDY_get_A,

				get_B_b,
				EN_get_B,
				RDY_get_B,

				output_Mul,
				RDY_output_Mul);
  input  CLK;
  input  RST_N;

  // action method get_A
  input  [7 : 0] get_A_a;
  input  EN_get_A;
  output RDY_get_A;

  // action method get_B
  input  [7 : 0] get_B_b;
  input  EN_get_B;
  output RDY_get_B;

  // value method output_Mul
  output [16 : 0] output_Mul;
  output RDY_output_Mul;

  // signals for module outputs
  wire [16 : 0] output_Mul;
  wire RDY_get_A, RDY_get_B, RDY_output_Mul;

  // register completed
  reg completed;
  wire completed_D_IN, completed_EN;

  // register count
  reg [4 : 0] count;
  wire [4 : 0] count_D_IN;
  wire count_EN;

  // register got_A
  reg got_A;
  wire got_A_D_IN, got_A_EN;

  // register got_B
  reg got_B;
  wire got_B_D_IN, got_B_EN;

  // register partial_store
  reg [15 : 0] partial_store;
  wire [15 : 0] partial_store_D_IN;
  wire partial_store_EN;

  // register rg_A
  reg [15 : 0] rg_A;
  wire [15 : 0] rg_A_D_IN;
  wire rg_A_EN;

  // register rg_AB
  reg [16 : 0] rg_AB;
  wire [16 : 0] rg_AB_D_IN;
  wire rg_AB_EN;

  // register rg_B
  reg [15 : 0] rg_B;
  wire [15 : 0] rg_B_D_IN;
  wire rg_B_EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_reset_state,
       CAN_FIRE_RL_rl_multiply,
       CAN_FIRE_get_A,
       CAN_FIRE_get_B,
       WILL_FIRE_RL_reset_state,
       WILL_FIRE_RL_rl_multiply,
       WILL_FIRE_get_A,
       WILL_FIRE_get_B;

  // inputs to muxes for submodule ports
  wire [16 : 0] MUX_rg_AB_write_1__VAL_1, MUX_rg_AB_write_1__VAL_2;
  wire [15 : 0] MUX_partial_store_write_1__VAL_1,
		MUX_rg_A_write_1__VAL_1,
		MUX_rg_A_write_1__VAL_2,
		MUX_rg_B_write_1__VAL_1,
		MUX_rg_B_write_1__VAL_2;
  wire [4 : 0] MUX_count_write_1__VAL_1;
  wire MUX_partial_store_write_1__SEL_1;

  // remaining internal signals
  wire [15 : 0] IF_partial_store_BIT_0_XOR_rg_A_BIT_0_THEN_1_E_ETC__q1;
  wire [13 : 0] partial_store_0_BIT_13_9_XOR_rg_A_2_BIT_13_0_2_ETC___d126;
  wire [11 : 0] partial_store_0_BIT_11_7_XOR_rg_A_2_BIT_11_8_0_ETC___d125;
  wire [9 : 0] partial_store_0_BIT_9_5_XOR_rg_A_2_BIT_9_6_8_X_ETC___d124;
  wire [7 : 0] partial_store_0_BIT_7_3_XOR_rg_A_2_BIT_7_4_6_X_ETC___d123;
  wire [5 : 0] partial_store_0_BIT_5_1_XOR_rg_A_2_BIT_5_2_4_X_ETC___d122;
  wire [3 : 0] partial_store_0_BIT_3_9_XOR_rg_A_2_BIT_3_0_2_X_ETC___d121;
  wire [1 : 0] partial_store_0_BIT_1_7_XOR_rg_A_2_BIT_1_8_0_X_ETC___d120;
  wire x__h1056,
       x__h1103,
       x__h1248,
       x__h1295,
       x__h1440,
       x__h1487,
       x__h1632,
       x__h1679,
       x__h1824,
       x__h1871,
       x__h2016,
       x__h2063,
       x__h2208,
       x__h2255,
       x__h2400,
       x__h2447,
       x__h2592,
       x__h2639,
       x__h2784,
       x__h2831,
       x__h2976,
       x__h3023,
       x__h3168,
       x__h3215,
       x__h3360,
       x__h3407,
       x__h3493,
       x__h3552,
       x__h3599,
       y__h1057,
       y__h1104,
       y__h1190,
       y__h1249,
       y__h1382,
       y__h1441,
       y__h1574,
       y__h1633,
       y__h1766,
       y__h1825,
       y__h1958,
       y__h2017,
       y__h2150,
       y__h2209,
       y__h2342,
       y__h2401,
       y__h2534,
       y__h2593,
       y__h2726,
       y__h2785,
       y__h2918,
       y__h2977,
       y__h3110,
       y__h3169,
       y__h3302,
       y__h3361,
       y__h3494,
       y__h3553,
       y__h998;

  // action method get_A
  assign RDY_get_A = !got_A ;
  assign CAN_FIRE_get_A = !got_A ;
  assign WILL_FIRE_get_A = EN_get_A ;

  // action method get_B
  assign RDY_get_B = !got_B ;
  assign CAN_FIRE_get_B = !got_B ;
  assign WILL_FIRE_get_B = EN_get_B ;

  // value method output_Mul
  assign output_Mul = rg_AB ;
  assign RDY_output_Mul = rg_AB[16] ;

  // rule RL_rl_multiply
  assign CAN_FIRE_RL_rl_multiply = got_A && got_B && count != 5'd0 ;
  assign WILL_FIRE_RL_rl_multiply = CAN_FIRE_RL_rl_multiply ;

  // rule RL_reset_state
  assign CAN_FIRE_RL_reset_state = count == 5'd0 ;
  assign WILL_FIRE_RL_reset_state = CAN_FIRE_RL_reset_state ;

  // inputs to muxes for submodule ports
  assign MUX_partial_store_write_1__SEL_1 =
	     WILL_FIRE_RL_rl_multiply && rg_B[0] ;
  assign MUX_count_write_1__VAL_1 = count - 5'd1 ;
  assign MUX_partial_store_write_1__VAL_1 =
	     { x__h3493 ^ y__h3494,
	       x__h3599 ^ y__h3302,
	       partial_store_0_BIT_13_9_XOR_rg_A_2_BIT_13_0_2_ETC___d126 } ;
  assign MUX_rg_A_write_1__VAL_1 = { rg_A[14:0], 1'd0 } ;
  assign MUX_rg_A_write_1__VAL_2 = { {8{get_A_a[7]}}, get_A_a } ;
  assign MUX_rg_AB_write_1__VAL_1 = { 1'd1, partial_store } ;
  assign MUX_rg_AB_write_1__VAL_2 =
	     { 1'd0, 16'bxxxxxxxxxxxxxxxx /* unspecified value */  } ;
  assign MUX_rg_B_write_1__VAL_1 = { 1'd0, rg_B[15:1] } ;
  assign MUX_rg_B_write_1__VAL_2 = { {8{get_B_b[7]}}, get_B_b } ;

  // register completed
  assign completed_D_IN = 1'd0 ;
  assign completed_EN = CAN_FIRE_RL_reset_state ;

  // register count
  assign count_D_IN =
	     WILL_FIRE_RL_rl_multiply ? MUX_count_write_1__VAL_1 : 5'd16 ;
  assign count_EN = WILL_FIRE_RL_rl_multiply || WILL_FIRE_RL_reset_state ;

  // register got_A
  assign got_A_D_IN = !WILL_FIRE_RL_reset_state ;
  assign got_A_EN = WILL_FIRE_RL_reset_state || EN_get_A ;

  // register got_B
  assign got_B_D_IN = !WILL_FIRE_RL_reset_state ;
  assign got_B_EN = WILL_FIRE_RL_reset_state || EN_get_B ;

  // register partial_store
  assign partial_store_D_IN =
	     MUX_partial_store_write_1__SEL_1 ?
	       MUX_partial_store_write_1__VAL_1 :
	       16'd0 ;
  assign partial_store_EN =
	     WILL_FIRE_RL_rl_multiply && rg_B[0] || WILL_FIRE_RL_reset_state ;

  // register rg_A
  assign rg_A_D_IN =
	     WILL_FIRE_RL_rl_multiply ?
	       MUX_rg_A_write_1__VAL_1 :
	       MUX_rg_A_write_1__VAL_2 ;
  assign rg_A_EN = WILL_FIRE_RL_rl_multiply || EN_get_A ;

  // register rg_AB
  assign rg_AB_D_IN =
	     WILL_FIRE_RL_reset_state ?
	       MUX_rg_AB_write_1__VAL_1 :
	       MUX_rg_AB_write_1__VAL_2 ;
  assign rg_AB_EN = EN_get_A || WILL_FIRE_RL_reset_state ;

  // register rg_B
  assign rg_B_D_IN =
	     WILL_FIRE_RL_rl_multiply ?
	       MUX_rg_B_write_1__VAL_1 :
	       MUX_rg_B_write_1__VAL_2 ;
  assign rg_B_EN = WILL_FIRE_RL_rl_multiply || EN_get_B ;

  // remaining internal signals
  assign IF_partial_store_BIT_0_XOR_rg_A_BIT_0_THEN_1_E_ETC__q1 =
	     (partial_store[0] ^ rg_A[0]) ? 16'd1 : 16'd0 ;
  assign partial_store_0_BIT_11_7_XOR_rg_A_2_BIT_11_8_0_ETC___d125 =
	     { x__h3023 ^ y__h2726,
	       x__h2831 ^ y__h2534,
	       partial_store_0_BIT_9_5_XOR_rg_A_2_BIT_9_6_8_X_ETC___d124 } ;
  assign partial_store_0_BIT_13_9_XOR_rg_A_2_BIT_13_0_2_ETC___d126 =
	     { x__h3407 ^ y__h3110,
	       x__h3215 ^ y__h2918,
	       partial_store_0_BIT_11_7_XOR_rg_A_2_BIT_11_8_0_ETC___d125 } ;
  assign partial_store_0_BIT_1_7_XOR_rg_A_2_BIT_1_8_0_X_ETC___d120 =
	     { x__h1103 ^ y__h1104,
	       IF_partial_store_BIT_0_XOR_rg_A_BIT_0_THEN_1_E_ETC__q1[0] } ;
  assign partial_store_0_BIT_3_9_XOR_rg_A_2_BIT_3_0_2_X_ETC___d121 =
	     { x__h1487 ^ y__h1190,
	       x__h1295 ^ y__h998,
	       partial_store_0_BIT_1_7_XOR_rg_A_2_BIT_1_8_0_X_ETC___d120 } ;
  assign partial_store_0_BIT_5_1_XOR_rg_A_2_BIT_5_2_4_X_ETC___d122 =
	     { x__h1871 ^ y__h1574,
	       x__h1679 ^ y__h1382,
	       partial_store_0_BIT_3_9_XOR_rg_A_2_BIT_3_0_2_X_ETC___d121 } ;
  assign partial_store_0_BIT_7_3_XOR_rg_A_2_BIT_7_4_6_X_ETC___d123 =
	     { x__h2255 ^ y__h1958,
	       x__h2063 ^ y__h1766,
	       partial_store_0_BIT_5_1_XOR_rg_A_2_BIT_5_2_4_X_ETC___d122 } ;
  assign partial_store_0_BIT_9_5_XOR_rg_A_2_BIT_9_6_8_X_ETC___d124 =
	     { x__h2639 ^ y__h2342,
	       x__h2447 ^ y__h2150,
	       partial_store_0_BIT_7_3_XOR_rg_A_2_BIT_7_4_6_X_ETC___d123 } ;
  assign x__h1056 = partial_store[1] & rg_A[1] ;
  assign x__h1103 = partial_store[1] ^ rg_A[1] ;
  assign x__h1248 = partial_store[2] & rg_A[2] ;
  assign x__h1295 = partial_store[2] ^ rg_A[2] ;
  assign x__h1440 = partial_store[3] & rg_A[3] ;
  assign x__h1487 = partial_store[3] ^ rg_A[3] ;
  assign x__h1632 = partial_store[4] & rg_A[4] ;
  assign x__h1679 = partial_store[4] ^ rg_A[4] ;
  assign x__h1824 = partial_store[5] & rg_A[5] ;
  assign x__h1871 = partial_store[5] ^ rg_A[5] ;
  assign x__h2016 = partial_store[6] & rg_A[6] ;
  assign x__h2063 = partial_store[6] ^ rg_A[6] ;
  assign x__h2208 = partial_store[7] & rg_A[7] ;
  assign x__h2255 = partial_store[7] ^ rg_A[7] ;
  assign x__h2400 = partial_store[8] & rg_A[8] ;
  assign x__h2447 = partial_store[8] ^ rg_A[8] ;
  assign x__h2592 = partial_store[9] & rg_A[9] ;
  assign x__h2639 = partial_store[9] ^ rg_A[9] ;
  assign x__h2784 = partial_store[10] & rg_A[10] ;
  assign x__h2831 = partial_store[10] ^ rg_A[10] ;
  assign x__h2976 = partial_store[11] & rg_A[11] ;
  assign x__h3023 = partial_store[11] ^ rg_A[11] ;
  assign x__h3168 = partial_store[12] & rg_A[12] ;
  assign x__h3215 = partial_store[12] ^ rg_A[12] ;
  assign x__h3360 = partial_store[13] & rg_A[13] ;
  assign x__h3407 = partial_store[13] ^ rg_A[13] ;
  assign x__h3493 = partial_store[15] ^ rg_A[15] ;
  assign x__h3552 = partial_store[14] & rg_A[14] ;
  assign x__h3599 = partial_store[14] ^ rg_A[14] ;
  assign y__h1057 = x__h1103 & y__h1104 ;
  assign y__h1104 = partial_store[0] & rg_A[0] ;
  assign y__h1190 = x__h1248 | y__h1249 ;
  assign y__h1249 = x__h1295 & y__h998 ;
  assign y__h1382 = x__h1440 | y__h1441 ;
  assign y__h1441 = x__h1487 & y__h1190 ;
  assign y__h1574 = x__h1632 | y__h1633 ;
  assign y__h1633 = x__h1679 & y__h1382 ;
  assign y__h1766 = x__h1824 | y__h1825 ;
  assign y__h1825 = x__h1871 & y__h1574 ;
  assign y__h1958 = x__h2016 | y__h2017 ;
  assign y__h2017 = x__h2063 & y__h1766 ;
  assign y__h2150 = x__h2208 | y__h2209 ;
  assign y__h2209 = x__h2255 & y__h1958 ;
  assign y__h2342 = x__h2400 | y__h2401 ;
  assign y__h2401 = x__h2447 & y__h2150 ;
  assign y__h2534 = x__h2592 | y__h2593 ;
  assign y__h2593 = x__h2639 & y__h2342 ;
  assign y__h2726 = x__h2784 | y__h2785 ;
  assign y__h2785 = x__h2831 & y__h2534 ;
  assign y__h2918 = x__h2976 | y__h2977 ;
  assign y__h2977 = x__h3023 & y__h2726 ;
  assign y__h3110 = x__h3168 | y__h3169 ;
  assign y__h3169 = x__h3215 & y__h2918 ;
  assign y__h3302 = x__h3360 | y__h3361 ;
  assign y__h3361 = x__h3407 & y__h3110 ;
  assign y__h3494 = x__h3552 | y__h3553 ;
  assign y__h3553 = x__h3599 & y__h3302 ;
  assign y__h998 = x__h1056 | y__h1057 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        completed <= `BSV_ASSIGNMENT_DELAY 1'd0;
	count <= `BSV_ASSIGNMENT_DELAY 5'd16;
	got_A <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_B <= `BSV_ASSIGNMENT_DELAY 1'd0;
	partial_store <= `BSV_ASSIGNMENT_DELAY 16'd0;
	rg_A <= `BSV_ASSIGNMENT_DELAY 16'd0;
	rg_AB <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 16'bxxxxxxxxxxxxxxxx /* unspecified value */  };
	rg_B <= `BSV_ASSIGNMENT_DELAY 16'd0;
      end
    else
      begin
        if (completed_EN) completed <= `BSV_ASSIGNMENT_DELAY completed_D_IN;
	if (count_EN) count <= `BSV_ASSIGNMENT_DELAY count_D_IN;
	if (got_A_EN) got_A <= `BSV_ASSIGNMENT_DELAY got_A_D_IN;
	if (got_B_EN) got_B <= `BSV_ASSIGNMENT_DELAY got_B_D_IN;
	if (partial_store_EN)
	  partial_store <= `BSV_ASSIGNMENT_DELAY partial_store_D_IN;
	if (rg_A_EN) rg_A <= `BSV_ASSIGNMENT_DELAY rg_A_D_IN;
	if (rg_AB_EN) rg_AB <= `BSV_ASSIGNMENT_DELAY rg_AB_D_IN;
	if (rg_B_EN) rg_B <= `BSV_ASSIGNMENT_DELAY rg_B_D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    completed = 1'h0;
    count = 5'h0A;
    got_A = 1'h0;
    got_B = 1'h0;
    partial_store = 16'hAAAA;
    rg_A = 16'hAAAA;
    rg_AB = 17'h0AAAA;
    rg_B = 16'hAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkSigned_8bitMul_woAddop

