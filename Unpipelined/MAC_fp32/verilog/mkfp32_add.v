//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Wed Oct 23 23:26:49 IST 2024
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_A                      O     1
// RDY_get_B                      O     1
// out_AaddB                      O    32 reg
// RDY_out_AaddB                  O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_A_a                        I    16 reg
// get_B_b                        I    32 reg
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

module mkfp32_add(CLK,
		  RST_N,

		  get_A_a,
		  EN_get_A,
		  RDY_get_A,

		  get_B_b,
		  EN_get_B,
		  RDY_get_B,

		  out_AaddB,
		  RDY_out_AaddB);
  input  CLK;
  input  RST_N;

  // action method get_A
  input  [15 : 0] get_A_a;
  input  EN_get_A;
  output RDY_get_A;

  // action method get_B
  input  [31 : 0] get_B_b;
  input  EN_get_B;
  output RDY_get_B;

  // value method out_AaddB
  output [31 : 0] out_AaddB;
  output RDY_out_AaddB;

  // signals for module outputs
  wire [31 : 0] out_AaddB;
  wire RDY_get_A, RDY_get_B, RDY_out_AaddB;

  // register bf_a
  reg [15 : 0] bf_a;
  wire [15 : 0] bf_a_D_IN;
  wire bf_a_EN;

  // register fp_b
  reg [31 : 0] fp_b;
  wire [31 : 0] fp_b_D_IN;
  wire fp_b_EN;

  // register fp_c
  reg [31 : 0] fp_c;
  wire [31 : 0] fp_c_D_IN;
  wire fp_c_EN;

  // register got_A
  reg got_A;
  wire got_A_D_IN, got_A_EN;

  // register got_B
  reg got_B;
  wire got_B_D_IN, got_B_EN;

  // rule scheduling signals
  wire CAN_FIRE_get_A, CAN_FIRE_get_B, WILL_FIRE_get_A, WILL_FIRE_get_B;

  // action method get_A
  assign RDY_get_A = !got_A ;
  assign CAN_FIRE_get_A = !got_A ;
  assign WILL_FIRE_get_A = EN_get_A ;

  // action method get_B
  assign RDY_get_B = !got_B ;
  assign CAN_FIRE_get_B = !got_B ;
  assign WILL_FIRE_get_B = EN_get_B ;

  // value method out_AaddB
  assign out_AaddB = fp_c ;
  assign RDY_out_AaddB = 1'd1 ;

  // register bf_a
  assign bf_a_D_IN = get_A_a ;
  assign bf_a_EN = EN_get_A ;

  // register fp_b
  assign fp_b_D_IN = get_B_b ;
  assign fp_b_EN = EN_get_B ;

  // register fp_c
  assign fp_c_D_IN = 32'h0 ;
  assign fp_c_EN = 1'b0 ;

  // register got_A
  assign got_A_D_IN = 1'd1 ;
  assign got_A_EN = EN_get_A ;

  // register got_B
  assign got_B_D_IN = 1'd1 ;
  assign got_B_EN = EN_get_B ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        bf_a <= `BSV_ASSIGNMENT_DELAY 16'd0;
	fp_b <= `BSV_ASSIGNMENT_DELAY 32'd0;
	fp_c <= `BSV_ASSIGNMENT_DELAY 32'd0;
	got_A <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_B <= `BSV_ASSIGNMENT_DELAY 1'd0;
      end
    else
      begin
        if (bf_a_EN) bf_a <= `BSV_ASSIGNMENT_DELAY bf_a_D_IN;
	if (fp_b_EN) fp_b <= `BSV_ASSIGNMENT_DELAY fp_b_D_IN;
	if (fp_c_EN) fp_c <= `BSV_ASSIGNMENT_DELAY fp_c_D_IN;
	if (got_A_EN) got_A <= `BSV_ASSIGNMENT_DELAY got_A_D_IN;
	if (got_B_EN) got_B <= `BSV_ASSIGNMENT_DELAY got_B_D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    bf_a = 16'hAAAA;
    fp_b = 32'hAAAAAAAA;
    fp_c = 32'hAAAAAAAA;
    got_A = 1'h0;
    got_B = 1'h0;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkfp32_add

