//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Sat Oct 12 12:01:44 IST 2024
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_A                      O     1
// RDY_get_B                      O     1
// output_Mul                     O    16 reg
// RDY_output_Mul                 O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_A_a                        I     8
// get_B_b                        I     8
// EN_get_A                       I     1
// EN_get_B                       I     1
// EN_output_Mul                  I     1
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

module mkSigned_8bitMul(CLK,
			RST_N,

			get_A_a,
			EN_get_A,
			RDY_get_A,

			get_B_b,
			EN_get_B,
			RDY_get_B,

			EN_output_Mul,
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

  // actionvalue method output_Mul
  input  EN_output_Mul;
  output [15 : 0] output_Mul;
  output RDY_output_Mul;

  // signals for module outputs
  wire [15 : 0] output_Mul;
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
  reg [15 : 0] rg_AB;
  wire [15 : 0] rg_AB_D_IN;
  wire rg_AB_EN;

  // register rg_B
  reg [15 : 0] rg_B;
  wire [15 : 0] rg_B_D_IN;
  wire rg_B_EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_rl_multiply,
       CAN_FIRE_get_A,
       CAN_FIRE_get_B,
       CAN_FIRE_output_Mul,
       WILL_FIRE_RL_rl_multiply,
       WILL_FIRE_get_A,
       WILL_FIRE_get_B,
       WILL_FIRE_output_Mul;

  // inputs to muxes for submodule ports
  wire [15 : 0] MUX_partial_store_write_1__VAL_2,
		MUX_rg_A_write_1__VAL_1,
		MUX_rg_A_write_1__VAL_2,
		MUX_rg_B_write_1__VAL_1,
		MUX_rg_B_write_1__VAL_2;
  wire [4 : 0] MUX_count_write_1__VAL_2;
  wire MUX_completed_write_1__SEL_1, MUX_count_write_1__SEL_1;

  // action method get_A
  assign RDY_get_A = !got_A ;
  assign CAN_FIRE_get_A = !got_A ;
  assign WILL_FIRE_get_A = EN_get_A ;

  // action method get_B
  assign RDY_get_B = !got_B ;
  assign CAN_FIRE_get_B = !got_B ;
  assign WILL_FIRE_get_B = EN_get_B ;

  // actionvalue method output_Mul
  assign output_Mul = rg_AB ;
  assign RDY_output_Mul = 1'd1 ;
  assign CAN_FIRE_output_Mul = 1'd1 ;
  assign WILL_FIRE_output_Mul = EN_output_Mul ;

  // rule RL_rl_multiply
  assign CAN_FIRE_RL_rl_multiply = got_A && got_B && count != 5'd0 ;
  assign WILL_FIRE_RL_rl_multiply =
	     CAN_FIRE_RL_rl_multiply && !EN_output_Mul ;

  // inputs to muxes for submodule ports
  assign MUX_completed_write_1__SEL_1 =
	     WILL_FIRE_RL_rl_multiply && count == 5'd1 ;
  assign MUX_count_write_1__SEL_1 = EN_output_Mul && completed ;
  assign MUX_count_write_1__VAL_2 = count - 5'd1 ;
  assign MUX_partial_store_write_1__VAL_2 = partial_store + rg_A ;
  assign MUX_rg_A_write_1__VAL_1 = { rg_A[14:0], 1'd0 } ;
  assign MUX_rg_A_write_1__VAL_2 = { {8{get_A_a[7]}}, get_A_a } ;
  assign MUX_rg_B_write_1__VAL_1 = { 1'd0, rg_B[15:1] } ;
  assign MUX_rg_B_write_1__VAL_2 = { {8{get_B_b[7]}}, get_B_b } ;

  // register completed
  assign completed_D_IN = MUX_completed_write_1__SEL_1 ;
  assign completed_EN =
	     WILL_FIRE_RL_rl_multiply && count == 5'd1 || EN_get_A ;

  // register count
  assign count_D_IN =
	     MUX_count_write_1__SEL_1 ? 5'd16 : MUX_count_write_1__VAL_2 ;
  assign count_EN = EN_output_Mul && completed || WILL_FIRE_RL_rl_multiply ;

  // register got_A
  assign got_A_D_IN = !MUX_count_write_1__SEL_1 ;
  assign got_A_EN = EN_output_Mul && completed || EN_get_A ;

  // register got_B
  assign got_B_D_IN = !MUX_count_write_1__SEL_1 ;
  assign got_B_EN = EN_output_Mul && completed || EN_get_B ;

  // register partial_store
  assign partial_store_D_IN =
	     MUX_count_write_1__SEL_1 ?
	       16'd0 :
	       MUX_partial_store_write_1__VAL_2 ;
  assign partial_store_EN =
	     EN_output_Mul && completed ||
	     WILL_FIRE_RL_rl_multiply && rg_B[0] ;

  // register rg_A
  assign rg_A_D_IN =
	     WILL_FIRE_RL_rl_multiply ?
	       MUX_rg_A_write_1__VAL_1 :
	       MUX_rg_A_write_1__VAL_2 ;
  assign rg_A_EN = WILL_FIRE_RL_rl_multiply || EN_get_A ;

  // register rg_AB
  assign rg_AB_D_IN = partial_store ;
  assign rg_AB_EN = MUX_count_write_1__SEL_1 ;

  // register rg_B
  assign rg_B_D_IN =
	     WILL_FIRE_RL_rl_multiply ?
	       MUX_rg_B_write_1__VAL_1 :
	       MUX_rg_B_write_1__VAL_2 ;
  assign rg_B_EN = WILL_FIRE_RL_rl_multiply || EN_get_B ;

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
	rg_AB <= `BSV_ASSIGNMENT_DELAY 16'd0;
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
    rg_AB = 16'hAAAA;
    rg_B = 16'hAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkSigned_8bitMul

