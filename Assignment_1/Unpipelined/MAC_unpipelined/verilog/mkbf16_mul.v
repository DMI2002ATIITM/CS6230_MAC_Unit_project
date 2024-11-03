//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Sun Oct 27 18:49:30 IST 2024
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

  // register handle_zero
  reg handle_zero;
  wire handle_zero_D_IN, handle_zero_EN;

  // register handled_zero
  reg handled_zero;
  wire handled_zero_D_IN, handled_zero_EN;

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
       CAN_FIRE_RL_handle_case_zero,
       CAN_FIRE_RL_rl_multiply,
       CAN_FIRE_RL_round_nearest,
       CAN_FIRE_get_A,
       CAN_FIRE_get_B,
       WILL_FIRE_RL_assemble_answer,
       WILL_FIRE_RL_calculate_expone,
       WILL_FIRE_RL_calculate_sign,
       WILL_FIRE_RL_deassert_assembled_answer,
       WILL_FIRE_RL_handle_case_zero,
       WILL_FIRE_RL_rl_multiply,
       WILL_FIRE_RL_round_nearest,
       WILL_FIRE_get_A,
       WILL_FIRE_get_B;

  // inputs to muxes for submodule ports
  wire [15 : 0] MUX_bf_c_write_1__VAL_1,
		MUX_temp_A_write_1__VAL_1,
		MUX_temp_A_write_1__VAL_2,
		MUX_temp_B_write_1__VAL_1,
		MUX_temp_B_write_1__VAL_2,
		MUX_temp_prod_write_1__VAL_2;
  wire [4 : 0] MUX_count_write_1__VAL_2;
  wire MUX_assembled_answer_write_1__SEL_2,
       MUX_count_write_1__SEL_1,
       MUX_sign_calculated_write_1__SEL_2;

  // remaining internal signals
  wire [15 : 0] IF_temp_prod_BIT_0_XOR_temp_A_BIT_0_THEN_1_ELSE_0__q7;
  wire [14 : 0] IF_IF_temp_prod_28_BIT_15_29_THEN_IF_NOT_temp__ETC__q8;
  wire [13 : 0] temp_prod_28_BIT_13_37_XOR_temp_A_30_BIT_13_38_ETC___d244;
  wire [11 : 0] temp_prod_28_BIT_11_45_XOR_temp_A_30_BIT_11_46_ETC___d243;
  wire [9 : 0] temp_prod_28_BIT_9_53_XOR_temp_A_30_BIT_9_54_5_ETC___d242;
  wire [8 : 0] IF_INV_temp_prod_BIT_7_THEN_1_ELSE_0__q4,
	       IF_INV_temp_prod_BIT_8_THEN_1_ELSE_0__q3;
  wire [7 : 0] IF_INV_IF_INV_exp_c_BIT_0_THEN_1_ELSE_0_BIT_0__ETC__q5,
	       IF_INV_IF_bf_a_BIT_7_XOR_bf_b_BIT_7_THEN_1_ELS_ETC__q6,
	       IF_INV_exp_c_BIT_0_THEN_1_ELSE_0__q2,
	       IF_bf_a_BIT_7_XOR_bf_b_BIT_7_THEN_1_ELSE_0__q1,
	       _theResult___snd__h11927,
	       _theResult___snd_fst__h12002,
	       _theResult___snd_fst__h15018,
	       _theResult___snd_fst__h15026,
	       exp_c_64_BIT_7_65_XOR_exp_c_64_BIT_6_66_AND_ex_ETC___d319,
	       temp_prod_28_BIT_7_61_XOR_temp_A_30_BIT_7_62_6_ETC___d241,
	       x__h11999;
  wire [6 : 0] IF_NOT_temp_prod_28_BIT_6_65_22_OR_temp_prod_2_ETC___d375,
	       IF_NOT_temp_prod_28_BIT_7_61_58_OR_temp_prod_2_ETC___d356,
	       IF_temp_prod_28_BIT_15_29_THEN_IF_NOT_temp_pro_ETC___d376,
	       x__h10018,
	       x__h11930,
	       x__h11953,
	       x__h9995;
  wire [5 : 0] bf_a_0_BIT_12_9_XOR_bf_b_6_BIT_12_0_2_XOR_bf_a_ETC___d113,
	       exp_c_64_BIT_5_67_XOR_exp_c_64_BIT_4_68_AND_ex_ETC___d318,
	       temp_prod_28_BIT_5_69_XOR_temp_A_30_BIT_5_70_7_ETC___d240;
  wire [4 : 0] temp_prod_28_BIT_11_45_XOR_temp_prod_28_BIT_10_ETC___d372,
	       temp_prod_28_BIT_12_41_XOR_temp_prod_28_BIT_11_ETC___d353;
  wire [3 : 0] bf_a_0_BIT_10_7_XOR_bf_b_6_BIT_10_8_0_XOR_bf_a_ETC___d112,
	       exp_c_64_BIT_3_69_XOR_exp_c_64_BIT_2_70_AND_ex_ETC___d317,
	       temp_prod_28_BIT_3_77_XOR_temp_A_30_BIT_3_78_8_ETC___d239;
  wire [1 : 0] temp_prod_28_BIT_1_85_XOR_temp_A_30_BIT_1_86_8_ETC___d238;
  wire exp_c_64_BIT_7_65_XOR_exp_c_64_BIT_6_66_AND_ex_ETC___d279,
       got_A_AND_got_B_AND_sign_calculated_7_AND_expo_ETC___d251,
       temp_prod_28_BIT_10_49_XOR_temp_prod_28_BIT_9__ETC___d344,
       temp_prod_28_BIT_10_49_XOR_temp_prod_28_BIT_9__ETC___d362,
       temp_prod_28_BIT_11_45_XOR_temp_prod_28_BIT_10_ETC___d343,
       temp_prod_28_BIT_11_45_XOR_temp_prod_28_BIT_10_ETC___d361,
       temp_prod_28_BIT_12_41_XOR_temp_prod_28_BIT_11_ETC___d342,
       temp_prod_28_BIT_12_41_XOR_temp_prod_28_BIT_11_ETC___d360,
       temp_prod_28_BIT_13_37_XOR_temp_prod_28_BIT_12_ETC___d341,
       temp_prod_28_BIT_13_37_XOR_temp_prod_28_BIT_12_ETC___d359,
       temp_prod_28_BIT_14_33_XOR_temp_prod_28_BIT_13_ETC___d340,
       temp_prod_28_BIT_15_29_AND_temp_prod_28_BIT_14_ETC___d299,
       temp_prod_28_BIT_15_29_XOR_temp_prod_28_BIT_14_ETC___d334,
       temp_prod_28_BIT_8_57_XOR_temp_prod_28_BIT_7_61___d364,
       temp_prod_28_BIT_9_53_XOR_temp_prod_28_BIT_8_57___d345,
       temp_prod_28_BIT_9_53_XOR_temp_prod_28_BIT_8_5_ETC___d363,
       x__h13783,
       x__h13909,
       x__h14095,
       x__h14281,
       x__h14467,
       x__h14653,
       x__h1557,
       x__h1684,
       x__h1741,
       x__h1870,
       x__h1927,
       x__h2056,
       x__h2113,
       x__h2242,
       x__h2299,
       x__h2428,
       x__h2485,
       x__h2614,
       x__h2671,
       x__h2844,
       x__h2970,
       x__h3156,
       x__h3342,
       x__h3528,
       x__h3714,
       x__h3900,
       x__h4891,
       x__h4938,
       x__h5083,
       x__h5130,
       x__h5275,
       x__h5322,
       x__h5467,
       x__h5514,
       x__h5659,
       x__h5706,
       x__h5851,
       x__h5898,
       x__h6043,
       x__h6090,
       x__h6235,
       x__h6282,
       x__h6427,
       x__h6474,
       x__h6619,
       x__h6666,
       x__h6811,
       x__h6858,
       x__h7003,
       x__h7050,
       x__h7195,
       x__h7242,
       x__h7328,
       x__h7387,
       x__h7434,
       y__h10632,
       y__h10818,
       y__h11004,
       y__h11190,
       y__h11376,
       y__h11562,
       y__h11748,
       y__h13910,
       y__h14096,
       y__h14282,
       y__h14468,
       y__h14654,
       y__h14840,
       y__h15417,
       y__h1558,
       y__h15606,
       y__h15795,
       y__h15984,
       y__h16173,
       y__h16362,
       y__h1685,
       y__h1742,
       y__h1871,
       y__h1928,
       y__h2057,
       y__h2114,
       y__h2243,
       y__h2300,
       y__h2429,
       y__h2486,
       y__h2615,
       y__h2672,
       y__h2971,
       y__h3157,
       y__h3343,
       y__h3529,
       y__h3715,
       y__h3901,
       y__h4833,
       y__h4892,
       y__h4939,
       y__h5025,
       y__h5084,
       y__h5217,
       y__h5276,
       y__h5409,
       y__h5468,
       y__h5601,
       y__h5660,
       y__h5793,
       y__h5852,
       y__h5985,
       y__h6044,
       y__h6177,
       y__h6236,
       y__h6369,
       y__h6428,
       y__h6561,
       y__h6620,
       y__h6753,
       y__h6812,
       y__h6945,
       y__h7004,
       y__h7137,
       y__h7196,
       y__h7329,
       y__h7388,
       y__h8697,
       y__h8883,
       y__h9069,
       y__h9255,
       y__h9441,
       y__h9627;

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

  // rule RL_calculate_sign
  assign CAN_FIRE_RL_calculate_sign =
	     got_A && got_B && !sign_calculated && !handle_zero ;
  assign WILL_FIRE_RL_calculate_sign = CAN_FIRE_RL_calculate_sign ;

  // rule RL_handle_case_zero
  assign CAN_FIRE_RL_handle_case_zero =
	     got_A && got_B && handle_zero && !handled_zero ;
  assign WILL_FIRE_RL_handle_case_zero = CAN_FIRE_RL_handle_case_zero ;

  // rule RL_calculate_expone
  assign CAN_FIRE_RL_calculate_expone =
	     got_A && got_B && sign_calculated && !expone_calculated &&
	     !handle_zero ;
  assign WILL_FIRE_RL_calculate_expone = CAN_FIRE_RL_calculate_expone ;

  // rule RL_rl_multiply
  assign CAN_FIRE_RL_rl_multiply =
	     got_A && got_B && count != 5'd0 && sign_calculated &&
	     expone_calculated &&
	     calculate_mantissa &&
	     !handle_zero ;
  assign WILL_FIRE_RL_rl_multiply = CAN_FIRE_RL_rl_multiply ;

  // rule RL_round_nearest
  assign CAN_FIRE_RL_round_nearest =
	     got_A_AND_got_B_AND_sign_calculated_7_AND_expo_ETC___d251 &&
	     calculate_mantissa &&
	     count == 5'd0 &&
	     !rounding_done &&
	     !handle_zero ;
  assign WILL_FIRE_RL_round_nearest = CAN_FIRE_RL_round_nearest ;

  // rule RL_assemble_answer
  assign CAN_FIRE_RL_assemble_answer =
	     got_A_AND_got_B_AND_sign_calculated_7_AND_expo_ETC___d251 &&
	     calculate_mantissa &&
	     rounding_done &&
	     !assembled_answer &&
	     !handle_zero ;
  assign WILL_FIRE_RL_assemble_answer = CAN_FIRE_RL_assemble_answer ;

  // rule RL_deassert_assembled_answer
  assign CAN_FIRE_RL_deassert_assembled_answer = assembled_answer ;
  assign WILL_FIRE_RL_deassert_assembled_answer = MUX_count_write_1__SEL_1 ;

  // inputs to muxes for submodule ports
  assign MUX_assembled_answer_write_1__SEL_2 =
	     WILL_FIRE_RL_assemble_answer || WILL_FIRE_RL_handle_case_zero ;
  assign MUX_count_write_1__SEL_1 =
	     assembled_answer && !WILL_FIRE_RL_handle_case_zero ;
  assign MUX_sign_calculated_write_1__SEL_2 =
	     WILL_FIRE_RL_calculate_sign &&
	     (bf_a[14:7] != 8'd0 || bf_a[6:0] != 7'd0) &&
	     (bf_b[14:7] != 8'd0 || bf_b[6:0] != 7'd0) ;
  assign MUX_bf_c_write_1__VAL_1 = { sign_c, man_c_and_final_exp } ;
  assign MUX_count_write_1__VAL_2 = count - 5'd1 ;
  assign MUX_temp_A_write_1__VAL_1 = { 9'd1, bf_a[6:0] } ;
  assign MUX_temp_A_write_1__VAL_2 = { temp_A[14:0], 1'd0 } ;
  assign MUX_temp_B_write_1__VAL_1 = { 9'd1, bf_b[6:0] } ;
  assign MUX_temp_B_write_1__VAL_2 = { 1'd0, temp_B[15:1] } ;
  assign MUX_temp_prod_write_1__VAL_2 =
	     { x__h7328 ^ y__h7329,
	       x__h7434 ^ y__h7137,
	       temp_prod_28_BIT_13_37_XOR_temp_A_30_BIT_13_38_ETC___d244 } ;

  // register assembled_answer
  assign assembled_answer_D_IN = !WILL_FIRE_RL_deassert_assembled_answer ;
  assign assembled_answer_EN =
	     WILL_FIRE_RL_deassert_assembled_answer ||
	     WILL_FIRE_RL_assemble_answer ||
	     WILL_FIRE_RL_handle_case_zero ;

  // register bf_a
  assign bf_a_D_IN = get_A_a ;
  assign bf_a_EN = EN_get_A ;

  // register bf_b
  assign bf_b_D_IN = get_B_b ;
  assign bf_b_EN = EN_get_B ;

  // register bf_c
  assign bf_c_D_IN =
	     WILL_FIRE_RL_assemble_answer ? MUX_bf_c_write_1__VAL_1 : 16'd0 ;
  assign bf_c_EN = MUX_assembled_answer_write_1__SEL_2 ;

  // register calculate_mantissa
  assign calculate_mantissa_D_IN = !WILL_FIRE_RL_deassert_assembled_answer ;
  assign calculate_mantissa_EN =
	     WILL_FIRE_RL_deassert_assembled_answer ||
	     WILL_FIRE_RL_calculate_expone ;

  // register count
  assign count_D_IN =
	     WILL_FIRE_RL_deassert_assembled_answer ?
	       5'd8 :
	       MUX_count_write_1__VAL_2 ;
  assign count_EN =
	     WILL_FIRE_RL_rl_multiply ||
	     WILL_FIRE_RL_deassert_assembled_answer ;

  // register exp_c
  assign exp_c_D_IN =
	     { x__h3900 ^ y__h3901,
	       x__h3714 ^ y__h3715,
	       bf_a_0_BIT_12_9_XOR_bf_b_6_BIT_12_0_2_XOR_bf_a_ETC___d113 } ;
  assign exp_c_EN = CAN_FIRE_RL_calculate_expone ;

  // register expone_calculated
  assign expone_calculated_D_IN = !WILL_FIRE_RL_deassert_assembled_answer ;
  assign expone_calculated_EN =
	     WILL_FIRE_RL_deassert_assembled_answer ||
	     WILL_FIRE_RL_calculate_expone ;

  // register final_output
  assign final_output_D_IN = 16'h0 ;
  assign final_output_EN = 1'b0 ;

  // register got_A
  assign got_A_D_IN = !WILL_FIRE_RL_deassert_assembled_answer ;
  assign got_A_EN = WILL_FIRE_RL_deassert_assembled_answer || EN_get_A ;

  // register got_B
  assign got_B_D_IN = !WILL_FIRE_RL_deassert_assembled_answer ;
  assign got_B_EN = WILL_FIRE_RL_deassert_assembled_answer || EN_get_B ;

  // register handle_zero
  assign handle_zero_D_IN = !WILL_FIRE_RL_deassert_assembled_answer ;
  assign handle_zero_EN =
	     WILL_FIRE_RL_calculate_sign &&
	     (bf_a[14:7] == 8'd0 && bf_a[6:0] == 7'd0 ||
	      bf_b[14:7] == 8'd0 && bf_b[6:0] == 7'd0) ||
	     WILL_FIRE_RL_deassert_assembled_answer ;

  // register handled_zero
  assign handled_zero_D_IN = !WILL_FIRE_RL_deassert_assembled_answer ;
  assign handled_zero_EN =
	     WILL_FIRE_RL_deassert_assembled_answer ||
	     WILL_FIRE_RL_handle_case_zero ;

  // register man_c
  assign man_c_D_IN = 7'h0 ;
  assign man_c_EN = 1'b0 ;

  // register man_c_and_final_exp
  assign man_c_and_final_exp_D_IN =
	     { x__h11999,
	       IF_temp_prod_28_BIT_15_29_THEN_IF_NOT_temp_pro_ETC___d376[6:1],
	       IF_IF_temp_prod_28_BIT_15_29_THEN_IF_NOT_temp__ETC__q8[0] } ;
  assign man_c_and_final_exp_EN = CAN_FIRE_RL_round_nearest ;

  // register rounding_done
  assign rounding_done_D_IN = !WILL_FIRE_RL_deassert_assembled_answer ;
  assign rounding_done_EN =
	     WILL_FIRE_RL_deassert_assembled_answer ||
	     WILL_FIRE_RL_round_nearest ;

  // register sign_c
  assign sign_c_D_IN = bf_a[15] ^ bf_b[15] ;
  assign sign_c_EN = MUX_sign_calculated_write_1__SEL_2 ;

  // register sign_calculated
  assign sign_calculated_D_IN = !WILL_FIRE_RL_deassert_assembled_answer ;
  assign sign_calculated_EN =
	     WILL_FIRE_RL_calculate_sign &&
	     (bf_a[14:7] != 8'd0 || bf_a[6:0] != 7'd0) &&
	     (bf_b[14:7] != 8'd0 || bf_b[6:0] != 7'd0) ||
	     WILL_FIRE_RL_deassert_assembled_answer ;

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
	     WILL_FIRE_RL_deassert_assembled_answer ?
	       16'd0 :
	       MUX_temp_prod_write_1__VAL_2 ;
  assign temp_prod_EN =
	     WILL_FIRE_RL_rl_multiply && temp_B[0] ||
	     WILL_FIRE_RL_deassert_assembled_answer ;

  // remaining internal signals
  assign IF_IF_temp_prod_28_BIT_15_29_THEN_IF_NOT_temp__ETC__q8 =
	     IF_temp_prod_28_BIT_15_29_THEN_IF_NOT_temp_pro_ETC___d376[0] ?
	       15'd1 :
	       15'd0 ;
  assign IF_INV_IF_INV_exp_c_BIT_0_THEN_1_ELSE_0_BIT_0__ETC__q5 =
	     (~IF_INV_exp_c_BIT_0_THEN_1_ELSE_0__q2[0]) ? 8'd1 : 8'd0 ;
  assign IF_INV_IF_bf_a_BIT_7_XOR_bf_b_BIT_7_THEN_1_ELS_ETC__q6 =
	     (~IF_bf_a_BIT_7_XOR_bf_b_BIT_7_THEN_1_ELSE_0__q1[0]) ?
	       8'd1 :
	       8'd0 ;
  assign IF_INV_exp_c_BIT_0_THEN_1_ELSE_0__q2 = (~exp_c[0]) ? 8'd1 : 8'd0 ;
  assign IF_INV_temp_prod_BIT_7_THEN_1_ELSE_0__q4 =
	     (~temp_prod[7]) ? 9'd1 : 9'd0 ;
  assign IF_INV_temp_prod_BIT_8_THEN_1_ELSE_0__q3 =
	     (~temp_prod[8]) ? 9'd1 : 9'd0 ;
  assign IF_NOT_temp_prod_28_BIT_6_65_22_OR_temp_prod_2_ETC___d375 =
	     (!temp_prod[6] || temp_prod[5:0] == 6'd0 && !temp_prod[7]) ?
	       temp_prod[13:7] :
	       (temp_prod_28_BIT_15_29_XOR_temp_prod_28_BIT_14_ETC___d334 ?
		  x__h11930 :
		  x__h11953) ;
  assign IF_NOT_temp_prod_28_BIT_7_61_58_OR_temp_prod_2_ETC___d356 =
	     (!temp_prod[7] || temp_prod[6:0] == 7'd0 && !temp_prod[8]) ?
	       temp_prod[14:8] :
	       (temp_prod_28_BIT_15_29_AND_temp_prod_28_BIT_14_ETC___d299 ?
		  x__h9995 :
		  x__h10018) ;
  assign IF_bf_a_BIT_7_XOR_bf_b_BIT_7_THEN_1_ELSE_0__q1 =
	     (bf_a[7] ^ bf_b[7]) ? 8'd1 : 8'd0 ;
  assign IF_temp_prod_28_BIT_15_29_THEN_IF_NOT_temp_pro_ETC___d376 =
	     temp_prod[15] ?
	       IF_NOT_temp_prod_28_BIT_7_61_58_OR_temp_prod_2_ETC___d356 :
	       IF_NOT_temp_prod_28_BIT_6_65_22_OR_temp_prod_2_ETC___d375 ;
  assign IF_temp_prod_BIT_0_XOR_temp_A_BIT_0_THEN_1_ELSE_0__q7 =
	     (temp_prod[0] ^ temp_A[0]) ? 16'd1 : 16'd0 ;
  assign _theResult___snd__h11927 =
	     { exp_c_64_BIT_7_65_XOR_exp_c_64_BIT_6_66_AND_ex_ETC___d279,
	       x__h14653,
	       x__h14467,
	       x__h14281,
	       x__h14095,
	       x__h13909,
	       x__h13783,
	       IF_INV_exp_c_BIT_0_THEN_1_ELSE_0__q2[0] } ;
  assign _theResult___snd_fst__h12002 =
	     (!temp_prod[7] || temp_prod[6:0] == 7'd0 && !temp_prod[8]) ?
	       _theResult___snd__h11927 :
	       (temp_prod_28_BIT_15_29_AND_temp_prod_28_BIT_14_ETC___d299 ?
		  exp_c_64_BIT_7_65_XOR_exp_c_64_BIT_6_66_AND_ex_ETC___d319 :
		  _theResult___snd__h11927) ;
  assign _theResult___snd_fst__h15018 =
	     (!temp_prod[6] || temp_prod[5:0] == 6'd0 && !temp_prod[7]) ?
	       exp_c :
	       _theResult___snd_fst__h15026 ;
  assign _theResult___snd_fst__h15026 =
	     temp_prod_28_BIT_15_29_XOR_temp_prod_28_BIT_14_ETC___d334 ?
	       _theResult___snd__h11927 :
	       exp_c ;
  assign bf_a_0_BIT_10_7_XOR_bf_b_6_BIT_10_8_0_XOR_bf_a_ETC___d112 =
	     { x__h3156 ^ y__h3157,
	       x__h2970 ^ y__h2971,
	       x__h2844 ^ IF_bf_a_BIT_7_XOR_bf_b_BIT_7_THEN_1_ELSE_0__q1[0],
	       IF_INV_IF_bf_a_BIT_7_XOR_bf_b_BIT_7_THEN_1_ELS_ETC__q6[0] } ;
  assign bf_a_0_BIT_12_9_XOR_bf_b_6_BIT_12_0_2_XOR_bf_a_ETC___d113 =
	     { x__h3528 ^ y__h3529,
	       x__h3342 ^ y__h3343,
	       bf_a_0_BIT_10_7_XOR_bf_b_6_BIT_10_8_0_XOR_bf_a_ETC___d112 } ;
  assign exp_c_64_BIT_3_69_XOR_exp_c_64_BIT_2_70_AND_ex_ETC___d317 =
	     { x__h14095 ^ y__h14096,
	       x__h13909 ^ y__h13910,
	       x__h13783 ^ IF_INV_exp_c_BIT_0_THEN_1_ELSE_0__q2[0],
	       IF_INV_IF_INV_exp_c_BIT_0_THEN_1_ELSE_0_BIT_0__ETC__q5[0] } ;
  assign exp_c_64_BIT_5_67_XOR_exp_c_64_BIT_4_68_AND_ex_ETC___d318 =
	     { x__h14467 ^ y__h14468,
	       x__h14281 ^ y__h14282,
	       exp_c_64_BIT_3_69_XOR_exp_c_64_BIT_2_70_AND_ex_ETC___d317 } ;
  assign exp_c_64_BIT_7_65_XOR_exp_c_64_BIT_6_66_AND_ex_ETC___d279 =
	     exp_c[7] ^ y__h16362 ;
  assign exp_c_64_BIT_7_65_XOR_exp_c_64_BIT_6_66_AND_ex_ETC___d319 =
	     { exp_c_64_BIT_7_65_XOR_exp_c_64_BIT_6_66_AND_ex_ETC___d279 ^
	       y__h14840,
	       x__h14653 ^ y__h14654,
	       exp_c_64_BIT_5_67_XOR_exp_c_64_BIT_4_68_AND_ex_ETC___d318 } ;
  assign got_A_AND_got_B_AND_sign_calculated_7_AND_expo_ETC___d251 =
	     got_A && got_B && sign_calculated && expone_calculated ;
  assign temp_prod_28_BIT_10_49_XOR_temp_prod_28_BIT_9__ETC___d344 =
	     temp_prod[10] ^ y__h8697 ;
  assign temp_prod_28_BIT_10_49_XOR_temp_prod_28_BIT_9__ETC___d362 =
	     temp_prod[10] ^ y__h10818 ;
  assign temp_prod_28_BIT_11_45_XOR_temp_A_30_BIT_11_46_ETC___d243 =
	     { x__h6858 ^ y__h6561,
	       x__h6666 ^ y__h6369,
	       temp_prod_28_BIT_9_53_XOR_temp_A_30_BIT_9_54_5_ETC___d242 } ;
  assign temp_prod_28_BIT_11_45_XOR_temp_prod_28_BIT_10_ETC___d343 =
	     temp_prod[11] ^ y__h8883 ;
  assign temp_prod_28_BIT_11_45_XOR_temp_prod_28_BIT_10_ETC___d361 =
	     temp_prod[11] ^ y__h11004 ;
  assign temp_prod_28_BIT_11_45_XOR_temp_prod_28_BIT_10_ETC___d372 =
	     { temp_prod_28_BIT_11_45_XOR_temp_prod_28_BIT_10_ETC___d361,
	       temp_prod_28_BIT_10_49_XOR_temp_prod_28_BIT_9__ETC___d362,
	       temp_prod_28_BIT_9_53_XOR_temp_prod_28_BIT_8_5_ETC___d363,
	       temp_prod_28_BIT_8_57_XOR_temp_prod_28_BIT_7_61___d364,
	       IF_INV_temp_prod_BIT_7_THEN_1_ELSE_0__q4[0] } ;
  assign temp_prod_28_BIT_12_41_XOR_temp_prod_28_BIT_11_ETC___d342 =
	     temp_prod[12] ^ y__h9069 ;
  assign temp_prod_28_BIT_12_41_XOR_temp_prod_28_BIT_11_ETC___d353 =
	     { temp_prod_28_BIT_12_41_XOR_temp_prod_28_BIT_11_ETC___d342,
	       temp_prod_28_BIT_11_45_XOR_temp_prod_28_BIT_10_ETC___d343,
	       temp_prod_28_BIT_10_49_XOR_temp_prod_28_BIT_9__ETC___d344,
	       temp_prod_28_BIT_9_53_XOR_temp_prod_28_BIT_8_57___d345,
	       IF_INV_temp_prod_BIT_8_THEN_1_ELSE_0__q3[0] } ;
  assign temp_prod_28_BIT_12_41_XOR_temp_prod_28_BIT_11_ETC___d360 =
	     temp_prod[12] ^ y__h11190 ;
  assign temp_prod_28_BIT_13_37_XOR_temp_A_30_BIT_13_38_ETC___d244 =
	     { x__h7242 ^ y__h6945,
	       x__h7050 ^ y__h6753,
	       temp_prod_28_BIT_11_45_XOR_temp_A_30_BIT_11_46_ETC___d243 } ;
  assign temp_prod_28_BIT_13_37_XOR_temp_prod_28_BIT_12_ETC___d341 =
	     temp_prod[13] ^ y__h9255 ;
  assign temp_prod_28_BIT_13_37_XOR_temp_prod_28_BIT_12_ETC___d359 =
	     temp_prod[13] ^ y__h11376 ;
  assign temp_prod_28_BIT_14_33_XOR_temp_prod_28_BIT_13_ETC___d340 =
	     temp_prod[14] ^ y__h9441 ;
  assign temp_prod_28_BIT_15_29_AND_temp_prod_28_BIT_14_ETC___d299 =
	     temp_prod[15] & y__h9627 ;
  assign temp_prod_28_BIT_15_29_XOR_temp_prod_28_BIT_14_ETC___d334 =
	     temp_prod[15] ^ y__h11748 ;
  assign temp_prod_28_BIT_1_85_XOR_temp_A_30_BIT_1_86_8_ETC___d238 =
	     { x__h4938 ^ y__h4939,
	       IF_temp_prod_BIT_0_XOR_temp_A_BIT_0_THEN_1_ELSE_0__q7[0] } ;
  assign temp_prod_28_BIT_3_77_XOR_temp_A_30_BIT_3_78_8_ETC___d239 =
	     { x__h5322 ^ y__h5025,
	       x__h5130 ^ y__h4833,
	       temp_prod_28_BIT_1_85_XOR_temp_A_30_BIT_1_86_8_ETC___d238 } ;
  assign temp_prod_28_BIT_5_69_XOR_temp_A_30_BIT_5_70_7_ETC___d240 =
	     { x__h5706 ^ y__h5409,
	       x__h5514 ^ y__h5217,
	       temp_prod_28_BIT_3_77_XOR_temp_A_30_BIT_3_78_8_ETC___d239 } ;
  assign temp_prod_28_BIT_7_61_XOR_temp_A_30_BIT_7_62_6_ETC___d241 =
	     { x__h6090 ^ y__h5793,
	       x__h5898 ^ y__h5601,
	       temp_prod_28_BIT_5_69_XOR_temp_A_30_BIT_5_70_7_ETC___d240 } ;
  assign temp_prod_28_BIT_8_57_XOR_temp_prod_28_BIT_7_61___d364 =
	     temp_prod[8] ^ temp_prod[7] ;
  assign temp_prod_28_BIT_9_53_XOR_temp_A_30_BIT_9_54_5_ETC___d242 =
	     { x__h6474 ^ y__h6177,
	       x__h6282 ^ y__h5985,
	       temp_prod_28_BIT_7_61_XOR_temp_A_30_BIT_7_62_6_ETC___d241 } ;
  assign temp_prod_28_BIT_9_53_XOR_temp_prod_28_BIT_8_57___d345 =
	     temp_prod[9] ^ temp_prod[8] ;
  assign temp_prod_28_BIT_9_53_XOR_temp_prod_28_BIT_8_5_ETC___d363 =
	     temp_prod[9] ^ y__h10632 ;
  assign x__h10018 =
	     { temp_prod_28_BIT_14_33_XOR_temp_prod_28_BIT_13_ETC___d340,
	       temp_prod_28_BIT_13_37_XOR_temp_prod_28_BIT_12_ETC___d341,
	       temp_prod_28_BIT_12_41_XOR_temp_prod_28_BIT_11_ETC___d353 } ;
  assign x__h11930 =
	     { temp_prod[14] ^ y__h11562,
	       temp_prod_28_BIT_13_37_XOR_temp_prod_28_BIT_12_ETC___d359,
	       temp_prod_28_BIT_12_41_XOR_temp_prod_28_BIT_11_ETC___d360,
	       temp_prod_28_BIT_11_45_XOR_temp_prod_28_BIT_10_ETC___d361,
	       temp_prod_28_BIT_10_49_XOR_temp_prod_28_BIT_9__ETC___d362,
	       temp_prod_28_BIT_9_53_XOR_temp_prod_28_BIT_8_5_ETC___d363,
	       temp_prod_28_BIT_8_57_XOR_temp_prod_28_BIT_7_61___d364 } ;
  assign x__h11953 =
	     { temp_prod_28_BIT_13_37_XOR_temp_prod_28_BIT_12_ETC___d359,
	       temp_prod_28_BIT_12_41_XOR_temp_prod_28_BIT_11_ETC___d360,
	       temp_prod_28_BIT_11_45_XOR_temp_prod_28_BIT_10_ETC___d372 } ;
  assign x__h11999 =
	     temp_prod[15] ?
	       _theResult___snd_fst__h12002 :
	       _theResult___snd_fst__h15018 ;
  assign x__h13783 = exp_c[1] ^ exp_c[0] ;
  assign x__h13909 = exp_c[2] ^ y__h15417 ;
  assign x__h14095 = exp_c[3] ^ y__h15606 ;
  assign x__h14281 = exp_c[4] ^ y__h15795 ;
  assign x__h14467 = exp_c[5] ^ y__h15984 ;
  assign x__h14653 = exp_c[6] ^ y__h16173 ;
  assign x__h1557 = bf_a[8] ^ bf_b[8] ;
  assign x__h1684 = bf_a[9] ^ bf_b[9] ;
  assign x__h1741 = bf_a[8] & bf_b[8] ;
  assign x__h1870 = bf_a[10] ^ bf_b[10] ;
  assign x__h1927 = bf_a[9] & bf_b[9] ;
  assign x__h2056 = bf_a[11] ^ bf_b[11] ;
  assign x__h2113 = bf_a[10] & bf_b[10] ;
  assign x__h2242 = bf_a[12] ^ bf_b[12] ;
  assign x__h2299 = bf_a[11] & bf_b[11] ;
  assign x__h2428 = bf_a[13] ^ bf_b[13] ;
  assign x__h2485 = bf_a[12] & bf_b[12] ;
  assign x__h2614 = bf_a[14] ^ bf_b[14] ;
  assign x__h2671 = bf_a[13] & bf_b[13] ;
  assign x__h2844 = x__h1557 ^ y__h1558 ;
  assign x__h2970 = x__h1684 ^ y__h1685 ;
  assign x__h3156 = x__h1870 ^ y__h1871 ;
  assign x__h3342 = x__h2056 ^ y__h2057 ;
  assign x__h3528 = x__h2242 ^ y__h2243 ;
  assign x__h3714 = x__h2428 ^ y__h2429 ;
  assign x__h3900 = ~(x__h2614 ^ y__h2615) ;
  assign x__h4891 = temp_prod[1] & temp_A[1] ;
  assign x__h4938 = temp_prod[1] ^ temp_A[1] ;
  assign x__h5083 = temp_prod[2] & temp_A[2] ;
  assign x__h5130 = temp_prod[2] ^ temp_A[2] ;
  assign x__h5275 = temp_prod[3] & temp_A[3] ;
  assign x__h5322 = temp_prod[3] ^ temp_A[3] ;
  assign x__h5467 = temp_prod[4] & temp_A[4] ;
  assign x__h5514 = temp_prod[4] ^ temp_A[4] ;
  assign x__h5659 = temp_prod[5] & temp_A[5] ;
  assign x__h5706 = temp_prod[5] ^ temp_A[5] ;
  assign x__h5851 = temp_prod[6] & temp_A[6] ;
  assign x__h5898 = temp_prod[6] ^ temp_A[6] ;
  assign x__h6043 = temp_prod[7] & temp_A[7] ;
  assign x__h6090 = temp_prod[7] ^ temp_A[7] ;
  assign x__h6235 = temp_prod[8] & temp_A[8] ;
  assign x__h6282 = temp_prod[8] ^ temp_A[8] ;
  assign x__h6427 = temp_prod[9] & temp_A[9] ;
  assign x__h6474 = temp_prod[9] ^ temp_A[9] ;
  assign x__h6619 = temp_prod[10] & temp_A[10] ;
  assign x__h6666 = temp_prod[10] ^ temp_A[10] ;
  assign x__h6811 = temp_prod[11] & temp_A[11] ;
  assign x__h6858 = temp_prod[11] ^ temp_A[11] ;
  assign x__h7003 = temp_prod[12] & temp_A[12] ;
  assign x__h7050 = temp_prod[12] ^ temp_A[12] ;
  assign x__h7195 = temp_prod[13] & temp_A[13] ;
  assign x__h7242 = temp_prod[13] ^ temp_A[13] ;
  assign x__h7328 = temp_prod[15] ^ temp_A[15] ;
  assign x__h7387 = temp_prod[14] & temp_A[14] ;
  assign x__h7434 = temp_prod[14] ^ temp_A[14] ;
  assign x__h9995 =
	     { temp_prod[15] ^ y__h9627,
	       temp_prod_28_BIT_14_33_XOR_temp_prod_28_BIT_13_ETC___d340,
	       temp_prod_28_BIT_13_37_XOR_temp_prod_28_BIT_12_ETC___d341,
	       temp_prod_28_BIT_12_41_XOR_temp_prod_28_BIT_11_ETC___d342,
	       temp_prod_28_BIT_11_45_XOR_temp_prod_28_BIT_10_ETC___d343,
	       temp_prod_28_BIT_10_49_XOR_temp_prod_28_BIT_9__ETC___d344,
	       temp_prod_28_BIT_9_53_XOR_temp_prod_28_BIT_8_57___d345 } ;
  assign y__h10632 = temp_prod[8] & temp_prod[7] ;
  assign y__h10818 = temp_prod[9] & y__h10632 ;
  assign y__h11004 = temp_prod[10] & y__h10818 ;
  assign y__h11190 = temp_prod[11] & y__h11004 ;
  assign y__h11376 = temp_prod[12] & y__h11190 ;
  assign y__h11562 = temp_prod[13] & y__h11376 ;
  assign y__h11748 = temp_prod[14] & y__h11562 ;
  assign y__h13910 = x__h13783 & IF_INV_exp_c_BIT_0_THEN_1_ELSE_0__q2[0] ;
  assign y__h14096 = x__h13909 & y__h13910 ;
  assign y__h14282 = x__h14095 & y__h14096 ;
  assign y__h14468 = x__h14281 & y__h14282 ;
  assign y__h14654 = x__h14467 & y__h14468 ;
  assign y__h14840 = x__h14653 & y__h14654 ;
  assign y__h15417 = exp_c[1] & exp_c[0] ;
  assign y__h1558 = bf_a[7] & bf_b[7] ;
  assign y__h15606 = exp_c[2] & y__h15417 ;
  assign y__h15795 = exp_c[3] & y__h15606 ;
  assign y__h15984 = exp_c[4] & y__h15795 ;
  assign y__h16173 = exp_c[5] & y__h15984 ;
  assign y__h16362 = exp_c[6] & y__h16173 ;
  assign y__h1685 = x__h1741 | y__h1742 ;
  assign y__h1742 = x__h1557 & y__h1558 ;
  assign y__h1871 = x__h1927 | y__h1928 ;
  assign y__h1928 = x__h1684 & y__h1685 ;
  assign y__h2057 = x__h2113 | y__h2114 ;
  assign y__h2114 = x__h1870 & y__h1871 ;
  assign y__h2243 = x__h2299 | y__h2300 ;
  assign y__h2300 = x__h2056 & y__h2057 ;
  assign y__h2429 = x__h2485 | y__h2486 ;
  assign y__h2486 = x__h2242 & y__h2243 ;
  assign y__h2615 = x__h2671 | y__h2672 ;
  assign y__h2672 = x__h2428 & y__h2429 ;
  assign y__h2971 =
	     x__h2844 & IF_bf_a_BIT_7_XOR_bf_b_BIT_7_THEN_1_ELSE_0__q1[0] ;
  assign y__h3157 = x__h2970 & y__h2971 ;
  assign y__h3343 = x__h3156 & y__h3157 ;
  assign y__h3529 = x__h3342 & y__h3343 ;
  assign y__h3715 = x__h3528 & y__h3529 ;
  assign y__h3901 = x__h3714 & y__h3715 ;
  assign y__h4833 = x__h4891 | y__h4892 ;
  assign y__h4892 = x__h4938 & y__h4939 ;
  assign y__h4939 = temp_prod[0] & temp_A[0] ;
  assign y__h5025 = x__h5083 | y__h5084 ;
  assign y__h5084 = x__h5130 & y__h4833 ;
  assign y__h5217 = x__h5275 | y__h5276 ;
  assign y__h5276 = x__h5322 & y__h5025 ;
  assign y__h5409 = x__h5467 | y__h5468 ;
  assign y__h5468 = x__h5514 & y__h5217 ;
  assign y__h5601 = x__h5659 | y__h5660 ;
  assign y__h5660 = x__h5706 & y__h5409 ;
  assign y__h5793 = x__h5851 | y__h5852 ;
  assign y__h5852 = x__h5898 & y__h5601 ;
  assign y__h5985 = x__h6043 | y__h6044 ;
  assign y__h6044 = x__h6090 & y__h5793 ;
  assign y__h6177 = x__h6235 | y__h6236 ;
  assign y__h6236 = x__h6282 & y__h5985 ;
  assign y__h6369 = x__h6427 | y__h6428 ;
  assign y__h6428 = x__h6474 & y__h6177 ;
  assign y__h6561 = x__h6619 | y__h6620 ;
  assign y__h6620 = x__h6666 & y__h6369 ;
  assign y__h6753 = x__h6811 | y__h6812 ;
  assign y__h6812 = x__h6858 & y__h6561 ;
  assign y__h6945 = x__h7003 | y__h7004 ;
  assign y__h7004 = x__h7050 & y__h6753 ;
  assign y__h7137 = x__h7195 | y__h7196 ;
  assign y__h7196 = x__h7242 & y__h6945 ;
  assign y__h7329 = x__h7387 | y__h7388 ;
  assign y__h7388 = x__h7434 & y__h7137 ;
  assign y__h8697 = temp_prod[9] & temp_prod[8] ;
  assign y__h8883 = temp_prod[10] & y__h8697 ;
  assign y__h9069 = temp_prod[11] & y__h8883 ;
  assign y__h9255 = temp_prod[12] & y__h9069 ;
  assign y__h9441 = temp_prod[13] & y__h9255 ;
  assign y__h9627 = temp_prod[14] & y__h9441 ;

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
	handle_zero <= `BSV_ASSIGNMENT_DELAY 1'd0;
	handled_zero <= `BSV_ASSIGNMENT_DELAY 1'd0;
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
	if (handle_zero_EN)
	  handle_zero <= `BSV_ASSIGNMENT_DELAY handle_zero_D_IN;
	if (handled_zero_EN)
	  handled_zero <= `BSV_ASSIGNMENT_DELAY handled_zero_D_IN;
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
    handle_zero = 1'h0;
    handled_zero = 1'h0;
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
