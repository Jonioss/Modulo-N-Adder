`timescale 1ns / 1ps

module tb;

    // Testbench signals
    reg  [7:0] inpA_tb = 8'h00;
    reg  [7:0] inpB_tb = 8'h00;
    reg        clk     = 1'b1;
    reg        rst     = 1'b0;
    wire [3:0] outp_tb;

    // Clock period: 50 ns -> toggle every 25 ns
    localparam CLK_PERIOD = 50;
    always #(CLK_PERIOD/2) clk = ~clk;

    // Instantiate the Unit Under Test (UUT)
    top uut (
        .A (inpA_tb),
	.B (inpB_tb),
        .clk (clk),
        .rst (rst),
        .R(outp_tb)
    );

    // Stimulus
    initial begin
        // Reset for 2 clock cycles
        rst = 1'b1;
        #(2*CLK_PERIOD);

        // Release reset and apply inputs
        rst     = 1'b0;
        inpA_tb = 8'h0A;
        inpB_tb = 8'h14;
        #(4*CLK_PERIOD);

	inpA_tb = 8'h04;
        inpB_tb = 8'h07;
	#(4*CLK_PERIOD);

	inpA_tb = 8'hA4;
        inpB_tb = 8'h03;
	#(4*CLK_PERIOD);

	inpA_tb = 8'h05;
        inpB_tb = 8'h0A;
	#(4*CLK_PERIOD);

	inpA_tb = 8'h0F;
        inpB_tb = 8'h19;
	#(4*CLK_PERIOD);

        $stop;
    end

endmodule
