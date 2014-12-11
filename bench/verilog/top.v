
`include "wb_model_defines.v"
`include "wb_ssram_if_define.v"

module top;

  // --------------------------------------------------
  // Wishbone common signal
  // --------------------------------------------------
  wire  WB_CLK  ;
  wire  WB_RESET;

  // --------------------------------------------------
  // Wishbone signal
  // --------------------------------------------------
  wire  [31:0]  WB_ADDR     [0:0];
  wire  [31:0]  WB_DATA_IN  [0:0];    // Master side direction
  wire  [31:0]  WB_DATA_OUT [0:0];    // Master side direction
  wire          WB_WE       [0:0];
  wire  [3:0]   WB_SEL      [0:0];
  wire          WB_STB      [0:0];
  wire          WB_ACK      [0:0];
  wire          WB_CYC      [0:0];
  wire          WB_ERR      [0:0];
  wire          WB_RTY      [0:0];

  // --------------------------------------------------
  // SSRAM signal
  // --------------------------------------------------
  wire                      SSRAM_CLK_IN;
  wire                      SSRAM_CLK   ;
  wire  [`WB_SSRAM_ADR-1:0] SSRAM_A     ;
  wire                      SSRAM_WE_N  ;
  wire                      SSRAM_OE_N  ;
  wire                      SSRAM_UB_N  ;
  wire                      SSRAM_LB_N  ;
  wire                      SSRAM_CE_N  ;
  wire  [15:0]              SSRAM_DQ_I  ;   // Data from SSRAM
  wire  [15:0]              SSRAM_DQ_O  ;   // Data to SSRAM
  wire  [15:0]              SSRAM_DQ_T  ;   // Tri-buffer control,'0' is output enable
  wire  [15:0]              SSRAM_DQ    ;

  // Data line tri-buffer
  assign SSRAM_DQ[ 0]   = (SSRAM_DQ_T[ 0] == 1'b0) ? SSRAM_DQ_O[ 0] : 1'bz;
  assign SSRAM_DQ[ 1]   = (SSRAM_DQ_T[ 1] == 1'b0) ? SSRAM_DQ_O[ 1] : 1'bz;
  assign SSRAM_DQ[ 2]   = (SSRAM_DQ_T[ 2] == 1'b0) ? SSRAM_DQ_O[ 2] : 1'bz;
  assign SSRAM_DQ[ 3]   = (SSRAM_DQ_T[ 3] == 1'b0) ? SSRAM_DQ_O[ 3] : 1'bz;
  assign SSRAM_DQ[ 4]   = (SSRAM_DQ_T[ 4] == 1'b0) ? SSRAM_DQ_O[ 4] : 1'bz;
  assign SSRAM_DQ[ 5]   = (SSRAM_DQ_T[ 5] == 1'b0) ? SSRAM_DQ_O[ 5] : 1'bz;
  assign SSRAM_DQ[ 6]   = (SSRAM_DQ_T[ 6] == 1'b0) ? SSRAM_DQ_O[ 6] : 1'bz;
  assign SSRAM_DQ[ 7]   = (SSRAM_DQ_T[ 7] == 1'b0) ? SSRAM_DQ_O[ 7] : 1'bz;
  assign SSRAM_DQ[ 8]   = (SSRAM_DQ_T[ 8] == 1'b0) ? SSRAM_DQ_O[ 8] : 1'bz;
  assign SSRAM_DQ[ 9]   = (SSRAM_DQ_T[ 9] == 1'b0) ? SSRAM_DQ_O[ 9] : 1'bz;
  assign SSRAM_DQ[10]   = (SSRAM_DQ_T[10] == 1'b0) ? SSRAM_DQ_O[10] : 1'bz;
  assign SSRAM_DQ[11]   = (SSRAM_DQ_T[11] == 1'b0) ? SSRAM_DQ_O[11] : 1'bz;
  assign SSRAM_DQ[12]   = (SSRAM_DQ_T[12] == 1'b0) ? SSRAM_DQ_O[12] : 1'bz;
  assign SSRAM_DQ[13]   = (SSRAM_DQ_T[13] == 1'b0) ? SSRAM_DQ_O[13] : 1'bz;
  assign SSRAM_DQ[14]   = (SSRAM_DQ_T[14] == 1'b0) ? SSRAM_DQ_O[14] : 1'bz;
  assign SSRAM_DQ[15]   = (SSRAM_DQ_T[15] == 1'b0) ? SSRAM_DQ_O[15] : 1'bz;

  assign SSRAM_DQ_I[ 0] = (SSRAM_DQ_T[ 0] == 1'b1) ? SSRAM_DQ  [ 0] : 1'bx;
  assign SSRAM_DQ_I[ 1] = (SSRAM_DQ_T[ 1] == 1'b1) ? SSRAM_DQ  [ 1] : 1'bx;
  assign SSRAM_DQ_I[ 2] = (SSRAM_DQ_T[ 2] == 1'b1) ? SSRAM_DQ  [ 2] : 1'bx;
  assign SSRAM_DQ_I[ 3] = (SSRAM_DQ_T[ 3] == 1'b1) ? SSRAM_DQ  [ 3] : 1'bx;
  assign SSRAM_DQ_I[ 4] = (SSRAM_DQ_T[ 4] == 1'b1) ? SSRAM_DQ  [ 4] : 1'bx;
  assign SSRAM_DQ_I[ 5] = (SSRAM_DQ_T[ 5] == 1'b1) ? SSRAM_DQ  [ 5] : 1'bx;
  assign SSRAM_DQ_I[ 6] = (SSRAM_DQ_T[ 6] == 1'b1) ? SSRAM_DQ  [ 6] : 1'bx;
  assign SSRAM_DQ_I[ 7] = (SSRAM_DQ_T[ 7] == 1'b1) ? SSRAM_DQ  [ 7] : 1'bx;
  assign SSRAM_DQ_I[ 8] = (SSRAM_DQ_T[ 8] == 1'b1) ? SSRAM_DQ  [ 8] : 1'bx;
  assign SSRAM_DQ_I[ 9] = (SSRAM_DQ_T[ 9] == 1'b1) ? SSRAM_DQ  [ 9] : 1'bx;
  assign SSRAM_DQ_I[10] = (SSRAM_DQ_T[10] == 1'b1) ? SSRAM_DQ  [10] : 1'bx;
  assign SSRAM_DQ_I[11] = (SSRAM_DQ_T[11] == 1'b1) ? SSRAM_DQ  [11] : 1'bx;
  assign SSRAM_DQ_I[12] = (SSRAM_DQ_T[12] == 1'b1) ? SSRAM_DQ  [12] : 1'bx;
  assign SSRAM_DQ_I[13] = (SSRAM_DQ_T[13] == 1'b1) ? SSRAM_DQ  [13] : 1'bx;
  assign SSRAM_DQ_I[14] = (SSRAM_DQ_T[14] == 1'b1) ? SSRAM_DQ  [14] : 1'bx;
  assign SSRAM_DQ_I[15] = (SSRAM_DQ_T[15] == 1'b1) ? SSRAM_DQ  [15] : 1'bx;

  assign SSRAM_CLK_IN = WB_CLK;

  // simple wishbone syscon model
  wb_simple_syscon Uwb_simple_syscon(
      .clk  (WB_CLK   )
    , .rst  (WB_RESET )
  );

  // --------------------------------------------------
  // Wishbone master model
  // --------------------------------------------------
  wb_mast Uwb_master0(
      .clk  (WB_CLK   )
    , .rst  (WB_RESET )

    , .adr  (WB_ADDR    [0])
    , .din  (WB_DATA_IN [0])
    , .dout (WB_DATA_OUT[0])
    , .we   (WB_WE      [0])
    , .sel  (WB_SEL     [0])
    , .stb  (WB_STB     [0])
    , .ack  (WB_ACK     [0])
    , .cyc  (WB_CYC     [0])
    , .err  (WB_ERR     [0])
    , .rty  (WB_RTY     [0])
  );

  // --------------------------------------------------
  // Wishbone SSRAM controller, SSRAM model
  // --------------------------------------------------
  wb_ssram_if Uwb_ssram_if (
      .clk  (WB_CLK   )
    , .rst  (WB_RESET )

    , .adr  (WB_ADDR    [0])
    , .din  (WB_DATA_OUT[0])
    , .dout (WB_DATA_IN [0])
    , .we   (WB_WE      [0])
    , .sel  (WB_SEL     [0])
    , .stb  (WB_STB     [0])
    , .ack  (WB_ACK     [0])
    , .cyc  (WB_CYC     [0])
    , .err  (WB_ERR     [0])
    , .rty  (WB_RTY     [0])

    , .SSRAM_CLK_IN     (SSRAM_CLK_IN)
    , .SSRAM_CLK        (SSRAM_CLK   )
    , .SSRAM_A          (SSRAM_A     )
    , .SSRAM_WE_N       (SSRAM_WE_N  )
    , .SSRAM_OE_N       (SSRAM_OE_N  )
    , .SSRAM_UB_N       (SSRAM_UB_N  )
    , .SSRAM_LB_N       (SSRAM_LB_N  )
    , .SSRAM_CE_N       (SSRAM_CE_N  )
    , .SSRAM_DQ_I       (SSRAM_DQ_I  )
    , .SSRAM_DQ_O       (SSRAM_DQ_O  )
    , .SSRAM_DQ_T       (SSRAM_DQ_T  )
  );

  k7a161830b #(.addr_bits(`WB_SSRAM_ADR),
               .data_bits(16),
               .mem_sizes(1 * 512 * 1024))
  Ussram (
      .CLK      (SSRAM_CLK      )
    , .A        (SSRAM_A        )
    , .ADV_N    (1'b1           )
    , .ADSP_N   (1'b1           )
    , .ADSC_N   (1'b0           )
    , .CS1_N    (SSRAM_CE_N     )
    , .CS2      (~SSRAM_CE_N    )
    , .CS2_N    (SSRAM_CE_N     )
    , .WE_N     ({SSRAM_UB_N, SSRAM_LB_N})
    , .OE_N     (SSRAM_OE_N     )
    , .GW_N     (1'b1           )
    , .BW_N     (SSRAM_WE_N     )
    , .ZZ       (1'b0           )
    , .LBO_N    (1'b1           )
    , .DQ       (SSRAM_DQ       )
  );

  // --------------------------------------------------
  // Testbench
  // --------------------------------------------------
  reg [31:0] rdata0;
  reg [31:0] rdata1;
  reg [31:0] rdata2;
  reg [31:0] rdata3;

  reg [31:0] wdata0;
  reg [31:0] wdata1;
  reg [31:0] wdata2;
  reg [31:0] wdata3;

  reg [31:0] addr0;

  reg [4:0]  s;

  initial begin
    wait(WB_RESET == 1'b0);
    wait(WB_RESET == 1'b1);

    #200 $display("testbench start");
    #200 $display("\ntestbench write 1 word test");
    s = 4'b1111;
    addr0 = 32'h0000_0000;
    wdata0 = 32'hDEAD_BEEF;

    Uwb_master0.wb_wr1(addr0, s, wdata0);
    $display("write [0x%08x] : 0x%08x", addr0, wdata0);

    Uwb_master0.wb_rd1(addr0, s, rdata0);
    $display("read [0x%08x] : 0x%08x", addr0, rdata0);
    if(wdata0 != rdata0) begin
      $display("Single word write/read error");
      $finish;
    end

    #100 $display("\ntestbench write 4 word test");
    wdata0 = 32'hDEAD_BEE0;
    wdata1 = 32'hDEAD_BEE1;
    wdata2 = 32'hDEAD_BEE2;
    wdata3 = 32'hDEAD_BEE3;

    Uwb_master0.wb_wr4(addr0, s, 1'b1, wdata0, wdata1, wdata2, wdata3);
    $display("write [0x%08x] : 0x%08x", addr0 + 32'h0, wdata0);
    $display("write [0x%08x] : 0x%08x", addr0 + 32'h4, wdata1);
    $display("write [0x%08x] : 0x%08x", addr0 + 32'h8, wdata2);
    $display("write [0x%08x] : 0x%08x", addr0 + 32'hC, wdata3);

    Uwb_master0.wb_rd4(addr0, s, 1'b1, rdata0, rdata1, rdata2, rdata3);
    $display("read [0x%08x] : 0x%08x", addr0 + 32'h0, rdata0);
    $display("read [0x%08x] : 0x%08x", addr0 + 32'h4, rdata1);
    $display("read [0x%08x] : 0x%08x", addr0 + 32'h8, rdata2);
    $display("read [0x%08x] : 0x%08x", addr0 + 32'hC, rdata3);

    if(wdata0 != rdata0 || wdata1 != rdata1 || wdata2 != rdata2 || wdata3 != rdata3) begin
      $display("4 word write/read error");
      $finish;
    end

    #200 $display("\ntestbench write byte test");
    s = 4'b0001;
    wdata0 = 32'h0000_00EF;

    Uwb_master0.wb_wr1(addr0, s, wdata0);
    $display("write [0x%08x] : 0x%08x", addr0, wdata0);
    Uwb_master0.wb_rd1(addr0, s, rdata0);
    $display("read [0x%08x] : 0x%08x", addr0, rdata0);
    if(wdata0 != rdata0) begin
      $display("Byte write/read error");
      $finish;
    end

    s = 4'b0010;
    wdata0 = 32'h0000_BE00;

    Uwb_master0.wb_wr1(addr0, s, wdata0);
    $display("write [0x%08x] : 0x%08x", addr0, wdata0);
    Uwb_master0.wb_rd1(addr0, s, rdata0);
    $display("read [0x%08x] : 0x%08x", addr0, rdata0);
    if(wdata0 != rdata0) begin
      $display("Byte write/read error");
      $finish;
    end

    s = 4'b0100;
    wdata0 = 32'h00AD_0000;

    Uwb_master0.wb_wr1(addr0, s, wdata0);
    $display("write [0x%08x] : 0x%08x", addr0, wdata0);
    Uwb_master0.wb_rd1(addr0, s, rdata0);
    $display("read [0x%08x] : 0x%08x", addr0, rdata0);
    if(wdata0 != rdata0) begin
      $display("Byte write/read error");
      $finish;
    end

    s = 4'b1000;
    wdata0 = 32'hDE00_0000;

    Uwb_master0.wb_wr1(addr0, s, wdata0);
    $display("write [0x%08x] : 0x%08x", addr0, wdata0);
    Uwb_master0.wb_rd1(addr0, s, rdata0);
    $display("read [0x%08x] : 0x%08x", addr0, rdata0);
    if(wdata0 != rdata0) begin
      $display("Byte write/read error");
      $finish;
    end

    $display("#ALL PASS");
    #200 $finish;
  end

  // --------------------------------------------------
  initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0);
  end
  // --------------------------------------------------
endmodule
