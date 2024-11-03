//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Sat Oct 12 23:10:23 IST 2024
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_A                      O     1 const
// RDY_get_B                      O     1 const
// output_Add                     O    16
// RDY_output_Add                 O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_A_a                        I    16 reg
// get_B_b                        I    16 reg
// EN_get_A                       I     1
// EN_get_B                       I     1
// EN_output_Add                  I     1 unused
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

module mkSigned_16bitAdd(CLK,
			 RST_N,

			 get_A_a,
			 EN_get_A,
			 RDY_get_A,

			 get_B_b,
			 EN_get_B,
			 RDY_get_B,

			 EN_output_Add,
			 output_Add,
			 RDY_output_Add);
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

  // actionvalue method output_Add
  input  EN_output_Add;
  output [15 : 0] output_Add;
  output RDY_output_Add;

  // signals for module outputs
  wire [15 : 0] output_Add;
  wire RDY_get_A, RDY_get_B, RDY_output_Add;

  // register rg_A
  reg [15 : 0] rg_A;
  wire [15 : 0] rg_A_D_IN;
  wire rg_A_EN;

  // register rg_Add
  reg [15 : 0] rg_Add;
  wire [15 : 0] rg_Add_D_IN;
  wire rg_Add_EN;

  // register rg_B
  reg [15 : 0] rg_B;
  wire [15 : 0] rg_B_D_IN;
  wire rg_B_EN;

  // register rg_Carry
  reg [15 : 0] rg_Carry;
  wire [15 : 0] rg_Carry_D_IN;
  wire rg_Carry_EN;

  // rule scheduling signals
  wire CAN_FIRE_get_A,
       CAN_FIRE_get_B,
       CAN_FIRE_output_Add,
       WILL_FIRE_get_A,
       WILL_FIRE_get_B,
       WILL_FIRE_output_Add;

  // remaining internal signals
  wire [15 : 0] IF_rg_A_BIT_0_XOR_rg_B_BIT_0_THEN_1_ELSE_0__q1;
  wire [13 : 0] rg_A_BIT_13_0_XOR_rg_B_BIT_13_1_3_XOR_rg_A_BIT_ETC___d117;
  wire [11 : 0] rg_A_BIT_11_8_XOR_rg_B_BIT_11_9_1_XOR_rg_A_BIT_ETC___d116;
  wire [9 : 0] rg_A_BIT_9_6_XOR_rg_B_BIT_9_7_9_XOR_rg_A_BIT_8_ETC___d115;
  wire [7 : 0] rg_A_BIT_7_4_XOR_rg_B_BIT_7_5_7_XOR_rg_A_BIT_6_ETC___d114;
  wire [5 : 0] rg_A_BIT_5_2_XOR_rg_B_BIT_5_3_5_XOR_rg_A_BIT_4_ETC___d113;
  wire [3 : 0] rg_A_BIT_3_0_XOR_rg_B_BIT_3_1_3_XOR_rg_A_BIT_2_ETC___d112;
  wire [1 : 0] rg_A_BIT_1_8_XOR_rg_B_BIT_1_9_1_XOR_rg_A_BIT_0_ETC___d111;
  wire x__h1041,
       x__h1088,
       x__h1233,
       x__h1280,
       x__h1425,
       x__h1472,
       x__h1617,
       x__h1664,
       x__h1809,
       x__h1856,
       x__h2001,
       x__h2048,
       x__h2193,
       x__h2240,
       x__h2385,
       x__h2432,
       x__h2577,
       x__h2624,
       x__h2769,
       x__h2816,
       x__h2961,
       x__h3008,
       x__h3153,
       x__h3200,
       x__h3286,
       x__h3345,
       x__h3392,
       x__h849,
       x__h896,
       y__h1042,
       y__h1175,
       y__h1234,
       y__h1367,
       y__h1426,
       y__h1559,
       y__h1618,
       y__h1751,
       y__h1810,
       y__h1943,
       y__h2002,
       y__h2135,
       y__h2194,
       y__h2327,
       y__h2386,
       y__h2519,
       y__h2578,
       y__h2711,
       y__h2770,
       y__h2903,
       y__h2962,
       y__h3095,
       y__h3154,
       y__h3287,
       y__h3346,
       y__h791,
       y__h850,
       y__h897,
       y__h983;

  // action method get_A
  assign RDY_get_A = 1'd1 ;
  assign CAN_FIRE_get_A = 1'd1 ;
  assign WILL_FIRE_get_A = EN_get_A ;

  // action method get_B
  assign RDY_get_B = 1'd1 ;
  assign CAN_FIRE_get_B = 1'd1 ;
  assign WILL_FIRE_get_B = EN_get_B ;

  // actionvalue method output_Add
  assign output_Add =
	     { x__h3286 ^ y__h3287,
	       x__h3392 ^ y__h3095,
	       rg_A_BIT_13_0_XOR_rg_B_BIT_13_1_3_XOR_rg_A_BIT_ETC___d117 } ;
  assign RDY_output_Add = 1'd1 ;
  assign CAN_FIRE_output_Add = 1'd1 ;
  assign WILL_FIRE_output_Add = EN_output_Add ;

  // register rg_A
  assign rg_A_D_IN = get_A_a ;
  assign rg_A_EN = EN_get_A ;

  // register rg_Add
  assign rg_Add_D_IN = 16'h0 ;
  assign rg_Add_EN = 1'b0 ;

  // register rg_B
  assign rg_B_D_IN = get_B_b ;
  assign rg_B_EN = EN_get_B ;

  // register rg_Carry
  assign rg_Carry_D_IN = 16'h0 ;
  assign rg_Carry_EN = 1'b0 ;

  // remaining internal signals
  assign IF_rg_A_BIT_0_XOR_rg_B_BIT_0_THEN_1_ELSE_0__q1 =
	     (rg_A[0] ^ rg_B[0]) ? 16'd1 : 16'd0 ;
  assign rg_A_BIT_11_8_XOR_rg_B_BIT_11_9_1_XOR_rg_A_BIT_ETC___d116 =
	     { x__h2816 ^ y__h2519,
	       x__h2624 ^ y__h2327,
	       rg_A_BIT_9_6_XOR_rg_B_BIT_9_7_9_XOR_rg_A_BIT_8_ETC___d115 } ;
  assign rg_A_BIT_13_0_XOR_rg_B_BIT_13_1_3_XOR_rg_A_BIT_ETC___d117 =
	     { x__h3200 ^ y__h2903,
	       x__h3008 ^ y__h2711,
	       rg_A_BIT_11_8_XOR_rg_B_BIT_11_9_1_XOR_rg_A_BIT_ETC___d116 } ;
  assign rg_A_BIT_1_8_XOR_rg_B_BIT_1_9_1_XOR_rg_A_BIT_0_ETC___d111 =
	     { x__h896 ^ y__h897,
	       IF_rg_A_BIT_0_XOR_rg_B_BIT_0_THEN_1_ELSE_0__q1[0] } ;
  assign rg_A_BIT_3_0_XOR_rg_B_BIT_3_1_3_XOR_rg_A_BIT_2_ETC___d112 =
	     { x__h1280 ^ y__h983,
	       x__h1088 ^ y__h791,
	       rg_A_BIT_1_8_XOR_rg_B_BIT_1_9_1_XOR_rg_A_BIT_0_ETC___d111 } ;
  assign rg_A_BIT_5_2_XOR_rg_B_BIT_5_3_5_XOR_rg_A_BIT_4_ETC___d113 =
	     { x__h1664 ^ y__h1367,
	       x__h1472 ^ y__h1175,
	       rg_A_BIT_3_0_XOR_rg_B_BIT_3_1_3_XOR_rg_A_BIT_2_ETC___d112 } ;
  assign rg_A_BIT_7_4_XOR_rg_B_BIT_7_5_7_XOR_rg_A_BIT_6_ETC___d114 =
	     { x__h2048 ^ y__h1751,
	       x__h1856 ^ y__h1559,
	       rg_A_BIT_5_2_XOR_rg_B_BIT_5_3_5_XOR_rg_A_BIT_4_ETC___d113 } ;
  assign rg_A_BIT_9_6_XOR_rg_B_BIT_9_7_9_XOR_rg_A_BIT_8_ETC___d115 =
	     { x__h2432 ^ y__h2135,
	       x__h2240 ^ y__h1943,
	       rg_A_BIT_7_4_XOR_rg_B_BIT_7_5_7_XOR_rg_A_BIT_6_ETC___d114 } ;
  assign x__h1041 = rg_A[2] & rg_B[2] ;
  assign x__h1088 = rg_A[2] ^ rg_B[2] ;
  assign x__h1233 = rg_A[3] & rg_B[3] ;
  assign x__h1280 = rg_A[3] ^ rg_B[3] ;
  assign x__h1425 = rg_A[4] & rg_B[4] ;
  assign x__h1472 = rg_A[4] ^ rg_B[4] ;
  assign x__h1617 = rg_A[5] & rg_B[5] ;
  assign x__h1664 = rg_A[5] ^ rg_B[5] ;
  assign x__h1809 = rg_A[6] & rg_B[6] ;
  assign x__h1856 = rg_A[6] ^ rg_B[6] ;
  assign x__h2001 = rg_A[7] & rg_B[7] ;
  assign x__h2048 = rg_A[7] ^ rg_B[7] ;
  assign x__h2193 = rg_A[8] & rg_B[8] ;
  assign x__h2240 = rg_A[8] ^ rg_B[8] ;
  assign x__h2385 = rg_A[9] & rg_B[9] ;
  assign x__h2432 = rg_A[9] ^ rg_B[9] ;
  assign x__h2577 = rg_A[10] & rg_B[10] ;
  assign x__h2624 = rg_A[10] ^ rg_B[10] ;
  assign x__h2769 = rg_A[11] & rg_B[11] ;
  assign x__h2816 = rg_A[11] ^ rg_B[11] ;
  assign x__h2961 = rg_A[12] & rg_B[12] ;
  assign x__h3008 = rg_A[12] ^ rg_B[12] ;
  assign x__h3153 = rg_A[13] & rg_B[13] ;
  assign x__h3200 = rg_A[13] ^ rg_B[13] ;
  assign x__h3286 = rg_A[15] ^ rg_B[15] ;
  assign x__h3345 = rg_A[14] & rg_B[14] ;
  assign x__h3392 = rg_A[14] ^ rg_B[14] ;
  assign x__h849 = rg_A[1] & rg_B[1] ;
  assign x__h896 = rg_A[1] ^ rg_B[1] ;
  assign y__h1042 = x__h1088 & y__h791 ;
  assign y__h1175 = x__h1233 | y__h1234 ;
  assign y__h1234 = x__h1280 & y__h983 ;
  assign y__h1367 = x__h1425 | y__h1426 ;
  assign y__h1426 = x__h1472 & y__h1175 ;
  assign y__h1559 = x__h1617 | y__h1618 ;
  assign y__h1618 = x__h1664 & y__h1367 ;
  assign y__h1751 = x__h1809 | y__h1810 ;
  assign y__h1810 = x__h1856 & y__h1559 ;
  assign y__h1943 = x__h2001 | y__h2002 ;
  assign y__h2002 = x__h2048 & y__h1751 ;
  assign y__h2135 = x__h2193 | y__h2194 ;
  assign y__h2194 = x__h2240 & y__h1943 ;
  assign y__h2327 = x__h2385 | y__h2386 ;
  assign y__h2386 = x__h2432 & y__h2135 ;
  assign y__h2519 = x__h2577 | y__h2578 ;
  assign y__h2578 = x__h2624 & y__h2327 ;
  assign y__h2711 = x__h2769 | y__h2770 ;
  assign y__h2770 = x__h2816 & y__h2519 ;
  assign y__h2903 = x__h2961 | y__h2962 ;
  assign y__h2962 = x__h3008 & y__h2711 ;
  assign y__h3095 = x__h3153 | y__h3154 ;
  assign y__h3154 = x__h3200 & y__h2903 ;
  assign y__h3287 = x__h3345 | y__h3346 ;
  assign y__h3346 = x__h3392 & y__h3095 ;
  assign y__h791 = x__h849 | y__h850 ;
  assign y__h850 = x__h896 & y__h897 ;
  assign y__h897 = rg_A[0] & rg_B[0] ;
  assign y__h983 = x__h1041 | y__h1042 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        rg_A <= `BSV_ASSIGNMENT_DELAY 16'd0;
	rg_Add <= `BSV_ASSIGNMENT_DELAY 16'd0;
	rg_B <= `BSV_ASSIGNMENT_DELAY 16'd0;
	rg_Carry <= `BSV_ASSIGNMENT_DELAY 16'd0;
      end
    else
      begin
        if (rg_A_EN) rg_A <= `BSV_ASSIGNMENT_DELAY rg_A_D_IN;
	if (rg_Add_EN) rg_Add <= `BSV_ASSIGNMENT_DELAY rg_Add_D_IN;
	if (rg_B_EN) rg_B <= `BSV_ASSIGNMENT_DELAY rg_B_D_IN;
	if (rg_Carry_EN) rg_Carry <= `BSV_ASSIGNMENT_DELAY rg_Carry_D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    rg_A = 16'hAAAA;
    rg_Add = 16'hAAAA;
    rg_B = 16'hAAAA;
    rg_Carry = 16'hAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkSigned_16bitAdd
