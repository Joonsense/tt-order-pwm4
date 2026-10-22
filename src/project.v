`default_nettype none

module tt_um_joonsense_pwm4 (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);
  reg [7:0] counter;
  reg [7:0] duty0, duty1, duty2, duty3;

  always @(posedge clk) begin
    if (!rst_n) begin
      counter <= 8'd0;
      duty0 <= 8'd0; duty1 <= 8'd0; duty2 <= 8'd0; duty3 <= 8'd0;
    end else begin
      counter <= counter + 8'd1;
      if (uio_in[0]) begin
        case (uio_in[2:1])
          2'd0: duty0 <= ui_in;
          2'd1: duty1 <= ui_in;
          2'd2: duty2 <= ui_in;
          default: duty3 <= ui_in;
        endcase
      end
    end
  end

  assign uo_out  = {4'b0000, counter < duty3, counter < duty2, counter < duty1, counter < duty0};
  assign uio_out = 8'h00;
  assign uio_oe  = 8'h00;
  wire _unused = &{ena, uio_in[7:3], 1'b0};
endmodule
