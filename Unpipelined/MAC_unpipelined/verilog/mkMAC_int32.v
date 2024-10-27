//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Sun Oct 27 18:49:29 IST 2024
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_A                      O     1
// RDY_get_B                      O     1
// RDY_get_C                      O     1
// ioutput_MAC                    O    32 reg
// RDY_ioutput_MAC                O     1 reg
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_A_a                        I    16
// get_B_b                        I    16
// get_C_c                        I    32 reg
// EN_get_A                       I     1
// EN_get_B                       I     1
// EN_get_C                       I     1
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

module mkMAC_int32(CLK,
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

		   ioutput_MAC,
		   RDY_ioutput_MAC);
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

  // value method ioutput_MAC
  output [31 : 0] ioutput_MAC;
  output RDY_ioutput_MAC;

  // signals for module outputs
  wire [31 : 0] ioutput_MAC;
  wire RDY_get_A, RDY_get_B, RDY_get_C, RDY_ioutput_MAC;

  // register add_completed
  reg add_completed;
  wire add_completed_D_IN, add_completed_EN;

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

  // register got_C
  reg got_C;
  wire got_C_D_IN, got_C_EN;

  // register imac_completed
  reg imac_completed;
  wire imac_completed_D_IN, imac_completed_EN;

  // register mul_completed
  reg mul_completed;
  wire mul_completed_D_IN, mul_completed_EN;

  // register partial_store
  reg [15 : 0] partial_store;
  wire [15 : 0] partial_store_D_IN;
  wire partial_store_EN;

  // register reset_completed
  reg reset_completed;
  wire reset_completed_D_IN, reset_completed_EN;

  // register rg_A
  reg [15 : 0] rg_A;
  wire [15 : 0] rg_A_D_IN;
  wire rg_A_EN;

  // register rg_B
  reg [15 : 0] rg_B;
  wire [15 : 0] rg_B_D_IN;
  wire rg_B_EN;

  // register rg_C
  reg [31 : 0] rg_C;
  wire [31 : 0] rg_C_D_IN;
  wire rg_C_EN;

  // register rg_MAC
  reg [31 : 0] rg_MAC;
  wire [31 : 0] rg_MAC_D_IN;
  wire rg_MAC_EN;

  // register rg_temp
  reg [31 : 0] rg_temp;
  wire [31 : 0] rg_temp_D_IN;
  wire rg_temp_EN;

  // register start
  reg start;
  wire start_D_IN, start_EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_add,
       CAN_FIRE_RL_mul_done,
       CAN_FIRE_RL_reset,
       CAN_FIRE_RL_rl_multiply,
       CAN_FIRE_RL_windup,
       CAN_FIRE_get_A,
       CAN_FIRE_get_B,
       CAN_FIRE_get_C,
       WILL_FIRE_RL_add,
       WILL_FIRE_RL_mul_done,
       WILL_FIRE_RL_reset,
       WILL_FIRE_RL_rl_multiply,
       WILL_FIRE_RL_windup,
       WILL_FIRE_get_A,
       WILL_FIRE_get_B,
       WILL_FIRE_get_C;

  // inputs to muxes for submodule ports
  wire [15 : 0] MUX_partial_store_write_1__VAL_1,
		MUX_rg_A_write_1__VAL_1,
		MUX_rg_A_write_1__VAL_2,
		MUX_rg_B_write_1__VAL_1,
		MUX_rg_B_write_1__VAL_2;
  wire [4 : 0] MUX_count_write_1__VAL_2;
  wire MUX_partial_store_write_1__SEL_1;

  // remaining internal signals
  wire [31 : 0] IF_rg_temp_BIT_0_XOR_rg_C_BIT_0_THEN_1_ELSE_0__q5;
  wire [29 : 0] rg_temp_84_BIT_29_93_XOR_rg_C_86_BIT_29_94_96__ETC___d520;
  wire [27 : 0] rg_temp_84_BIT_27_01_XOR_rg_C_86_BIT_27_02_04__ETC___d519;
  wire [25 : 0] rg_temp_84_BIT_25_09_XOR_rg_C_86_BIT_25_10_12__ETC___d518;
  wire [23 : 0] rg_temp_84_BIT_23_17_XOR_rg_C_86_BIT_23_18_20__ETC___d517;
  wire [21 : 0] rg_temp_84_BIT_21_25_XOR_rg_C_86_BIT_21_26_28__ETC___d516;
  wire [19 : 0] rg_temp_84_BIT_19_33_XOR_rg_C_86_BIT_19_34_36__ETC___d515;
  wire [17 : 0] rg_temp_84_BIT_17_41_XOR_rg_C_86_BIT_17_42_44__ETC___d514;
  wire [15 : 0] IF_INV_INV_rg_A_BIT_0_THEN_1_ELSE_0__q2,
		IF_partial_store_BIT_0_XOR_IF_INV_INV_rg_A_BIT_ETC__q3,
		IF_partial_store_BIT_0_XOR_rg_A_BIT_0_THEN_1_E_ETC__q4,
		INV_rg_A__q1,
		rg_temp_84_BIT_15_49_XOR_rg_C_86_BIT_15_50_52__ETC___d513,
		x__h652,
		x__h7121;
  wire [13 : 0] partial_store_5_BIT_13_5_XOR_INV_rg_A_7_8_BIT__ETC___d164,
		partial_store_5_BIT_13_5_XOR_rg_A_7_BIT_13_71__ETC___d264,
		rg_temp_84_BIT_13_57_XOR_rg_C_86_BIT_13_58_60__ETC___d512;
  wire [11 : 0] partial_store_5_BIT_11_3_XOR_INV_rg_A_7_8_BIT__ETC___d163,
		partial_store_5_BIT_11_3_XOR_rg_A_7_BIT_11_77__ETC___d263,
		rg_temp_84_BIT_11_65_XOR_rg_C_86_BIT_11_66_68__ETC___d511;
  wire [9 : 0] partial_store_5_BIT_9_1_XOR_INV_rg_A_7_8_BIT_9_ETC___d162,
	       partial_store_5_BIT_9_1_XOR_rg_A_7_BIT_9_83_85_ETC___d262,
	       rg_temp_84_BIT_9_73_XOR_rg_C_86_BIT_9_74_76_XO_ETC___d510;
  wire [7 : 0] get_A_a_BITS_7_TO_0__q6,
	       get_B_b_BITS_7_TO_0__q7,
	       partial_store_5_BIT_7_9_XOR_INV_rg_A_7_8_BIT_7_ETC___d161,
	       partial_store_5_BIT_7_9_XOR_rg_A_7_BIT_7_89_91_ETC___d261,
	       rg_temp_84_BIT_7_81_XOR_rg_C_86_BIT_7_82_84_XO_ETC___d509;
  wire [5 : 0] partial_store_5_BIT_5_7_XOR_INV_rg_A_7_8_BIT_5_ETC___d160,
	       partial_store_5_BIT_5_7_XOR_rg_A_7_BIT_5_95_97_ETC___d260,
	       rg_temp_84_BIT_5_89_XOR_rg_C_86_BIT_5_90_92_XO_ETC___d508;
  wire [3 : 0] partial_store_5_BIT_3_5_XOR_INV_rg_A_7_8_BIT_3_ETC___d159,
	       partial_store_5_BIT_3_5_XOR_rg_A_7_BIT_3_01_03_ETC___d259,
	       rg_temp_84_BIT_3_97_XOR_rg_C_86_BIT_3_98_00_XO_ETC___d507;
  wire [1 : 0] partial_store_5_BIT_1_03_XOR_INV_rg_A_7_8_BIT__ETC___d158,
	       partial_store_5_BIT_1_03_XOR_rg_A_7_BIT_1_07_0_ETC___d258,
	       rg_temp_84_BIT_1_05_XOR_rg_C_86_BIT_1_06_08_XO_ETC___d506;
  wire x__h10082,
       x__h10129,
       x__h10215,
       x__h10274,
       x__h10321,
       x__h11735,
       x__h11782,
       x__h11927,
       x__h11974,
       x__h12119,
       x__h12166,
       x__h12311,
       x__h12358,
       x__h12503,
       x__h12550,
       x__h12695,
       x__h12742,
       x__h12887,
       x__h12934,
       x__h13079,
       x__h13126,
       x__h13271,
       x__h13318,
       x__h13463,
       x__h13510,
       x__h13655,
       x__h13702,
       x__h13847,
       x__h13894,
       x__h14039,
       x__h14086,
       x__h14231,
       x__h14278,
       x__h14423,
       x__h14470,
       x__h14615,
       x__h14662,
       x__h14807,
       x__h14854,
       x__h14999,
       x__h15046,
       x__h15191,
       x__h15238,
       x__h15383,
       x__h15430,
       x__h15575,
       x__h15622,
       x__h15767,
       x__h15814,
       x__h15959,
       x__h16006,
       x__h16151,
       x__h16198,
       x__h16343,
       x__h16390,
       x__h16535,
       x__h16582,
       x__h16727,
       x__h16774,
       x__h16919,
       x__h16966,
       x__h17111,
       x__h17158,
       x__h17244,
       x__h17303,
       x__h17350,
       x__h4340,
       x__h4468,
       x__h4526,
       x__h4657,
       x__h4715,
       x__h4846,
       x__h4904,
       x__h5035,
       x__h5093,
       x__h5224,
       x__h5282,
       x__h5413,
       x__h5471,
       x__h5602,
       x__h5660,
       x__h5791,
       x__h5849,
       x__h5980,
       x__h6038,
       x__h6169,
       x__h6227,
       x__h6358,
       x__h6416,
       x__h6547,
       x__h6605,
       x__h6736,
       x__h6794,
       x__h6925,
       x__h6983,
       x__h7778,
       x__h7825,
       x__h7970,
       x__h8017,
       x__h8162,
       x__h8209,
       x__h8354,
       x__h8401,
       x__h8546,
       x__h8593,
       x__h8738,
       x__h8785,
       x__h8930,
       x__h8977,
       x__h9122,
       x__h9169,
       x__h9314,
       x__h9361,
       x__h9506,
       x__h9553,
       x__h9698,
       x__h9745,
       x__h9890,
       x__h9937,
       y__h10024,
       y__h10083,
       y__h10216,
       y__h10275,
       y__h11677,
       y__h11736,
       y__h11783,
       y__h11869,
       y__h11928,
       y__h12061,
       y__h12120,
       y__h12253,
       y__h12312,
       y__h12445,
       y__h12504,
       y__h12637,
       y__h12696,
       y__h12829,
       y__h12888,
       y__h13021,
       y__h13080,
       y__h13213,
       y__h13272,
       y__h13405,
       y__h13464,
       y__h13597,
       y__h13656,
       y__h13789,
       y__h13848,
       y__h13981,
       y__h14040,
       y__h14173,
       y__h14232,
       y__h14365,
       y__h14424,
       y__h14557,
       y__h14616,
       y__h14749,
       y__h14808,
       y__h14941,
       y__h15000,
       y__h15133,
       y__h15192,
       y__h15325,
       y__h15384,
       y__h15517,
       y__h15576,
       y__h15709,
       y__h15768,
       y__h15901,
       y__h15960,
       y__h16093,
       y__h16152,
       y__h16285,
       y__h16344,
       y__h16477,
       y__h16536,
       y__h16669,
       y__h1671,
       y__h16728,
       y__h16861,
       y__h16920,
       y__h17053,
       y__h17112,
       y__h17245,
       y__h17304,
       y__h1860,
       y__h2049,
       y__h2238,
       y__h2427,
       y__h2616,
       y__h2805,
       y__h2994,
       y__h3183,
       y__h3372,
       y__h3561,
       y__h3750,
       y__h3939,
       y__h4128,
       y__h4341,
       y__h4343,
       y__h4469,
       y__h4471,
       y__h4527,
       y__h4658,
       y__h4660,
       y__h4716,
       y__h4847,
       y__h4849,
       y__h4905,
       y__h5036,
       y__h5038,
       y__h5094,
       y__h5225,
       y__h5227,
       y__h5283,
       y__h5414,
       y__h5416,
       y__h5472,
       y__h5603,
       y__h5605,
       y__h5661,
       y__h5792,
       y__h5794,
       y__h5850,
       y__h5981,
       y__h5983,
       y__h6039,
       y__h6170,
       y__h6172,
       y__h6228,
       y__h6359,
       y__h6361,
       y__h6417,
       y__h6548,
       y__h6550,
       y__h6606,
       y__h6737,
       y__h6739,
       y__h6795,
       y__h6926,
       y__h6928,
       y__h6984,
       y__h7720,
       y__h7779,
       y__h7826,
       y__h7912,
       y__h7971,
       y__h8104,
       y__h8163,
       y__h8296,
       y__h8355,
       y__h8488,
       y__h8547,
       y__h8680,
       y__h8739,
       y__h8872,
       y__h8931,
       y__h9064,
       y__h9123,
       y__h9256,
       y__h9315,
       y__h9448,
       y__h9507,
       y__h9640,
       y__h9699,
       y__h9832,
       y__h9891;

  // action method get_A
  assign RDY_get_A =
	     !got_A && !mul_completed && !add_completed && !imac_completed ;
  assign CAN_FIRE_get_A =
	     !got_A && !mul_completed && !add_completed && !imac_completed ;
  assign WILL_FIRE_get_A = EN_get_A ;

  // action method get_B
  assign RDY_get_B =
	     !got_B && !mul_completed && !add_completed && !imac_completed ;
  assign CAN_FIRE_get_B =
	     !got_B && !mul_completed && !add_completed && !imac_completed ;
  assign WILL_FIRE_get_B = EN_get_B ;

  // action method get_C
  assign RDY_get_C =
	     !got_C && !mul_completed && !add_completed && !imac_completed ;
  assign CAN_FIRE_get_C =
	     !got_C && !mul_completed && !add_completed && !imac_completed ;
  assign WILL_FIRE_get_C = EN_get_C ;

  // value method ioutput_MAC
  assign ioutput_MAC = rg_MAC ;
  assign RDY_ioutput_MAC = imac_completed ;

  // rule RL_rl_multiply
  assign CAN_FIRE_RL_rl_multiply =
	     got_A && got_B && got_C && count != 5'd0 && reset_completed ;
  assign WILL_FIRE_RL_rl_multiply = CAN_FIRE_RL_rl_multiply ;

  // rule RL_mul_done
  assign CAN_FIRE_RL_mul_done =
	     count == 5'd0 && !mul_completed && !add_completed &&
	     !imac_completed ;
  assign WILL_FIRE_RL_mul_done = CAN_FIRE_RL_mul_done ;

  // rule RL_add
  assign CAN_FIRE_RL_add =
	     mul_completed && !add_completed && !imac_completed ;
  assign WILL_FIRE_RL_add = CAN_FIRE_RL_add ;

  // rule RL_windup
  assign CAN_FIRE_RL_windup = add_completed && !imac_completed ;
  assign WILL_FIRE_RL_windup = CAN_FIRE_RL_windup ;

  // rule RL_reset
  assign CAN_FIRE_RL_reset = imac_completed ;
  assign WILL_FIRE_RL_reset = imac_completed ;

  // inputs to muxes for submodule ports
  assign MUX_partial_store_write_1__SEL_1 =
	     WILL_FIRE_RL_rl_multiply && rg_B[0] ;
  assign MUX_count_write_1__VAL_2 = count - 5'd1 ;
  assign MUX_partial_store_write_1__VAL_1 =
	     (count == 5'd1) ? x__h652 : x__h7121 ;
  assign MUX_rg_A_write_1__VAL_1 = { rg_A[14:0], 1'd0 } ;
  assign MUX_rg_A_write_1__VAL_2 =
	     { {8{get_A_a_BITS_7_TO_0__q6[7]}}, get_A_a_BITS_7_TO_0__q6 } ;
  assign MUX_rg_B_write_1__VAL_1 = { 1'd0, rg_B[15:1] } ;
  assign MUX_rg_B_write_1__VAL_2 =
	     { {8{get_B_b_BITS_7_TO_0__q7[7]}}, get_B_b_BITS_7_TO_0__q7 } ;

  // register add_completed
  assign add_completed_D_IN = !WILL_FIRE_RL_windup ;
  assign add_completed_EN = WILL_FIRE_RL_windup || WILL_FIRE_RL_add ;

  // register count
  assign count_D_IN = WILL_FIRE_RL_windup ? 5'd9 : MUX_count_write_1__VAL_2 ;
  assign count_EN = WILL_FIRE_RL_rl_multiply || WILL_FIRE_RL_windup ;

  // register got_A
  assign got_A_D_IN = !imac_completed ;
  assign got_A_EN = imac_completed || EN_get_A ;

  // register got_B
  assign got_B_D_IN = !imac_completed ;
  assign got_B_EN = imac_completed || EN_get_B ;

  // register got_C
  assign got_C_D_IN = !imac_completed ;
  assign got_C_EN = imac_completed || EN_get_C ;

  // register imac_completed
  assign imac_completed_D_IN = !imac_completed ;
  assign imac_completed_EN = imac_completed || WILL_FIRE_RL_windup ;

  // register mul_completed
  assign mul_completed_D_IN = !WILL_FIRE_RL_add ;
  assign mul_completed_EN = WILL_FIRE_RL_add || WILL_FIRE_RL_mul_done ;

  // register partial_store
  assign partial_store_D_IN =
	     MUX_partial_store_write_1__SEL_1 ?
	       MUX_partial_store_write_1__VAL_1 :
	       16'd0 ;
  assign partial_store_EN =
	     WILL_FIRE_RL_rl_multiply && rg_B[0] || WILL_FIRE_RL_mul_done ;

  // register reset_completed
  assign reset_completed_D_IN = !WILL_FIRE_RL_mul_done ;
  assign reset_completed_EN = WILL_FIRE_RL_mul_done || imac_completed ;

  // register rg_A
  assign rg_A_D_IN =
	     WILL_FIRE_RL_rl_multiply ?
	       MUX_rg_A_write_1__VAL_1 :
	       MUX_rg_A_write_1__VAL_2 ;
  assign rg_A_EN = WILL_FIRE_RL_rl_multiply || EN_get_A ;

  // register rg_B
  assign rg_B_D_IN =
	     WILL_FIRE_RL_rl_multiply ?
	       MUX_rg_B_write_1__VAL_1 :
	       MUX_rg_B_write_1__VAL_2 ;
  assign rg_B_EN = WILL_FIRE_RL_rl_multiply || EN_get_B ;

  // register rg_C
  assign rg_C_D_IN = get_C_c ;
  assign rg_C_EN = EN_get_C ;

  // register rg_MAC
  assign rg_MAC_D_IN =
	     { x__h17244 ^ y__h17245,
	       x__h17350 ^ y__h17053,
	       rg_temp_84_BIT_29_93_XOR_rg_C_86_BIT_29_94_96__ETC___d520 } ;
  assign rg_MAC_EN = CAN_FIRE_RL_add ;

  // register rg_temp
  assign rg_temp_D_IN = { {16{partial_store[15]}}, partial_store } ;
  assign rg_temp_EN = CAN_FIRE_RL_mul_done ;

  // register start
  assign start_D_IN = 1'b0 ;
  assign start_EN = 1'b0 ;

  // remaining internal signals
  assign IF_INV_INV_rg_A_BIT_0_THEN_1_ELSE_0__q2 =
	     (~INV_rg_A__q1[0]) ? 16'd1 : 16'd0 ;
  assign IF_partial_store_BIT_0_XOR_IF_INV_INV_rg_A_BIT_ETC__q3 =
	     (partial_store[0] ^ IF_INV_INV_rg_A_BIT_0_THEN_1_ELSE_0__q2[0]) ?
	       16'd1 :
	       16'd0 ;
  assign IF_partial_store_BIT_0_XOR_rg_A_BIT_0_THEN_1_E_ETC__q4 =
	     (partial_store[0] ^ rg_A[0]) ? 16'd1 : 16'd0 ;
  assign IF_rg_temp_BIT_0_XOR_rg_C_BIT_0_THEN_1_ELSE_0__q5 =
	     (rg_temp[0] ^ rg_C[0]) ? 32'd1 : 32'd0 ;
  assign INV_rg_A__q1 = ~rg_A ;
  assign get_A_a_BITS_7_TO_0__q6 = get_A_a[7:0] ;
  assign get_B_b_BITS_7_TO_0__q7 = get_B_b[7:0] ;
  assign partial_store_5_BIT_11_3_XOR_INV_rg_A_7_8_BIT__ETC___d163 =
	     { x__h6169 ^ y__h6170,
	       x__h5980 ^ y__h5981,
	       partial_store_5_BIT_9_1_XOR_INV_rg_A_7_8_BIT_9_ETC___d162 } ;
  assign partial_store_5_BIT_11_3_XOR_rg_A_7_BIT_11_77__ETC___d263 =
	     { x__h9745 ^ y__h9448,
	       x__h9553 ^ y__h9256,
	       partial_store_5_BIT_9_1_XOR_rg_A_7_BIT_9_83_85_ETC___d262 } ;
  assign partial_store_5_BIT_13_5_XOR_INV_rg_A_7_8_BIT__ETC___d164 =
	     { x__h6547 ^ y__h6548,
	       x__h6358 ^ y__h6359,
	       partial_store_5_BIT_11_3_XOR_INV_rg_A_7_8_BIT__ETC___d163 } ;
  assign partial_store_5_BIT_13_5_XOR_rg_A_7_BIT_13_71__ETC___d264 =
	     { x__h10129 ^ y__h9832,
	       x__h9937 ^ y__h9640,
	       partial_store_5_BIT_11_3_XOR_rg_A_7_BIT_11_77__ETC___d263 } ;
  assign partial_store_5_BIT_1_03_XOR_INV_rg_A_7_8_BIT__ETC___d158 =
	     { x__h4340 ^ y__h4341,
	       IF_partial_store_BIT_0_XOR_IF_INV_INV_rg_A_BIT_ETC__q3[0] } ;
  assign partial_store_5_BIT_1_03_XOR_rg_A_7_BIT_1_07_0_ETC___d258 =
	     { x__h7825 ^ y__h7826,
	       IF_partial_store_BIT_0_XOR_rg_A_BIT_0_THEN_1_E_ETC__q4[0] } ;
  assign partial_store_5_BIT_3_5_XOR_INV_rg_A_7_8_BIT_3_ETC___d159 =
	     { x__h4657 ^ y__h4658,
	       x__h4468 ^ y__h4469,
	       partial_store_5_BIT_1_03_XOR_INV_rg_A_7_8_BIT__ETC___d158 } ;
  assign partial_store_5_BIT_3_5_XOR_rg_A_7_BIT_3_01_03_ETC___d259 =
	     { x__h8209 ^ y__h7912,
	       x__h8017 ^ y__h7720,
	       partial_store_5_BIT_1_03_XOR_rg_A_7_BIT_1_07_0_ETC___d258 } ;
  assign partial_store_5_BIT_5_7_XOR_INV_rg_A_7_8_BIT_5_ETC___d160 =
	     { x__h5035 ^ y__h5036,
	       x__h4846 ^ y__h4847,
	       partial_store_5_BIT_3_5_XOR_INV_rg_A_7_8_BIT_3_ETC___d159 } ;
  assign partial_store_5_BIT_5_7_XOR_rg_A_7_BIT_5_95_97_ETC___d260 =
	     { x__h8593 ^ y__h8296,
	       x__h8401 ^ y__h8104,
	       partial_store_5_BIT_3_5_XOR_rg_A_7_BIT_3_01_03_ETC___d259 } ;
  assign partial_store_5_BIT_7_9_XOR_INV_rg_A_7_8_BIT_7_ETC___d161 =
	     { x__h5413 ^ y__h5414,
	       x__h5224 ^ y__h5225,
	       partial_store_5_BIT_5_7_XOR_INV_rg_A_7_8_BIT_5_ETC___d160 } ;
  assign partial_store_5_BIT_7_9_XOR_rg_A_7_BIT_7_89_91_ETC___d261 =
	     { x__h8977 ^ y__h8680,
	       x__h8785 ^ y__h8488,
	       partial_store_5_BIT_5_7_XOR_rg_A_7_BIT_5_95_97_ETC___d260 } ;
  assign partial_store_5_BIT_9_1_XOR_INV_rg_A_7_8_BIT_9_ETC___d162 =
	     { x__h5791 ^ y__h5792,
	       x__h5602 ^ y__h5603,
	       partial_store_5_BIT_7_9_XOR_INV_rg_A_7_8_BIT_7_ETC___d161 } ;
  assign partial_store_5_BIT_9_1_XOR_rg_A_7_BIT_9_83_85_ETC___d262 =
	     { x__h9361 ^ y__h9064,
	       x__h9169 ^ y__h8872,
	       partial_store_5_BIT_7_9_XOR_rg_A_7_BIT_7_89_91_ETC___d261 } ;
  assign rg_temp_84_BIT_11_65_XOR_rg_C_86_BIT_11_66_68__ETC___d511 =
	     { x__h13702 ^ y__h13405,
	       x__h13510 ^ y__h13213,
	       rg_temp_84_BIT_9_73_XOR_rg_C_86_BIT_9_74_76_XO_ETC___d510 } ;
  assign rg_temp_84_BIT_13_57_XOR_rg_C_86_BIT_13_58_60__ETC___d512 =
	     { x__h14086 ^ y__h13789,
	       x__h13894 ^ y__h13597,
	       rg_temp_84_BIT_11_65_XOR_rg_C_86_BIT_11_66_68__ETC___d511 } ;
  assign rg_temp_84_BIT_15_49_XOR_rg_C_86_BIT_15_50_52__ETC___d513 =
	     { x__h14470 ^ y__h14173,
	       x__h14278 ^ y__h13981,
	       rg_temp_84_BIT_13_57_XOR_rg_C_86_BIT_13_58_60__ETC___d512 } ;
  assign rg_temp_84_BIT_17_41_XOR_rg_C_86_BIT_17_42_44__ETC___d514 =
	     { x__h14854 ^ y__h14557,
	       x__h14662 ^ y__h14365,
	       rg_temp_84_BIT_15_49_XOR_rg_C_86_BIT_15_50_52__ETC___d513 } ;
  assign rg_temp_84_BIT_19_33_XOR_rg_C_86_BIT_19_34_36__ETC___d515 =
	     { x__h15238 ^ y__h14941,
	       x__h15046 ^ y__h14749,
	       rg_temp_84_BIT_17_41_XOR_rg_C_86_BIT_17_42_44__ETC___d514 } ;
  assign rg_temp_84_BIT_1_05_XOR_rg_C_86_BIT_1_06_08_XO_ETC___d506 =
	     { x__h11782 ^ y__h11783,
	       IF_rg_temp_BIT_0_XOR_rg_C_BIT_0_THEN_1_ELSE_0__q5[0] } ;
  assign rg_temp_84_BIT_21_25_XOR_rg_C_86_BIT_21_26_28__ETC___d516 =
	     { x__h15622 ^ y__h15325,
	       x__h15430 ^ y__h15133,
	       rg_temp_84_BIT_19_33_XOR_rg_C_86_BIT_19_34_36__ETC___d515 } ;
  assign rg_temp_84_BIT_23_17_XOR_rg_C_86_BIT_23_18_20__ETC___d517 =
	     { x__h16006 ^ y__h15709,
	       x__h15814 ^ y__h15517,
	       rg_temp_84_BIT_21_25_XOR_rg_C_86_BIT_21_26_28__ETC___d516 } ;
  assign rg_temp_84_BIT_25_09_XOR_rg_C_86_BIT_25_10_12__ETC___d518 =
	     { x__h16390 ^ y__h16093,
	       x__h16198 ^ y__h15901,
	       rg_temp_84_BIT_23_17_XOR_rg_C_86_BIT_23_18_20__ETC___d517 } ;
  assign rg_temp_84_BIT_27_01_XOR_rg_C_86_BIT_27_02_04__ETC___d519 =
	     { x__h16774 ^ y__h16477,
	       x__h16582 ^ y__h16285,
	       rg_temp_84_BIT_25_09_XOR_rg_C_86_BIT_25_10_12__ETC___d518 } ;
  assign rg_temp_84_BIT_29_93_XOR_rg_C_86_BIT_29_94_96__ETC___d520 =
	     { x__h17158 ^ y__h16861,
	       x__h16966 ^ y__h16669,
	       rg_temp_84_BIT_27_01_XOR_rg_C_86_BIT_27_02_04__ETC___d519 } ;
  assign rg_temp_84_BIT_3_97_XOR_rg_C_86_BIT_3_98_00_XO_ETC___d507 =
	     { x__h12166 ^ y__h11869,
	       x__h11974 ^ y__h11677,
	       rg_temp_84_BIT_1_05_XOR_rg_C_86_BIT_1_06_08_XO_ETC___d506 } ;
  assign rg_temp_84_BIT_5_89_XOR_rg_C_86_BIT_5_90_92_XO_ETC___d508 =
	     { x__h12550 ^ y__h12253,
	       x__h12358 ^ y__h12061,
	       rg_temp_84_BIT_3_97_XOR_rg_C_86_BIT_3_98_00_XO_ETC___d507 } ;
  assign rg_temp_84_BIT_7_81_XOR_rg_C_86_BIT_7_82_84_XO_ETC___d509 =
	     { x__h12934 ^ y__h12637,
	       x__h12742 ^ y__h12445,
	       rg_temp_84_BIT_5_89_XOR_rg_C_86_BIT_5_90_92_XO_ETC___d508 } ;
  assign rg_temp_84_BIT_9_73_XOR_rg_C_86_BIT_9_74_76_XO_ETC___d510 =
	     { x__h13318 ^ y__h13021,
	       x__h13126 ^ y__h12829,
	       rg_temp_84_BIT_7_81_XOR_rg_C_86_BIT_7_82_84_XO_ETC___d509 } ;
  assign x__h10082 = partial_store[13] & rg_A[13] ;
  assign x__h10129 = partial_store[13] ^ rg_A[13] ;
  assign x__h10215 = partial_store[15] ^ rg_A[15] ;
  assign x__h10274 = partial_store[14] & rg_A[14] ;
  assign x__h10321 = partial_store[14] ^ rg_A[14] ;
  assign x__h11735 = rg_temp[1] & rg_C[1] ;
  assign x__h11782 = rg_temp[1] ^ rg_C[1] ;
  assign x__h11927 = rg_temp[2] & rg_C[2] ;
  assign x__h11974 = rg_temp[2] ^ rg_C[2] ;
  assign x__h12119 = rg_temp[3] & rg_C[3] ;
  assign x__h12166 = rg_temp[3] ^ rg_C[3] ;
  assign x__h12311 = rg_temp[4] & rg_C[4] ;
  assign x__h12358 = rg_temp[4] ^ rg_C[4] ;
  assign x__h12503 = rg_temp[5] & rg_C[5] ;
  assign x__h12550 = rg_temp[5] ^ rg_C[5] ;
  assign x__h12695 = rg_temp[6] & rg_C[6] ;
  assign x__h12742 = rg_temp[6] ^ rg_C[6] ;
  assign x__h12887 = rg_temp[7] & rg_C[7] ;
  assign x__h12934 = rg_temp[7] ^ rg_C[7] ;
  assign x__h13079 = rg_temp[8] & rg_C[8] ;
  assign x__h13126 = rg_temp[8] ^ rg_C[8] ;
  assign x__h13271 = rg_temp[9] & rg_C[9] ;
  assign x__h13318 = rg_temp[9] ^ rg_C[9] ;
  assign x__h13463 = rg_temp[10] & rg_C[10] ;
  assign x__h13510 = rg_temp[10] ^ rg_C[10] ;
  assign x__h13655 = rg_temp[11] & rg_C[11] ;
  assign x__h13702 = rg_temp[11] ^ rg_C[11] ;
  assign x__h13847 = rg_temp[12] & rg_C[12] ;
  assign x__h13894 = rg_temp[12] ^ rg_C[12] ;
  assign x__h14039 = rg_temp[13] & rg_C[13] ;
  assign x__h14086 = rg_temp[13] ^ rg_C[13] ;
  assign x__h14231 = rg_temp[14] & rg_C[14] ;
  assign x__h14278 = rg_temp[14] ^ rg_C[14] ;
  assign x__h14423 = rg_temp[15] & rg_C[15] ;
  assign x__h14470 = rg_temp[15] ^ rg_C[15] ;
  assign x__h14615 = rg_temp[16] & rg_C[16] ;
  assign x__h14662 = rg_temp[16] ^ rg_C[16] ;
  assign x__h14807 = rg_temp[17] & rg_C[17] ;
  assign x__h14854 = rg_temp[17] ^ rg_C[17] ;
  assign x__h14999 = rg_temp[18] & rg_C[18] ;
  assign x__h15046 = rg_temp[18] ^ rg_C[18] ;
  assign x__h15191 = rg_temp[19] & rg_C[19] ;
  assign x__h15238 = rg_temp[19] ^ rg_C[19] ;
  assign x__h15383 = rg_temp[20] & rg_C[20] ;
  assign x__h15430 = rg_temp[20] ^ rg_C[20] ;
  assign x__h15575 = rg_temp[21] & rg_C[21] ;
  assign x__h15622 = rg_temp[21] ^ rg_C[21] ;
  assign x__h15767 = rg_temp[22] & rg_C[22] ;
  assign x__h15814 = rg_temp[22] ^ rg_C[22] ;
  assign x__h15959 = rg_temp[23] & rg_C[23] ;
  assign x__h16006 = rg_temp[23] ^ rg_C[23] ;
  assign x__h16151 = rg_temp[24] & rg_C[24] ;
  assign x__h16198 = rg_temp[24] ^ rg_C[24] ;
  assign x__h16343 = rg_temp[25] & rg_C[25] ;
  assign x__h16390 = rg_temp[25] ^ rg_C[25] ;
  assign x__h16535 = rg_temp[26] & rg_C[26] ;
  assign x__h16582 = rg_temp[26] ^ rg_C[26] ;
  assign x__h16727 = rg_temp[27] & rg_C[27] ;
  assign x__h16774 = rg_temp[27] ^ rg_C[27] ;
  assign x__h16919 = rg_temp[28] & rg_C[28] ;
  assign x__h16966 = rg_temp[28] ^ rg_C[28] ;
  assign x__h17111 = rg_temp[29] & rg_C[29] ;
  assign x__h17158 = rg_temp[29] ^ rg_C[29] ;
  assign x__h17244 = rg_temp[31] ^ rg_C[31] ;
  assign x__h17303 = rg_temp[30] & rg_C[30] ;
  assign x__h17350 = rg_temp[30] ^ rg_C[30] ;
  assign x__h4340 = partial_store[1] ^ y__h4343 ;
  assign x__h4468 = partial_store[2] ^ y__h4471 ;
  assign x__h4526 = partial_store[1] & y__h4343 ;
  assign x__h4657 = partial_store[3] ^ y__h4660 ;
  assign x__h4715 = partial_store[2] & y__h4471 ;
  assign x__h4846 = partial_store[4] ^ y__h4849 ;
  assign x__h4904 = partial_store[3] & y__h4660 ;
  assign x__h5035 = partial_store[5] ^ y__h5038 ;
  assign x__h5093 = partial_store[4] & y__h4849 ;
  assign x__h5224 = partial_store[6] ^ y__h5227 ;
  assign x__h5282 = partial_store[5] & y__h5038 ;
  assign x__h5413 = partial_store[7] ^ y__h5416 ;
  assign x__h5471 = partial_store[6] & y__h5227 ;
  assign x__h5602 = partial_store[8] ^ y__h5605 ;
  assign x__h5660 = partial_store[7] & y__h5416 ;
  assign x__h5791 = partial_store[9] ^ y__h5794 ;
  assign x__h5849 = partial_store[8] & y__h5605 ;
  assign x__h5980 = partial_store[10] ^ y__h5983 ;
  assign x__h6038 = partial_store[9] & y__h5794 ;
  assign x__h6169 = partial_store[11] ^ y__h6172 ;
  assign x__h6227 = partial_store[10] & y__h5983 ;
  assign x__h6358 = partial_store[12] ^ y__h6361 ;
  assign x__h6416 = partial_store[11] & y__h6172 ;
  assign x__h652 =
	     { x__h6925 ^ y__h6926,
	       x__h6736 ^ y__h6737,
	       partial_store_5_BIT_13_5_XOR_INV_rg_A_7_8_BIT__ETC___d164 } ;
  assign x__h6547 = partial_store[13] ^ y__h6550 ;
  assign x__h6605 = partial_store[12] & y__h6361 ;
  assign x__h6736 = partial_store[14] ^ y__h6739 ;
  assign x__h6794 = partial_store[13] & y__h6550 ;
  assign x__h6925 = partial_store[15] ^ y__h6928 ;
  assign x__h6983 = partial_store[14] & y__h6739 ;
  assign x__h7121 =
	     { x__h10215 ^ y__h10216,
	       x__h10321 ^ y__h10024,
	       partial_store_5_BIT_13_5_XOR_rg_A_7_BIT_13_71__ETC___d264 } ;
  assign x__h7778 = partial_store[1] & rg_A[1] ;
  assign x__h7825 = partial_store[1] ^ rg_A[1] ;
  assign x__h7970 = partial_store[2] & rg_A[2] ;
  assign x__h8017 = partial_store[2] ^ rg_A[2] ;
  assign x__h8162 = partial_store[3] & rg_A[3] ;
  assign x__h8209 = partial_store[3] ^ rg_A[3] ;
  assign x__h8354 = partial_store[4] & rg_A[4] ;
  assign x__h8401 = partial_store[4] ^ rg_A[4] ;
  assign x__h8546 = partial_store[5] & rg_A[5] ;
  assign x__h8593 = partial_store[5] ^ rg_A[5] ;
  assign x__h8738 = partial_store[6] & rg_A[6] ;
  assign x__h8785 = partial_store[6] ^ rg_A[6] ;
  assign x__h8930 = partial_store[7] & rg_A[7] ;
  assign x__h8977 = partial_store[7] ^ rg_A[7] ;
  assign x__h9122 = partial_store[8] & rg_A[8] ;
  assign x__h9169 = partial_store[8] ^ rg_A[8] ;
  assign x__h9314 = partial_store[9] & rg_A[9] ;
  assign x__h9361 = partial_store[9] ^ rg_A[9] ;
  assign x__h9506 = partial_store[10] & rg_A[10] ;
  assign x__h9553 = partial_store[10] ^ rg_A[10] ;
  assign x__h9698 = partial_store[11] & rg_A[11] ;
  assign x__h9745 = partial_store[11] ^ rg_A[11] ;
  assign x__h9890 = partial_store[12] & rg_A[12] ;
  assign x__h9937 = partial_store[12] ^ rg_A[12] ;
  assign y__h10024 = x__h10082 | y__h10083 ;
  assign y__h10083 = x__h10129 & y__h9832 ;
  assign y__h10216 = x__h10274 | y__h10275 ;
  assign y__h10275 = x__h10321 & y__h10024 ;
  assign y__h11677 = x__h11735 | y__h11736 ;
  assign y__h11736 = x__h11782 & y__h11783 ;
  assign y__h11783 = rg_temp[0] & rg_C[0] ;
  assign y__h11869 = x__h11927 | y__h11928 ;
  assign y__h11928 = x__h11974 & y__h11677 ;
  assign y__h12061 = x__h12119 | y__h12120 ;
  assign y__h12120 = x__h12166 & y__h11869 ;
  assign y__h12253 = x__h12311 | y__h12312 ;
  assign y__h12312 = x__h12358 & y__h12061 ;
  assign y__h12445 = x__h12503 | y__h12504 ;
  assign y__h12504 = x__h12550 & y__h12253 ;
  assign y__h12637 = x__h12695 | y__h12696 ;
  assign y__h12696 = x__h12742 & y__h12445 ;
  assign y__h12829 = x__h12887 | y__h12888 ;
  assign y__h12888 = x__h12934 & y__h12637 ;
  assign y__h13021 = x__h13079 | y__h13080 ;
  assign y__h13080 = x__h13126 & y__h12829 ;
  assign y__h13213 = x__h13271 | y__h13272 ;
  assign y__h13272 = x__h13318 & y__h13021 ;
  assign y__h13405 = x__h13463 | y__h13464 ;
  assign y__h13464 = x__h13510 & y__h13213 ;
  assign y__h13597 = x__h13655 | y__h13656 ;
  assign y__h13656 = x__h13702 & y__h13405 ;
  assign y__h13789 = x__h13847 | y__h13848 ;
  assign y__h13848 = x__h13894 & y__h13597 ;
  assign y__h13981 = x__h14039 | y__h14040 ;
  assign y__h14040 = x__h14086 & y__h13789 ;
  assign y__h14173 = x__h14231 | y__h14232 ;
  assign y__h14232 = x__h14278 & y__h13981 ;
  assign y__h14365 = x__h14423 | y__h14424 ;
  assign y__h14424 = x__h14470 & y__h14173 ;
  assign y__h14557 = x__h14615 | y__h14616 ;
  assign y__h14616 = x__h14662 & y__h14365 ;
  assign y__h14749 = x__h14807 | y__h14808 ;
  assign y__h14808 = x__h14854 & y__h14557 ;
  assign y__h14941 = x__h14999 | y__h15000 ;
  assign y__h15000 = x__h15046 & y__h14749 ;
  assign y__h15133 = x__h15191 | y__h15192 ;
  assign y__h15192 = x__h15238 & y__h14941 ;
  assign y__h15325 = x__h15383 | y__h15384 ;
  assign y__h15384 = x__h15430 & y__h15133 ;
  assign y__h15517 = x__h15575 | y__h15576 ;
  assign y__h15576 = x__h15622 & y__h15325 ;
  assign y__h15709 = x__h15767 | y__h15768 ;
  assign y__h15768 = x__h15814 & y__h15517 ;
  assign y__h15901 = x__h15959 | y__h15960 ;
  assign y__h15960 = x__h16006 & y__h15709 ;
  assign y__h16093 = x__h16151 | y__h16152 ;
  assign y__h16152 = x__h16198 & y__h15901 ;
  assign y__h16285 = x__h16343 | y__h16344 ;
  assign y__h16344 = x__h16390 & y__h16093 ;
  assign y__h16477 = x__h16535 | y__h16536 ;
  assign y__h16536 = x__h16582 & y__h16285 ;
  assign y__h16669 = x__h16727 | y__h16728 ;
  assign y__h1671 = INV_rg_A__q1[1] & INV_rg_A__q1[0] ;
  assign y__h16728 = x__h16774 & y__h16477 ;
  assign y__h16861 = x__h16919 | y__h16920 ;
  assign y__h16920 = x__h16966 & y__h16669 ;
  assign y__h17053 = x__h17111 | y__h17112 ;
  assign y__h17112 = x__h17158 & y__h16861 ;
  assign y__h17245 = x__h17303 | y__h17304 ;
  assign y__h17304 = x__h17350 & y__h17053 ;
  assign y__h1860 = INV_rg_A__q1[2] & y__h1671 ;
  assign y__h2049 = INV_rg_A__q1[3] & y__h1860 ;
  assign y__h2238 = INV_rg_A__q1[4] & y__h2049 ;
  assign y__h2427 = INV_rg_A__q1[5] & y__h2238 ;
  assign y__h2616 = INV_rg_A__q1[6] & y__h2427 ;
  assign y__h2805 = INV_rg_A__q1[7] & y__h2616 ;
  assign y__h2994 = INV_rg_A__q1[8] & y__h2805 ;
  assign y__h3183 = INV_rg_A__q1[9] & y__h2994 ;
  assign y__h3372 = INV_rg_A__q1[10] & y__h3183 ;
  assign y__h3561 = INV_rg_A__q1[11] & y__h3372 ;
  assign y__h3750 = INV_rg_A__q1[12] & y__h3561 ;
  assign y__h3939 = INV_rg_A__q1[13] & y__h3750 ;
  assign y__h4128 = INV_rg_A__q1[14] & y__h3939 ;
  assign y__h4341 =
	     partial_store[0] & IF_INV_INV_rg_A_BIT_0_THEN_1_ELSE_0__q2[0] ;
  assign y__h4343 = INV_rg_A__q1[1] ^ INV_rg_A__q1[0] ;
  assign y__h4469 = x__h4526 | y__h4527 ;
  assign y__h4471 = INV_rg_A__q1[2] ^ y__h1671 ;
  assign y__h4527 = x__h4340 & y__h4341 ;
  assign y__h4658 = x__h4715 | y__h4716 ;
  assign y__h4660 = INV_rg_A__q1[3] ^ y__h1860 ;
  assign y__h4716 = x__h4468 & y__h4469 ;
  assign y__h4847 = x__h4904 | y__h4905 ;
  assign y__h4849 = INV_rg_A__q1[4] ^ y__h2049 ;
  assign y__h4905 = x__h4657 & y__h4658 ;
  assign y__h5036 = x__h5093 | y__h5094 ;
  assign y__h5038 = INV_rg_A__q1[5] ^ y__h2238 ;
  assign y__h5094 = x__h4846 & y__h4847 ;
  assign y__h5225 = x__h5282 | y__h5283 ;
  assign y__h5227 = INV_rg_A__q1[6] ^ y__h2427 ;
  assign y__h5283 = x__h5035 & y__h5036 ;
  assign y__h5414 = x__h5471 | y__h5472 ;
  assign y__h5416 = INV_rg_A__q1[7] ^ y__h2616 ;
  assign y__h5472 = x__h5224 & y__h5225 ;
  assign y__h5603 = x__h5660 | y__h5661 ;
  assign y__h5605 = INV_rg_A__q1[8] ^ y__h2805 ;
  assign y__h5661 = x__h5413 & y__h5414 ;
  assign y__h5792 = x__h5849 | y__h5850 ;
  assign y__h5794 = INV_rg_A__q1[9] ^ y__h2994 ;
  assign y__h5850 = x__h5602 & y__h5603 ;
  assign y__h5981 = x__h6038 | y__h6039 ;
  assign y__h5983 = INV_rg_A__q1[10] ^ y__h3183 ;
  assign y__h6039 = x__h5791 & y__h5792 ;
  assign y__h6170 = x__h6227 | y__h6228 ;
  assign y__h6172 = INV_rg_A__q1[11] ^ y__h3372 ;
  assign y__h6228 = x__h5980 & y__h5981 ;
  assign y__h6359 = x__h6416 | y__h6417 ;
  assign y__h6361 = INV_rg_A__q1[12] ^ y__h3561 ;
  assign y__h6417 = x__h6169 & y__h6170 ;
  assign y__h6548 = x__h6605 | y__h6606 ;
  assign y__h6550 = INV_rg_A__q1[13] ^ y__h3750 ;
  assign y__h6606 = x__h6358 & y__h6359 ;
  assign y__h6737 = x__h6794 | y__h6795 ;
  assign y__h6739 = INV_rg_A__q1[14] ^ y__h3939 ;
  assign y__h6795 = x__h6547 & y__h6548 ;
  assign y__h6926 = x__h6983 | y__h6984 ;
  assign y__h6928 = INV_rg_A__q1[15] ^ y__h4128 ;
  assign y__h6984 = x__h6736 & y__h6737 ;
  assign y__h7720 = x__h7778 | y__h7779 ;
  assign y__h7779 = x__h7825 & y__h7826 ;
  assign y__h7826 = partial_store[0] & rg_A[0] ;
  assign y__h7912 = x__h7970 | y__h7971 ;
  assign y__h7971 = x__h8017 & y__h7720 ;
  assign y__h8104 = x__h8162 | y__h8163 ;
  assign y__h8163 = x__h8209 & y__h7912 ;
  assign y__h8296 = x__h8354 | y__h8355 ;
  assign y__h8355 = x__h8401 & y__h8104 ;
  assign y__h8488 = x__h8546 | y__h8547 ;
  assign y__h8547 = x__h8593 & y__h8296 ;
  assign y__h8680 = x__h8738 | y__h8739 ;
  assign y__h8739 = x__h8785 & y__h8488 ;
  assign y__h8872 = x__h8930 | y__h8931 ;
  assign y__h8931 = x__h8977 & y__h8680 ;
  assign y__h9064 = x__h9122 | y__h9123 ;
  assign y__h9123 = x__h9169 & y__h8872 ;
  assign y__h9256 = x__h9314 | y__h9315 ;
  assign y__h9315 = x__h9361 & y__h9064 ;
  assign y__h9448 = x__h9506 | y__h9507 ;
  assign y__h9507 = x__h9553 & y__h9256 ;
  assign y__h9640 = x__h9698 | y__h9699 ;
  assign y__h9699 = x__h9745 & y__h9448 ;
  assign y__h9832 = x__h9890 | y__h9891 ;
  assign y__h9891 = x__h9937 & y__h9640 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        add_completed <= `BSV_ASSIGNMENT_DELAY 1'd0;
	count <= `BSV_ASSIGNMENT_DELAY 5'd9;
	got_A <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_B <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_C <= `BSV_ASSIGNMENT_DELAY 1'd0;
	imac_completed <= `BSV_ASSIGNMENT_DELAY 1'd0;
	mul_completed <= `BSV_ASSIGNMENT_DELAY 1'd0;
	partial_store <= `BSV_ASSIGNMENT_DELAY 16'd0;
	reset_completed <= `BSV_ASSIGNMENT_DELAY 1'd1;
	rg_A <= `BSV_ASSIGNMENT_DELAY 16'd0;
	rg_B <= `BSV_ASSIGNMENT_DELAY 16'd0;
	rg_C <= `BSV_ASSIGNMENT_DELAY 32'd0;
	rg_MAC <= `BSV_ASSIGNMENT_DELAY 32'd0;
	rg_temp <= `BSV_ASSIGNMENT_DELAY 32'd0;
	start <= `BSV_ASSIGNMENT_DELAY 1'd0;
      end
    else
      begin
        if (add_completed_EN)
	  add_completed <= `BSV_ASSIGNMENT_DELAY add_completed_D_IN;
	if (count_EN) count <= `BSV_ASSIGNMENT_DELAY count_D_IN;
	if (got_A_EN) got_A <= `BSV_ASSIGNMENT_DELAY got_A_D_IN;
	if (got_B_EN) got_B <= `BSV_ASSIGNMENT_DELAY got_B_D_IN;
	if (got_C_EN) got_C <= `BSV_ASSIGNMENT_DELAY got_C_D_IN;
	if (imac_completed_EN)
	  imac_completed <= `BSV_ASSIGNMENT_DELAY imac_completed_D_IN;
	if (mul_completed_EN)
	  mul_completed <= `BSV_ASSIGNMENT_DELAY mul_completed_D_IN;
	if (partial_store_EN)
	  partial_store <= `BSV_ASSIGNMENT_DELAY partial_store_D_IN;
	if (reset_completed_EN)
	  reset_completed <= `BSV_ASSIGNMENT_DELAY reset_completed_D_IN;
	if (rg_A_EN) rg_A <= `BSV_ASSIGNMENT_DELAY rg_A_D_IN;
	if (rg_B_EN) rg_B <= `BSV_ASSIGNMENT_DELAY rg_B_D_IN;
	if (rg_C_EN) rg_C <= `BSV_ASSIGNMENT_DELAY rg_C_D_IN;
	if (rg_MAC_EN) rg_MAC <= `BSV_ASSIGNMENT_DELAY rg_MAC_D_IN;
	if (rg_temp_EN) rg_temp <= `BSV_ASSIGNMENT_DELAY rg_temp_D_IN;
	if (start_EN) start <= `BSV_ASSIGNMENT_DELAY start_D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    add_completed = 1'h0;
    count = 5'h0A;
    got_A = 1'h0;
    got_B = 1'h0;
    got_C = 1'h0;
    imac_completed = 1'h0;
    mul_completed = 1'h0;
    partial_store = 16'hAAAA;
    reset_completed = 1'h0;
    rg_A = 16'hAAAA;
    rg_B = 16'hAAAA;
    rg_C = 32'hAAAAAAAA;
    rg_MAC = 32'hAAAAAAAA;
    rg_temp = 32'hAAAAAAAA;
    start = 1'h0;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkMAC_int32

