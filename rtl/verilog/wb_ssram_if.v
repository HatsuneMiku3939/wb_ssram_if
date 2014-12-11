// ts=4

`include "wb_ssram_if_define.v"

module wb_ssram_if (
  // --------------------------------------------
  // 32Bit Whishbone interface
  // --------------------------------------------
    input   wire          clk
  , input   wire          rst

  , input   wire  [31:0]  adr
  , input   wire  [31:0]  din
  , output  reg   [31:0]  dout
  , input   wire          cyc
  , input   wire          stb
  , input   wire  [3:0]   sel
  , input   wire          we
  , output  reg           ack
  , output  reg           err
  , output  reg           rty

  // --------------------------------------------
  // 16Bit SSRAM interface
  // --------------------------------------------
  , input   wire                      SSRAM_CLK_IN
  , output  wire                      SSRAM_CLK
  , output  reg   [`WB_SSRAM_ADR-1:0] SSRAM_A
  , output  reg                       SSRAM_WE_N
  , output  reg                       SSRAM_OE_N
  , output  reg                       SSRAM_UB_N
  , output  reg                       SSRAM_LB_N
  , output  reg                       SSRAM_CE_N
  , input   wire  [15:0]              SSRAM_DQ_I      // Data from SSRAM
  , output  reg   [15:0]              SSRAM_DQ_O      // Data to SSRAM
  , output  reg   [15:0]              SSRAM_DQ_T      // Tri-buffer control,'0' is output enable
);
  // --------------------------------------------
  // Constant SSRAM control signal
  // --------------------------------------------
  assign SSRAM_CLK = SSRAM_CLK_IN;

  // --------------------------------------------
  // internal signals
  // --------------------------------------------
  reg read_go;
  reg write_go;

  reg read_done;
  reg write_done;

  reg [30:0]  sram_addr;        // 16bit addressing
  reg [31:0]  read_data;
  reg [31:0]  write_data;
  reg [3:0]   byte_en;

  // --------------------------------------------
  // main fsm
  // --------------------------------------------
  reg [3:0] state;

  parameter STW_IDLE    = 4'b0001,
            STW_READ    = 4'b0010,
            STW_WRITE   = 4'b0100,
            STW_DONE    = 4'b1000;

  always @(posedge clk or posedge rst) begin
    if(rst == 1'b1) begin     // reset
      // wishbone signal rest
      ack   <= 1'b0;
      rty   <= 1'b0;
      err   <= 1'b0;
      dout  <= 32'h0;

      // internal signal reset
      read_go  <= 1'b0;
      write_go <= 1'b0;

      write_data  <= 32'h0;
      byte_en   <= 4'b0;

      state <= STW_IDLE;
    end else begin
      case(state)
      STW_IDLE: begin
        if(cyc & stb & !we) begin     // read cycle
          read_go   <= 1'b1;    // read start
          byte_en   <= sel;
          sram_addr <= adr[31:1]; // 16bit addressing

          state     <= STW_READ;
        end else if(cyc & stb & we) begin // write cycle
          write_go  <= 1'b1;    // write start
          byte_en   <= sel;
          sram_addr <= adr[31:1]; // 16bit addressing
          `ifdef WB_SSRAM_ENDIAN_LITTLE
            write_data  <= {din[7:0], din[15:8], din[23:16], din[31:24]};
          `else
            write_data  <= din;
          `endif

          state     <= STW_WRITE;
        end else begin            // idle cycle
          read_go  <= 1'b0;
          write_go <= 1'b0;

          sram_addr <= 31'h0;
          write_data  <= 32'h0;
          byte_en   <= 4'b0;
          ack     <= 1'b0;
        end
      end

      STW_READ: begin
        if(read_done) begin
          read_go <= 1'b0;  // read stop

          `ifdef WB_SSRAM_ENDIAN_LITTLE
            dout  <= {read_data[7:0], read_data[15:8], read_data[23:16], read_data[31:24]};
          `else
            dout  <= read_data;
          `endif
          ack   <= 1'b1;
          state <= STW_DONE;
        end
      end

      STW_WRITE: begin
        if(write_done) begin
          write_go  <= 1'b0;  // write stop

          ack   <= 1'b1;
          state   <= STW_DONE;
        end
      end

      STW_DONE: begin
        ack   <= 1'b0;
        dout  <= 32'h0;
        state   <= STW_IDLE;
      end

      endcase
    end
  end

  // --------------------------------------------
  // sram state machine
  // --------------------------------------------
  reg [10:0] ssram_state;

  parameter STS_IDLE    = 11'b000_0000_0001,
            STS_READ0   = 11'b000_0000_0010,
            STS_READ1   = 11'b000_0000_0100,
            STS_READ2   = 11'b000_0000_1000,
            STS_READ3   = 11'b000_0001_0000,
            STS_WRITE0  = 11'b000_0100_0000,
            STS_WRITE1  = 11'b000_1000_0000,
            STS_RD_DONE = 11'b010_0000_0000,
            STS_WD_DONE = 11'b100_0000_0000;

  always @(negedge SSRAM_CLK_IN or posedge rst) begin
    if(rst == 1'b1) begin
      write_done  <= 1'b0;
      read_done <= 1'b0;

      read_data <= 32'h0;

      ssram_state <= STS_IDLE;
    end else begin
      case(ssram_state)
      STS_IDLE: begin
        if(write_go == 1'b1) begin      // write go
          ssram_state <= STS_WRITE0;

        end else if(read_go == 1'b1) begin  // read go
          ssram_state <= STS_READ0;

        end else begin            // idel, de-select SSRAM
          SSRAM_CE_N <= 1'b1;
          SSRAM_WE_N <= 1'b1;
          SSRAM_OE_N <= 1'b1;
          SSRAM_UB_N <= 1'b1;
          SSRAM_LB_N <= 1'b1;

          SSRAM_DQ_T <= 16'hFFFF;
          SSRAM_DQ_O <= 16'h0;
          SSRAM_A    <= 32'hFFFFFFFF;
        end
      end

      STS_WRITE0: begin
        SSRAM_CE_N  <= 1'b0;
        SSRAM_WE_N  <= 1'b0;
        SSRAM_OE_N  <= 1'b1;
        SSRAM_A     <= sram_addr;

        SSRAM_DQ_T  <= 16'h0000;

        SSRAM_UB_N  <= ~byte_en[1];
        SSRAM_LB_N  <= ~byte_en[0];
        SSRAM_DQ_O  <= write_data[15:0];

        ssram_state <= STS_WRITE1;
      end

      STS_WRITE1: begin
        SSRAM_UB_N  <= ~byte_en[3];
        SSRAM_LB_N  <= ~byte_en[2];
        SSRAM_DQ_O  <= write_data[31:16];

        SSRAM_A   <= sram_addr + 31'h1;

        write_done  <= 1'b1;
        ssram_state <= STS_WD_DONE;
      end

      STS_READ0: begin
        SSRAM_UB_N  <= 1'b0;
        SSRAM_LB_N  <= 1'b0;
        SSRAM_CE_N  <= 1'b0;
        SSRAM_OE_N  <= 1'b0;
        SSRAM_A     <= sram_addr;

        ssram_state <= STS_READ1;
      end

      STS_READ1: begin
        SSRAM_A   <= sram_addr + 31'h1;
        ssram_state <= STS_READ2;
      end

      STS_READ2: begin
        read_data[ 7:0] <= byte_en[0] ? SSRAM_DQ_I[ 7:0] : 8'h0;
        read_data[15:8] <= byte_en[1] ? SSRAM_DQ_I[15:8] : 8'h0;

        SSRAM_A    <= 32'hFFFFFFFF;
        ssram_state <= STS_READ3;
      end

      STS_READ3: begin
        read_data[23:16] <= byte_en[2] ? SSRAM_DQ_I[ 7:0] : 8'h0;
        read_data[31:24] <= byte_en[3] ? SSRAM_DQ_I[15:8] : 8'h0;

        read_done <= 1'b1;
        ssram_state <= STS_RD_DONE;
      end

      STS_WD_DONE: begin
        if(write_go == 1'b0) begin
          write_done  <= 1'b0;
          ssram_state <= STS_IDLE;
        end

        SSRAM_CE_N <= 1'b1;
        SSRAM_WE_N <= 1'b1;
        SSRAM_OE_N <= 1'b1;
        SSRAM_UB_N <= 1'b1;
        SSRAM_LB_N <= 1'b1;

        SSRAM_DQ_T <= 16'hFFFF;
        SSRAM_DQ_O <= 16'h0;
        SSRAM_A    <= 32'hFFFFFFFF;
      end

      STS_RD_DONE: begin
        if(read_go == 1'b0) begin
          read_done <= 1'b0;
          read_data <= 32'h0;
          ssram_state <= STS_IDLE;
        end

        SSRAM_OE_N <= 1'b1;
        SSRAM_UB_N <= 1'b1;
        SSRAM_LB_N <= 1'b1;
        SSRAM_CE_N <= 1'b1;
      end

      endcase
    end
  end
endmodule
