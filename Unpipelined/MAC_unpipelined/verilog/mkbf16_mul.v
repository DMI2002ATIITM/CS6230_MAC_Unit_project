//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Sat Oct 26 21:27:04 IST 2024
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_A                      O     1
// RDY_get_B                      O     1
// out_AB                         O    16 reg
// RDY_out_AB                     O     1 reg
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_A_a                        I    16 reg
// get_B_b                        I    16 reg
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

module mkbf16_mul(CLK,
		  RST_N,

		  get_A_a,
		  EN_get_A,
		  RDY_get_A,

		  get_B_b,
		  EN_get_B,
		  RDY_get_B,

		  out_AB,
		  RDY_out_AB);
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

  // value method out_AB
  output [15 : 0] out_AB;
  output RDY_out_AB;

  // signals for module outputs
  wire [15 : 0] out_AB;
  wire RDY_get_A, RDY_get_B, RDY_out_AB;

  // register assembled_answer
  reg assembled_answer;
  wire assembled_answer_D_IN, assembled_answer_EN;

  // register bf_a
  reg [15 : 0] bf_a;
  wire [15 : 0] bf_a_D_IN;
  wire bf_a_EN;

  // register bf_b
  reg [15 : 0] bf_b;
  wire [15 : 0] bf_b_D_IN;
  wire bf_b_EN;

  // register bf_c
  reg [15 : 0] bf_c;
  wire [15 : 0] bf_c_D_IN;
  wire bf_c_EN;

  // register calculate_mantissa
  reg calculate_mantissa;
  wire calculate_mantissa_D_IN, calculate_mantissa_EN;

  // register count
  reg [4 : 0] count;
  wire [4 : 0] count_D_IN;
  wire count_EN;

  // register exp_c
  reg [7 : 0] exp_c;
  wire [7 : 0] exp_c_D_IN;
  wire exp_c_EN;

  // register expone_calculated
  reg expone_calculated;
  wire expone_calculated_D_IN, expone_calculated_EN;

  // register final_output
  reg [15 : 0] final_output;
  wire [15 : 0] final_output_D_IN;
  wire final_output_EN;

  // register got_A
  reg got_A;
  wire got_A_D_IN, got_A_EN;

  // register got_B
  reg got_B;
  wire got_B_D_IN, got_B_EN;

  // register man_c
  reg [6 : 0] man_c;
  wire [6 : 0] man_c_D_IN;
  wire man_c_EN;

  // register man_c_and_final_exp
  reg [14 : 0] man_c_and_final_exp;
  wire [14 : 0] man_c_and_final_exp_D_IN;
  wire man_c_and_final_exp_EN;

  // register rounding_done
  reg rounding_done;
  wire rounding_done_D_IN, rounding_done_EN;

  // register sign_c
  reg sign_c;
  wire sign_c_D_IN, sign_c_EN;

  // register sign_calculated
  reg sign_calculated;
  wire sign_calculated_D_IN, sign_calculated_EN;

  // register temp_A
  reg [15 : 0] temp_A;
  wire [15 : 0] temp_A_D_IN;
  wire temp_A_EN;

  // register temp_B
  reg [15 : 0] temp_B;
  wire [15 : 0] temp_B_D_IN;
  wire temp_B_EN;

  // register temp_prod
  reg [15 : 0] temp_prod;
  wire [15 : 0] temp_prod_D_IN;
  wire temp_prod_EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_assemble_answer,
       CAN_FIRE_RL_calculate_expone,
       CAN_FIRE_RL_calculate_sign,
       CAN_FIRE_RL_deassert_assembled_answer,
       CAN_FIRE_RL_rl_multiply,
       CAN_FIRE_RL_round_nearest,
       CAN_FIRE_get_A,
       CAN_FIRE_get_B,
       WILL_FIRE_RL_assemble_answer,
       WILL_FIRE_RL_calculate_expone,
       WILL_FIRE_RL_calculate_sign,
       WILL_FIRE_RL_deassert_assembled_answer,
       WILL_FIRE_RL_rl_multiply,
       WILL_FIRE_RL_round_nearest,
       WILL_FIRE_get_A,
       WILL_FIRE_get_B;

  // inputs to muxes for submodule ports
  wire [15 : 0] MUX_temp_A_write_1__VAL_1,
		MUX_temp_A_write_1__VAL_2,
		MUX_temp_B_write_1__VAL_1,
		MUX_temp_B_write_1__VAL_2,
		MUX_temp_prod_write_1__VAL_2;
  wire [4 : 0] MUX_count_write_1__VAL_2;
  wire MUX_count_write_1__SEL_1;

  // remaining internal signals
  wire [15 : 0] IF_temp_prod_BIT_0_XOR_temp_A_BIT_0_THEN_1_ELSE_0__q5;
  wire [14 : 0] IF_IF_temp_prod_04_BIT_15_05_THEN_IF_NOT_temp__ETC__q8;
  wire [13 : 0] temp_prod_04_BIT_13_13_XOR_temp_A_06_BIT_13_14_ETC___d220;
  wire [11 : 0] temp_prod_04_BIT_11_21_XOR_temp_A_06_BIT_11_22_ETC___d219;
  wire [9 : 0] temp_prod_04_BIT_9_29_XOR_temp_A_06_BIT_9_30_3_ETC___d218;
  wire [8 : 0] IF_INV_temp_prod_BIT_7_THEN_1_ELSE_0__q7,
	       IF_INV_temp_prod_BIT_8_THEN_1_ELSE_0__q6;
  wire [7 : 0] IF_INV_IF_INV_exp_c_BIT_0_THEN_1_ELSE_0_BIT_0__ETC__q3,
	       IF_INV_IF_bf_a_BIT_7_XOR_bf_b_BIT_7_THEN_1_ELS_ETC__q4,
	       IF_INV_exp_c_BIT_0_THEN_1_ELSE_0__q2,
	       IF_bf_a_BIT_7_XOR_bf_b_BIT_7_THEN_1_ELSE_0__q1,
	       _theResult___snd__h11720,
	       _theResult___snd_fst__h11795,
	       _theResult___snd_fst__h14811,
	       _theResult___snd_fst__h14819,
	       exp_c_39_BIT_7_40_XOR_exp_c_39_BIT_6_41_AND_ex_ETC___d294,
	       temp_prod_04_BIT_7_37_XOR_temp_A_06_BIT_7_38_4_ETC___d217,
	       x__h11792;
  wire [6 : 0] IF_NOT_temp_prod_04_BIT_6_41_97_OR_temp_prod_0_ETC___d350,
	       IF_NOT_temp_prod_04_BIT_7_37_33_OR_temp_prod_0_ETC___d331,
	       IF_temp_prod_04_BIT_15_05_THEN_IF_NOT_temp_pro_ETC___d351,
	       x__h11723,
	       x__h11746,
	       x__h9788,
	       x__h9811;
  wire [5 : 0] bf_a_BIT_12_4_XOR_bf_b_0_BIT_12_5_7_XOR_bf_a_B_ETC___d88,
	       exp_c_39_BIT_5_42_XOR_exp_c_39_BIT_4_43_AND_ex_ETC___d293,
	       temp_prod_04_BIT_5_45_XOR_temp_A_06_BIT_5_46_4_ETC___d216;
  wire [4 : 0] temp_prod_04_BIT_11_21_XOR_temp_prod_04_BIT_10_ETC___d347,
	       temp_prod_04_BIT_12_17_XOR_temp_prod_04_BIT_11_ETC___d328;
  wire [3 : 0] bf_a_BIT_10_2_XOR_bf_b_0_BIT_10_3_5_XOR_bf_a_B_ETC___d87,
	       exp_c_39_BIT_3_44_XOR_exp_c_39_BIT_2_45_AND_ex_ETC___d292,
	       temp_prod_04_BIT_3_53_XOR_temp_A_06_BIT_3_54_5_ETC___d215;
  wire [1 : 0] temp_prod_04_BIT_1_61_XOR_temp_A_06_BIT_1_62_6_ETC___d214;
  wire exp_c_39_BIT_7_40_XOR_exp_c_39_BIT_6_41_AND_ex_ETC___d254,
       got_A_AND_got_B_AND_sign_calculated_3_AND_expo_ETC___d227,
       temp_prod_04_BIT_10_25_XOR_temp_prod_04_BIT_9__ETC___d319,
       temp_prod_04_BIT_10_25_XOR_temp_prod_04_BIT_9__ETC___d337,
       temp_prod_04_BIT_11_21_XOR_temp_prod_04_BIT_10_ETC___d318,
       temp_prod_04_BIT_11_21_XOR_temp_prod_04_BIT_10_ETC___d336,
       temp_prod_04_BIT_12_17_XOR_temp_prod_04_BIT_11_ETC___d317,
       temp_prod_04_BIT_12_17_XOR_temp_prod_04_BIT_11_ETC___d335,
       temp_prod_04_BIT_13_13_XOR_temp_prod_04_BIT_12_ETC___d316,
       temp_prod_04_BIT_13_13_XOR_temp_prod_04_BIT_12_ETC___d334,
       temp_prod_04_BIT_14_09_XOR_temp_prod_04_BIT_13_ETC___d315,
       temp_prod_04_BIT_15_05_AND_temp_prod_04_BIT_14_ETC___d274,
       temp_prod_04_BIT_15_05_XOR_temp_prod_04_BIT_14_ETC___d309,
       temp_prod_04_BIT_8_33_XOR_temp_prod_04_BIT_7_37___d339,
       temp_prod_04_BIT_9_29_XOR_temp_prod_04_BIT_8_33___d320,
       temp_prod_04_BIT_9_29_XOR_temp_prod_04_BIT_8_3_ETC___d338,
       x__h13576,
       x__h1364,
       x__h13702,
       x__h13888,
       x__h14074,
       x__h14260,
       x__h14446,
       x__h1491,
       x__h1548,
       x__h1677,
       x__h1734,
       x__h1863,
       x__h1920,
       x__h2049,
       x__h2106,
       x__h2235,
       x__h2292,
       x__h2421,
       x__h2478,
       x__h2651,
       x__h2777,
       x__h2963,
       x__h3149,
       x__h3335,
       x__h3521,
       x__h3707,
       x__h4691,
       x__h4738,
       x__h4883,
       x__h4930,
       x__h5075,
       x__h5122,
       x__h5267,
       x__h5314,
       x__h5459,
       x__h5506,
       x__h5651,
       x__h5698,
       x__h5843,
       x__h5890,
       x__h6035,
       x__h6082,
       x__h6227,
       x__h6274,
       x__h6419,
       x__h6466,
       x__h6611,
       x__h6658,
       x__h6803,
       x__h6850,
       x__h6995,
       x__h7042,
       x__h7128,
       x__h7187,
       x__h7234,
       y__h10425,
       y__h10611,
       y__h10797,
       y__h10983,
       y__h11169,
       y__h11355,
       y__h11541,
       y__h1365,
       y__h13703,
       y__h13889,
       y__h14075,
       y__h14261,
       y__h14447,
       y__h14633,
       y__h1492,
       y__h15210,
       y__h15399,
       y__h1549,
       y__h15588,
       y__h15777,
       y__h15966,
       y__h16155,
       y__h1678,
       y__h1735,
       y__h1864,
       y__h1921,
       y__h2050,
       y__h2107,
       y__h2236,
       y__h2293,
       y__h2422,
       y__h2479,
       y__h2778,
       y__h2964,
       y__h3150,
       y__h3336,
       y__h3522,
       y__h3708,
       y__h4633,
       y__h4692,
       y__h4739,
       y__h4825,
       y__h4884,
       y__h5017,
       y__h5076,
       y__h5209,
       y__h5268,
       y__h5401,
       y__h5460,
       y__h5593,
       y__h5652,
       y__h5785,
       y__h5844,
       y__h5977,
       y__h6036,
       y__h6169,
       y__h6228,
       y__h6361,
       y__h6420,
       y__h6553,
       y__h6612,
       y__h6745,
       y__h6804,
       y__h6937,
       y__h6996,
       y__h7129,
       y__h7188,
       y__h8490,
       y__h8676,
       y__h8862,
       y__h9048,
       y__h9234,
       y__h9420;

  // action method get_A
  assign RDY_get_A = !got_A ;
  assign CAN_FIRE_get_A = !got_A ;
  assign WILL_FIRE_get_A = EN_get_A ;

  // action method get_B
  assign RDY_get_B = !got_B ;
  assign CAN_FIRE_get_B = !got_B ;
  assign WILL_FIRE_get_B = EN_get_B ;

  // value method out_AB
  assign out_AB = bf_c ;
  assign RDY_out_AB = assembled_answer ;

  // rule RL_deassert_assembled_answer
  assign CAN_FIRE_RL_deassert_assembled_answer = assembled_answer ;
  assign WILL_FIRE_RL_deassert_assembled_answer = assembled_answer ;

  // rule RL_calculate_sign
  assign CAN_FIRE_RL_calculate_sign = got_A && got_B && !sign_calculated ;
  assign WILL_FIRE_RL_calculate_sign = CAN_FIRE_RL_calculate_sign ;

  // rule RL_calculate_expone
  assign CAN_FIRE_RL_calculate_expone =
	     got_A && got_B && sign_calculated && !expone_calculated ;
  assign WILL_FIRE_RL_calculate_expone = CAN_FIRE_RL_calculate_expone ;

  // rule RL_rl_multiply
  assign CAN_FIRE_RL_rl_multiply =
	     got_A && got_B && count != 5'd0 && sign_calculated &&
	     expone_calculated &&
	     calculate_mantissa ;
  assign WILL_FIRE_RL_rl_multiply = CAN_FIRE_RL_rl_multiply ;

  // rule RL_round_nearest
  assign CAN_FIRE_RL_round_nearest =
	     got_A_AND_got_B_AND_sign_calculated_3_AND_expo_ETC___d227 &&
	     calculate_mantissa &&
	     count == 5'd0 &&
	     !rounding_done ;
  assign WILL_FIRE_RL_round_nearest = CAN_FIRE_RL_round_nearest ;

  // rule RL_assemble_answer
  assign CAN_FIRE_RL_assemble_answer = MUX_count_write_1__SEL_1 ;
  assign WILL_FIRE_RL_assemble_answer = MUX_count_write_1__SEL_1 ;

  // inputs to muxes for submodule ports
  assign MUX_count_write_1__SEL_1 =
	     got_A_AND_got_B_AND_sign_calculated_3_AND_expo_ETC___d227 &&
	     calculate_mantissa &&
	     rounding_done &&
	     !assembled_answer ;
  assign MUX_count_write_1__VAL_2 = count - 5'd1 ;
  assign MUX_temp_A_write_1__VAL_1 = { 9'd1, bf_a[6:0] } ;
  assign MUX_temp_A_write_1__VAL_2 = { temp_A[14:0], 1'd0 } ;
  assign MUX_temp_B_write_1__VAL_1 = { 9'd1, bf_b[6:0] } ;
  assign MUX_temp_B_write_1__VAL_2 = { 1'd0, temp_B[15:1] } ;
  assign MUX_temp_prod_write_1__VAL_2 =
	     { x__h7128 ^ y__h7129,
	       x__h7234 ^ y__h6937,
	       temp_prod_04_BIT_13_13_XOR_temp_A_06_BIT_13_14_ETC___d220 } ;

  // register assembled_answer
  assign assembled_answer_D_IN = !assembled_answer ;
  assign assembled_answer_EN =
	     assembled_answer || WILL_FIRE_RL_assemble_answer ;

  // register bf_a
  assign bf_a_D_IN = get_A_a ;
  assign bf_a_EN = EN_get_A ;

  // register bf_b
  assign bf_b_D_IN = get_B_b ;
  assign bf_b_EN = EN_get_B ;

  // register bf_c
  assign bf_c_D_IN = { sign_c, man_c_and_final_exp } ;
  assign bf_c_EN = MUX_count_write_1__SEL_1 ;

  // register calculate_mantissa
  assign calculate_mantissa_D_IN = !WILL_FIRE_RL_assemble_answer ;
  assign calculate_mantissa_EN =
	     WILL_FIRE_RL_assemble_answer || WILL_FIRE_RL_calculate_expone ;

  // register count
  assign count_D_IN =
	     WILL_FIRE_RL_assemble_answer ? 5'd8 : MUX_count_write_1__VAL_2 ;
  assign count_EN = WILL_FIRE_RL_rl_multiply || WILL_FIRE_RL_assemble_answer ;

  // register exp_c
  assign exp_c_D_IN =
	     { x__h3707 ^ y__h3708,
	       x__h3521 ^ y__h3522,
	       bf_a_BIT_12_4_XOR_bf_b_0_BIT_12_5_7_XOR_bf_a_B_ETC___d88 } ;
  assign exp_c_EN = CAN_FIRE_RL_calculate_expone ;

  // register expone_calculated
  assign expone_calculated_D_IN = !WILL_FIRE_RL_assemble_answer ;
  assign expone_calculated_EN =
	     WILL_FIRE_RL_assemble_answer || WILL_FIRE_RL_calculate_expone ;

  // register final_output
  assign final_output_D_IN = 16'h0 ;
  assign final_output_EN = 1'b0 ;

  // register got_A
  assign got_A_D_IN = !WILL_FIRE_RL_assemble_answer ;
  assign got_A_EN = WILL_FIRE_RL_assemble_answer || EN_get_A ;

  // register got_B
  assign got_B_D_IN = !WILL_FIRE_RL_assemble_answer ;
  assign got_B_EN = WILL_FIRE_RL_assemble_answer || EN_get_B ;

  // register man_c
  assign man_c_D_IN = 7'h0 ;
  assign man_c_EN = 1'b0 ;

  // register man_c_and_final_exp
  assign man_c_and_final_exp_D_IN =
	     { x__h11792,
	       IF_temp_prod_04_BIT_15_05_THEN_IF_NOT_temp_pro_ETC___d351[6:1],
	       IF_IF_temp_prod_04_BIT_15_05_THEN_IF_NOT_temp__ETC__q8[0] } ;
  assign man_c_and_final_exp_EN = CAN_FIRE_RL_round_nearest ;

  // register rounding_done
  assign rounding_done_D_IN = !WILL_FIRE_RL_assemble_answer ;
  assign rounding_done_EN =
	     WILL_FIRE_RL_assemble_answer || WILL_FIRE_RL_round_nearest ;

  // register sign_c
  assign sign_c_D_IN = bf_a[15] ^ bf_b[15] ;
  assign sign_c_EN = CAN_FIRE_RL_calculate_sign ;

  // register sign_calculated
  assign sign_calculated_D_IN = !WILL_FIRE_RL_assemble_answer ;
  assign sign_calculated_EN =
	     WILL_FIRE_RL_assemble_answer || WILL_FIRE_RL_calculate_sign ;

  // register temp_A
  assign temp_A_D_IN =
	     WILL_FIRE_RL_calculate_expone ?
	       MUX_temp_A_write_1__VAL_1 :
	       MUX_temp_A_write_1__VAL_2 ;
  assign temp_A_EN =
	     WILL_FIRE_RL_calculate_expone || WILL_FIRE_RL_rl_multiply ;

  // register temp_B
  assign temp_B_D_IN =
	     WILL_FIRE_RL_calculate_expone ?
	       MUX_temp_B_write_1__VAL_1 :
	       MUX_temp_B_write_1__VAL_2 ;
  assign temp_B_EN =
	     WILL_FIRE_RL_calculate_expone || WILL_FIRE_RL_rl_multiply ;

  // register temp_prod
  assign temp_prod_D_IN =
	     WILL_FIRE_RL_assemble_answer ?
	       16'd0 :
	       MUX_temp_prod_write_1__VAL_2 ;
  assign temp_prod_EN =
	     WILL_FIRE_RL_rl_multiply && temp_B[0] ||
	     WILL_FIRE_RL_assemble_answer ;

  // remaining internal signals
  assign IF_IF_temp_prod_04_BIT_15_05_THEN_IF_NOT_temp__ETC__q8 =
	     IF_temp_prod_04_BIT_15_05_THEN_IF_NOT_temp_pro_ETC___d351[0] ?
	       15'd1 :
	       15'd0 ;
  assign IF_INV_IF_INV_exp_c_BIT_0_THEN_1_ELSE_0_BIT_0__ETC__q3 =
	     (~IF_INV_exp_c_BIT_0_THEN_1_ELSE_0__q2[0]) ? 8'd1 : 8'd0 ;
  assign IF_INV_IF_bf_a_BIT_7_XOR_bf_b_BIT_7_THEN_1_ELS_ETC__q4 =
	     (~IF_bf_a_BIT_7_XOR_bf_b_BIT_7_THEN_1_ELSE_0__q1[0]) ?
	       8'd1 :
	       8'd0 ;
  assign IF_INV_exp_c_BIT_0_THEN_1_ELSE_0__q2 = (~exp_c[0]) ? 8'd1 : 8'd0 ;
  assign IF_INV_temp_prod_BIT_7_THEN_1_ELSE_0__q7 =
	     (~temp_prod[7]) ? 9'd1 : 9'd0 ;
  assign IF_INV_temp_prod_BIT_8_THEN_1_ELSE_0__q6 =
	     (~temp_prod[8]) ? 9'd1 : 9'd0 ;
  assign IF_NOT_temp_prod_04_BIT_6_41_97_OR_temp_prod_0_ETC___d350 =
	     (!temp_prod[6] || temp_prod[5:0] == 6'd0 && !temp_prod[7]) ?
	       temp_prod[13:7] :
	       (temp_prod_04_BIT_15_05_XOR_temp_prod_04_BIT_14_ETC___d309 ?
		  x__h11723 :
		  x__h11746) ;
  assign IF_NOT_temp_prod_04_BIT_7_37_33_OR_temp_prod_0_ETC___d331 =
	     (!temp_prod[7] || temp_prod[6:0] == 7'd0 && !temp_prod[8]) ?
	       temp_prod[14:8] :
	       (temp_prod_04_BIT_15_05_AND_temp_prod_04_BIT_14_ETC___d274 ?
		  x__h9788 :
		  x__h9811) ;
  assign IF_bf_a_BIT_7_XOR_bf_b_BIT_7_THEN_1_ELSE_0__q1 =
	     (bf_a[7] ^ bf_b[7]) ? 8'd1 : 8'd0 ;
  assign IF_temp_prod_04_BIT_15_05_THEN_IF_NOT_temp_pro_ETC___d351 =
	     temp_prod[15] ?
	       IF_NOT_temp_prod_04_BIT_7_37_33_OR_temp_prod_0_ETC___d331 :
	       IF_NOT_temp_prod_04_BIT_6_41_97_OR_temp_prod_0_ETC___d350 ;
  assign IF_temp_prod_BIT_0_XOR_temp_A_BIT_0_THEN_1_ELSE_0__q5 =
	     (temp_prod[0] ^ temp_A[0]) ? 16'd1 : 16'd0 ;
  assign _theResult___snd__h11720 =
	     { exp_c_39_BIT_7_40_XOR_exp_c_39_BIT_6_41_AND_ex_ETC___d254,
	       x__h14446,
	       x__h14260,
	       x__h14074,
	       x__h13888,
	       x__h13702,
	       x__h13576,
	       IF_INV_exp_c_BIT_0_THEN_1_ELSE_0__q2[0] } ;
  assign _theResult___snd_fst__h11795 =
	     (!temp_prod[7] || temp_prod[6:0] == 7'd0 && !temp_prod[8]) ?
	       _theResult___snd__h11720 :
	       (temp_prod_04_BIT_15_05_AND_temp_prod_04_BIT_14_ETC___d274 ?
		  exp_c_39_BIT_7_40_XOR_exp_c_39_BIT_6_41_AND_ex_ETC___d294 :
		  _theResult___snd__h11720) ;
  assign _theResult___snd_fst__h14811 =
	     (!temp_prod[6] || temp_prod[5:0] == 6'd0 && !temp_prod[7]) ?
	       exp_c :
	       _theResult___snd_fst__h14819 ;
  assign _theResult___snd_fst__h14819 =
	     temp_prod_04_BIT_15_05_XOR_temp_prod_04_BIT_14_ETC___d309 ?
	       _theResult___snd__h11720 :
	       exp_c ;
  assign bf_a_BIT_10_2_XOR_bf_b_0_BIT_10_3_5_XOR_bf_a_B_ETC___d87 =
	     { x__h2963 ^ y__h2964,
	       x__h2777 ^ y__h2778,
	       x__h2651 ^ IF_bf_a_BIT_7_XOR_bf_b_BIT_7_THEN_1_ELSE_0__q1[0],
	       IF_INV_IF_bf_a_BIT_7_XOR_bf_b_BIT_7_THEN_1_ELS_ETC__q4[0] } ;
  assign bf_a_BIT_12_4_XOR_bf_b_0_BIT_12_5_7_XOR_bf_a_B_ETC___d88 =
	     { x__h3335 ^ y__h3336,
	       x__h3149 ^ y__h3150,
	       bf_a_BIT_10_2_XOR_bf_b_0_BIT_10_3_5_XOR_bf_a_B_ETC___d87 } ;
  assign exp_c_39_BIT_3_44_XOR_exp_c_39_BIT_2_45_AND_ex_ETC___d292 =
	     { x__h13888 ^ y__h13889,
	       x__h13702 ^ y__h13703,
	       x__h13576 ^ IF_INV_exp_c_BIT_0_THEN_1_ELSE_0__q2[0],
	       IF_INV_IF_INV_exp_c_BIT_0_THEN_1_ELSE_0_BIT_0__ETC__q3[0] } ;
  assign exp_c_39_BIT_5_42_XOR_exp_c_39_BIT_4_43_AND_ex_ETC___d293 =
	     { x__h14260 ^ y__h14261,
	       x__h14074 ^ y__h14075,
	       exp_c_39_BIT_3_44_XOR_exp_c_39_BIT_2_45_AND_ex_ETC___d292 } ;
  assign exp_c_39_BIT_7_40_XOR_exp_c_39_BIT_6_41_AND_ex_ETC___d254 =
	     exp_c[7] ^ y__h16155 ;
  assign exp_c_39_BIT_7_40_XOR_exp_c_39_BIT_6_41_AND_ex_ETC___d294 =
	     { exp_c_39_BIT_7_40_XOR_exp_c_39_BIT_6_41_AND_ex_ETC___d254 ^
	       y__h14633,
	       x__h14446 ^ y__h14447,
	       exp_c_39_BIT_5_42_XOR_exp_c_39_BIT_4_43_AND_ex_ETC___d293 } ;
  assign got_A_AND_got_B_AND_sign_calculated_3_AND_expo_ETC___d227 =
	     got_A && got_B && sign_calculated && expone_calculated ;
  assign temp_prod_04_BIT_10_25_XOR_temp_prod_04_BIT_9__ETC___d319 =
	     temp_prod[10] ^ y__h8490 ;
  assign temp_prod_04_BIT_10_25_XOR_temp_prod_04_BIT_9__ETC___d337 =
	     temp_prod[10] ^ y__h10611 ;
  assign temp_prod_04_BIT_11_21_XOR_temp_A_06_BIT_11_22_ETC___d219 =
	     { x__h6658 ^ y__h6361,
	       x__h6466 ^ y__h6169,
	       temp_prod_04_BIT_9_29_XOR_temp_A_06_BIT_9_30_3_ETC___d218 } ;
  assign temp_prod_04_BIT_11_21_XOR_temp_prod_04_BIT_10_ETC___d318 =
	     temp_prod[11] ^ y__h8676 ;
  assign temp_prod_04_BIT_11_21_XOR_temp_prod_04_BIT_10_ETC___d336 =
	     temp_prod[11] ^ y__h10797 ;
  assign temp_prod_04_BIT_11_21_XOR_temp_prod_04_BIT_10_ETC___d347 =
	     { temp_prod_04_BIT_11_21_XOR_temp_prod_04_BIT_10_ETC___d336,
	       temp_prod_04_BIT_10_25_XOR_temp_prod_04_BIT_9__ETC___d337,
	       temp_prod_04_BIT_9_29_XOR_temp_prod_04_BIT_8_3_ETC___d338,
	       temp_prod_04_BIT_8_33_XOR_temp_prod_04_BIT_7_37___d339,
	       IF_INV_temp_prod_BIT_7_THEN_1_ELSE_0__q7[0] } ;
  assign temp_prod_04_BIT_12_17_XOR_temp_prod_04_BIT_11_ETC___d317 =
	     temp_prod[12] ^ y__h8862 ;
  assign temp_prod_04_BIT_12_17_XOR_temp_prod_04_BIT_11_ETC___d328 =
	     { temp_prod_04_BIT_12_17_XOR_temp_prod_04_BIT_11_ETC___d317,
	       temp_prod_04_BIT_11_21_XOR_temp_prod_04_BIT_10_ETC___d318,
	       temp_prod_04_BIT_10_25_XOR_temp_prod_04_BIT_9__ETC___d319,
	       temp_prod_04_BIT_9_29_XOR_temp_prod_04_BIT_8_33___d320,
	       IF_INV_temp_prod_BIT_8_THEN_1_ELSE_0__q6[0] } ;
  assign temp_prod_04_BIT_12_17_XOR_temp_prod_04_BIT_11_ETC___d335 =
	     temp_prod[12] ^ y__h10983 ;
  assign temp_prod_04_BIT_13_13_XOR_temp_A_06_BIT_13_14_ETC___d220 =
	     { x__h7042 ^ y__h6745,
	       x__h6850 ^ y__h6553,
	       temp_prod_04_BIT_11_21_XOR_temp_A_06_BIT_11_22_ETC___d219 } ;
  assign temp_prod_04_BIT_13_13_XOR_temp_prod_04_BIT_12_ETC___d316 =
	     temp_prod[13] ^ y__h9048 ;
  assign temp_prod_04_BIT_13_13_XOR_temp_prod_04_BIT_12_ETC___d334 =
	     temp_prod[13] ^ y__h11169 ;
  assign temp_prod_04_BIT_14_09_XOR_temp_prod_04_BIT_13_ETC___d315 =
	     temp_prod[14] ^ y__h9234 ;
  assign temp_prod_04_BIT_15_05_AND_temp_prod_04_BIT_14_ETC___d274 =
	     temp_prod[15] & y__h9420 ;
  assign temp_prod_04_BIT_15_05_XOR_temp_prod_04_BIT_14_ETC___d309 =
	     temp_prod[15] ^ y__h11541 ;
  assign temp_prod_04_BIT_1_61_XOR_temp_A_06_BIT_1_62_6_ETC___d214 =
	     { x__h4738 ^ y__h4739,
	       IF_temp_prod_BIT_0_XOR_temp_A_BIT_0_THEN_1_ELSE_0__q5[0] } ;
  assign temp_prod_04_BIT_3_53_XOR_temp_A_06_BIT_3_54_5_ETC___d215 =
	     { x__h5122 ^ y__h4825,
	       x__h4930 ^ y__h4633,
	       temp_prod_04_BIT_1_61_XOR_temp_A_06_BIT_1_62_6_ETC___d214 } ;
  assign temp_prod_04_BIT_5_45_XOR_temp_A_06_BIT_5_46_4_ETC___d216 =
	     { x__h5506 ^ y__h5209,
	       x__h5314 ^ y__h5017,
	       temp_prod_04_BIT_3_53_XOR_temp_A_06_BIT_3_54_5_ETC___d215 } ;
  assign temp_prod_04_BIT_7_37_XOR_temp_A_06_BIT_7_38_4_ETC___d217 =
	     { x__h5890 ^ y__h5593,
	       x__h5698 ^ y__h5401,
	       temp_prod_04_BIT_5_45_XOR_temp_A_06_BIT_5_46_4_ETC___d216 } ;
  assign temp_prod_04_BIT_8_33_XOR_temp_prod_04_BIT_7_37___d339 =
	     temp_prod[8] ^ temp_prod[7] ;
  assign temp_prod_04_BIT_9_29_XOR_temp_A_06_BIT_9_30_3_ETC___d218 =
	     { x__h6274 ^ y__h5977,
	       x__h6082 ^ y__h5785,
	       temp_prod_04_BIT_7_37_XOR_temp_A_06_BIT_7_38_4_ETC___d217 } ;
  assign temp_prod_04_BIT_9_29_XOR_temp_prod_04_BIT_8_33___d320 =
	     temp_prod[9] ^ temp_prod[8] ;
  assign temp_prod_04_BIT_9_29_XOR_temp_prod_04_BIT_8_3_ETC___d338 =
	     temp_prod[9] ^ y__h10425 ;
  assign x__h11723 =
	     { temp_prod[14] ^ y__h11355,
	       temp_prod_04_BIT_13_13_XOR_temp_prod_04_BIT_12_ETC___d334,
	       temp_prod_04_BIT_12_17_XOR_temp_prod_04_BIT_11_ETC___d335,
	       temp_prod_04_BIT_11_21_XOR_temp_prod_04_BIT_10_ETC___d336,
	       temp_prod_04_BIT_10_25_XOR_temp_prod_04_BIT_9__ETC___d337,
	       temp_prod_04_BIT_9_29_XOR_temp_prod_04_BIT_8_3_ETC___d338,
	       temp_prod_04_BIT_8_33_XOR_temp_prod_04_BIT_7_37___d339 } ;
  assign x__h11746 =
	     { temp_prod_04_BIT_13_13_XOR_temp_prod_04_BIT_12_ETC___d334,
	       temp_prod_04_BIT_12_17_XOR_temp_prod_04_BIT_11_ETC___d335,
	       temp_prod_04_BIT_11_21_XOR_temp_prod_04_BIT_10_ETC___d347 } ;
  assign x__h11792 =
	     temp_prod[15] ?
	       _theResult___snd_fst__h11795 :
	       _theResult___snd_fst__h14811 ;
  assign x__h13576 = exp_c[1] ^ exp_c[0] ;
  assign x__h1364 = bf_a[8] ^ bf_b[8] ;
  assign x__h13702 = exp_c[2] ^ y__h15210 ;
  assign x__h13888 = exp_c[3] ^ y__h15399 ;
  assign x__h14074 = exp_c[4] ^ y__h15588 ;
  assign x__h14260 = exp_c[5] ^ y__h15777 ;
  assign x__h14446 = exp_c[6] ^ y__h15966 ;
  assign x__h1491 = bf_a[9] ^ bf_b[9] ;
  assign x__h1548 = bf_a[8] & bf_b[8] ;
  assign x__h1677 = bf_a[10] ^ bf_b[10] ;
  assign x__h1734 = bf_a[9] & bf_b[9] ;
  assign x__h1863 = bf_a[11] ^ bf_b[11] ;
  assign x__h1920 = bf_a[10] & bf_b[10] ;
  assign x__h2049 = bf_a[12] ^ bf_b[12] ;
  assign x__h2106 = bf_a[11] & bf_b[11] ;
  assign x__h2235 = bf_a[13] ^ bf_b[13] ;
  assign x__h2292 = bf_a[12] & bf_b[12] ;
  assign x__h2421 = bf_a[14] ^ bf_b[14] ;
  assign x__h2478 = bf_a[13] & bf_b[13] ;
  assign x__h2651 = x__h1364 ^ y__h1365 ;
  assign x__h2777 = x__h1491 ^ y__h1492 ;
  assign x__h2963 = x__h1677 ^ y__h1678 ;
  assign x__h3149 = x__h1863 ^ y__h1864 ;
  assign x__h3335 = x__h2049 ^ y__h2050 ;
  assign x__h3521 = x__h2235 ^ y__h2236 ;
  assign x__h3707 = ~(x__h2421 ^ y__h2422) ;
  assign x__h4691 = temp_prod[1] & temp_A[1] ;
  assign x__h4738 = temp_prod[1] ^ temp_A[1] ;
  assign x__h4883 = temp_prod[2] & temp_A[2] ;
  assign x__h4930 = temp_prod[2] ^ temp_A[2] ;
  assign x__h5075 = temp_prod[3] & temp_A[3] ;
  assign x__h5122 = temp_prod[3] ^ temp_A[3] ;
  assign x__h5267 = temp_prod[4] & temp_A[4] ;
  assign x__h5314 = temp_prod[4] ^ temp_A[4] ;
  assign x__h5459 = temp_prod[5] & temp_A[5] ;
  assign x__h5506 = temp_prod[5] ^ temp_A[5] ;
  assign x__h5651 = temp_prod[6] & temp_A[6] ;
  assign x__h5698 = temp_prod[6] ^ temp_A[6] ;
  assign x__h5843 = temp_prod[7] & temp_A[7] ;
  assign x__h5890 = temp_prod[7] ^ temp_A[7] ;
  assign x__h6035 = temp_prod[8] & temp_A[8] ;
  assign x__h6082 = temp_prod[8] ^ temp_A[8] ;
  assign x__h6227 = temp_prod[9] & temp_A[9] ;
  assign x__h6274 = temp_prod[9] ^ temp_A[9] ;
  assign x__h6419 = temp_prod[10] & temp_A[10] ;
  assign x__h6466 = temp_prod[10] ^ temp_A[10] ;
  assign x__h6611 = temp_prod[11] & temp_A[11] ;
  assign x__h6658 = temp_prod[11] ^ temp_A[11] ;
  assign x__h6803 = temp_prod[12] & temp_A[12] ;
  assign x__h6850 = temp_prod[12] ^ temp_A[12] ;
  assign x__h6995 = temp_prod[13] & temp_A[13] ;
  assign x__h7042 = temp_prod[13] ^ temp_A[13] ;
  assign x__h7128 = temp_prod[15] ^ temp_A[15] ;
  assign x__h7187 = temp_prod[14] & temp_A[14] ;
  assign x__h7234 = temp_prod[14] ^ temp_A[14] ;
  assign x__h9788 =
	     { temp_prod[15] ^ y__h9420,
	       temp_prod_04_BIT_14_09_XOR_temp_prod_04_BIT_13_ETC___d315,
	       temp_prod_04_BIT_13_13_XOR_temp_prod_04_BIT_12_ETC___d316,
	       temp_prod_04_BIT_12_17_XOR_temp_prod_04_BIT_11_ETC___d317,
	       temp_prod_04_BIT_11_21_XOR_temp_prod_04_BIT_10_ETC___d318,
	       temp_prod_04_BIT_10_25_XOR_temp_prod_04_BIT_9__ETC___d319,
	       temp_prod_04_BIT_9_29_XOR_temp_prod_04_BIT_8_33___d320 } ;
  assign x__h9811 =
	     { temp_prod_04_BIT_14_09_XOR_temp_prod_04_BIT_13_ETC___d315,
	       temp_prod_04_BIT_13_13_XOR_temp_prod_04_BIT_12_ETC___d316,
	       temp_prod_04_BIT_12_17_XOR_temp_prod_04_BIT_11_ETC___d328 } ;
  assign y__h10425 = temp_prod[8] & temp_prod[7] ;
  assign y__h10611 = temp_prod[9] & y__h10425 ;
  assign y__h10797 = temp_prod[10] & y__h10611 ;
  assign y__h10983 = temp_prod[11] & y__h10797 ;
  assign y__h11169 = temp_prod[12] & y__h10983 ;
  assign y__h11355 = temp_prod[13] & y__h11169 ;
  assign y__h11541 = temp_prod[14] & y__h11355 ;
  assign y__h1365 = bf_a[7] & bf_b[7] ;
  assign y__h13703 = x__h13576 & IF_INV_exp_c_BIT_0_THEN_1_ELSE_0__q2[0] ;
  assign y__h13889 = x__h13702 & y__h13703 ;
  assign y__h14075 = x__h13888 & y__h13889 ;
  assign y__h14261 = x__h14074 & y__h14075 ;
  assign y__h14447 = x__h14260 & y__h14261 ;
  assign y__h14633 = x__h14446 & y__h14447 ;
  assign y__h1492 = x__h1548 | y__h1549 ;
  assign y__h15210 = exp_c[1] & exp_c[0] ;
  assign y__h15399 = exp_c[2] & y__h15210 ;
  assign y__h1549 = x__h1364 & y__h1365 ;
  assign y__h15588 = exp_c[3] & y__h15399 ;
  assign y__h15777 = exp_c[4] & y__h15588 ;
  assign y__h15966 = exp_c[5] & y__h15777 ;
  assign y__h16155 = exp_c[6] & y__h15966 ;
  assign y__h1678 = x__h1734 | y__h1735 ;
  assign y__h1735 = x__h1491 & y__h1492 ;
  assign y__h1864 = x__h1920 | y__h1921 ;
  assign y__h1921 = x__h1677 & y__h1678 ;
  assign y__h2050 = x__h2106 | y__h2107 ;
  assign y__h2107 = x__h1863 & y__h1864 ;
  assign y__h2236 = x__h2292 | y__h2293 ;
  assign y__h2293 = x__h2049 & y__h2050 ;
  assign y__h2422 = x__h2478 | y__h2479 ;
  assign y__h2479 = x__h2235 & y__h2236 ;
  assign y__h2778 =
	     x__h2651 & IF_bf_a_BIT_7_XOR_bf_b_BIT_7_THEN_1_ELSE_0__q1[0] ;
  assign y__h2964 = x__h2777 & y__h2778 ;
  assign y__h3150 = x__h2963 & y__h2964 ;
  assign y__h3336 = x__h3149 & y__h3150 ;
  assign y__h3522 = x__h3335 & y__h3336 ;
  assign y__h3708 = x__h3521 & y__h3522 ;
  assign y__h4633 = x__h4691 | y__h4692 ;
  assign y__h4692 = x__h4738 & y__h4739 ;
  assign y__h4739 = temp_prod[0] & temp_A[0] ;
  assign y__h4825 = x__h4883 | y__h4884 ;
  assign y__h4884 = x__h4930 & y__h4633 ;
  assign y__h5017 = x__h5075 | y__h5076 ;
  assign y__h5076 = x__h5122 & y__h4825 ;
  assign y__h5209 = x__h5267 | y__h5268 ;
  assign y__h5268 = x__h5314 & y__h5017 ;
  assign y__h5401 = x__h5459 | y__h5460 ;
  assign y__h5460 = x__h5506 & y__h5209 ;
  assign y__h5593 = x__h5651 | y__h5652 ;
  assign y__h5652 = x__h5698 & y__h5401 ;
  assign y__h5785 = x__h5843 | y__h5844 ;
  assign y__h5844 = x__h5890 & y__h5593 ;
  assign y__h5977 = x__h6035 | y__h6036 ;
  assign y__h6036 = x__h6082 & y__h5785 ;
  assign y__h6169 = x__h6227 | y__h6228 ;
  assign y__h6228 = x__h6274 & y__h5977 ;
  assign y__h6361 = x__h6419 | y__h6420 ;
  assign y__h6420 = x__h6466 & y__h6169 ;
  assign y__h6553 = x__h6611 | y__h6612 ;
  assign y__h6612 = x__h6658 & y__h6361 ;
  assign y__h6745 = x__h6803 | y__h6804 ;
  assign y__h6804 = x__h6850 & y__h6553 ;
  assign y__h6937 = x__h6995 | y__h6996 ;
  assign y__h6996 = x__h7042 & y__h6745 ;
  assign y__h7129 = x__h7187 | y__h7188 ;
  assign y__h7188 = x__h7234 & y__h6937 ;
  assign y__h8490 = temp_prod[9] & temp_prod[8] ;
  assign y__h8676 = temp_prod[10] & y__h8490 ;
  assign y__h8862 = temp_prod[11] & y__h8676 ;
  assign y__h9048 = temp_prod[12] & y__h8862 ;
  assign y__h9234 = temp_prod[13] & y__h9048 ;
  assign y__h9420 = temp_prod[14] & y__h9234 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        assembled_answer <= `BSV_ASSIGNMENT_DELAY 1'd0;
	bf_a <= `BSV_ASSIGNMENT_DELAY 16'd0;
	bf_b <= `BSV_ASSIGNMENT_DELAY 16'd0;
	bf_c <= `BSV_ASSIGNMENT_DELAY 16'd0;
	calculate_mantissa <= `BSV_ASSIGNMENT_DELAY 1'd0;
	count <= `BSV_ASSIGNMENT_DELAY 5'd8;
	exp_c <= `BSV_ASSIGNMENT_DELAY 8'd0;
	expone_calculated <= `BSV_ASSIGNMENT_DELAY 1'd0;
	final_output <= `BSV_ASSIGNMENT_DELAY 16'd0;
	got_A <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_B <= `BSV_ASSIGNMENT_DELAY 1'd0;
	man_c <= `BSV_ASSIGNMENT_DELAY 7'd0;
	man_c_and_final_exp <= `BSV_ASSIGNMENT_DELAY 15'd0;
	rounding_done <= `BSV_ASSIGNMENT_DELAY 1'd0;
	sign_c <= `BSV_ASSIGNMENT_DELAY 1'd0;
	sign_calculated <= `BSV_ASSIGNMENT_DELAY 1'd0;
	temp_A <= `BSV_ASSIGNMENT_DELAY 16'd0;
	temp_B <= `BSV_ASSIGNMENT_DELAY 16'd0;
	temp_prod <= `BSV_ASSIGNMENT_DELAY 16'd0;
      end
    else
      begin
        if (assembled_answer_EN)
	  assembled_answer <= `BSV_ASSIGNMENT_DELAY assembled_answer_D_IN;
	if (bf_a_EN) bf_a <= `BSV_ASSIGNMENT_DELAY bf_a_D_IN;
	if (bf_b_EN) bf_b <= `BSV_ASSIGNMENT_DELAY bf_b_D_IN;
	if (bf_c_EN) bf_c <= `BSV_ASSIGNMENT_DELAY bf_c_D_IN;
	if (calculate_mantissa_EN)
	  calculate_mantissa <= `BSV_ASSIGNMENT_DELAY calculate_mantissa_D_IN;
	if (count_EN) count <= `BSV_ASSIGNMENT_DELAY count_D_IN;
	if (exp_c_EN) exp_c <= `BSV_ASSIGNMENT_DELAY exp_c_D_IN;
	if (expone_calculated_EN)
	  expone_calculated <= `BSV_ASSIGNMENT_DELAY expone_calculated_D_IN;
	if (final_output_EN)
	  final_output <= `BSV_ASSIGNMENT_DELAY final_output_D_IN;
	if (got_A_EN) got_A <= `BSV_ASSIGNMENT_DELAY got_A_D_IN;
	if (got_B_EN) got_B <= `BSV_ASSIGNMENT_DELAY got_B_D_IN;
	if (man_c_EN) man_c <= `BSV_ASSIGNMENT_DELAY man_c_D_IN;
	if (man_c_and_final_exp_EN)
	  man_c_and_final_exp <= `BSV_ASSIGNMENT_DELAY
	      man_c_and_final_exp_D_IN;
	if (rounding_done_EN)
	  rounding_done <= `BSV_ASSIGNMENT_DELAY rounding_done_D_IN;
	if (sign_c_EN) sign_c <= `BSV_ASSIGNMENT_DELAY sign_c_D_IN;
	if (sign_calculated_EN)
	  sign_calculated <= `BSV_ASSIGNMENT_DELAY sign_calculated_D_IN;
	if (temp_A_EN) temp_A <= `BSV_ASSIGNMENT_DELAY temp_A_D_IN;
	if (temp_B_EN) temp_B <= `BSV_ASSIGNMENT_DELAY temp_B_D_IN;
	if (temp_prod_EN) temp_prod <= `BSV_ASSIGNMENT_DELAY temp_prod_D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    assembled_answer = 1'h0;
    bf_a = 16'hAAAA;
    bf_b = 16'hAAAA;
    bf_c = 16'hAAAA;
    calculate_mantissa = 1'h0;
    count = 5'h0A;
    exp_c = 8'hAA;
    expone_calculated = 1'h0;
    final_output = 16'hAAAA;
    got_A = 1'h0;
    got_B = 1'h0;
    man_c = 7'h2A;
    man_c_and_final_exp = 15'h2AAA;
    rounding_done = 1'h0;
    sign_c = 1'h0;
    sign_calculated = 1'h0;
    temp_A = 16'hAAAA;
    temp_B = 16'hAAAA;
    temp_prod = 16'hAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkbf16_mul

