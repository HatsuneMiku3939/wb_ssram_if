
`include "wb_model_defines.v"
module wb_simple_syscon(
  output	wire	clk
  , output	wire	rst
  );

  // --------------------------------------------------
  reg clk_internal;
  reg rst_internal;

  assign clk = clk_internal;
  assign rst = rst_internal;

  // --------------------------------------------------
  initial begin
    clk_internal <= 1'b0;
    rst_internal <= 1'b0;
  end

  // --------------------------------------------------
  always #10 clk_internal <= ~clk_internal;

  initial begin
    rst_internal <= 1'b0;
    #20 rst_internal <= 1'b1;
    #80 rst_internal <= 1'b0;
  end

  // --------------------------------------------------
  integer stamp_f;
  integer stamp_s;
  initial begin
    wait(rst_internal == 1'b0);
    wait(rst_internal == 1'b1);
    @ (posedge clk_internal);
    @ (posedge clk_internal); stamp_f = $time;
    @ (posedge clk_internal); stamp_s = $time;
    @ (negedge clk_internal); $display("WB_CLK %d nsec", stamp_s - stamp_f);
  end

  endmodule
