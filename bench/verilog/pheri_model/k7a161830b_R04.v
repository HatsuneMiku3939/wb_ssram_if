/****************************************************************************************
* 
*  SAMSUNG 16Mb SPB(2E1D) SRAM Verilog Behavioral model
*  
*  Description :  K7A161830B (1M x 18)
*
*  File Name   :  k7a161830b.v 
*  Version     :  Rev0.4 
*  Date        :  Jan 30th, 2002
*
*  Simulator   :  Velilog-XL (CADENCE)
*
*  Author      :  Seungmin Lee 
*  Email       :  smlee5253@samsung.co.kr
*  Phone       :  (82) 31-209-3823 
*  Company     :  SAMSUNG ELECTRONICS Co,. LTD.
*
*  Note        :  - Set simulator resolution to "ps" timescale
*                 - IEEE 1149.1 Serial Boundary Scan (JTAG) is not implemented
*		  - Following case is prohibited 
*			-- (Begin or Continue or Suspend) Read -> (Begin or Continue or Suspend) Write 
*			-- Not selected -> (Continue or Suspend)  Read/Write
*		  - Not selected operate after "tHZC" delay of the same clock (because of "2E1D") 			
*		  - CS2, CS2_N is used only 100-TQFP. 
*		    if you want to use in the 119-BGA or 165-FGBA, you must set CS2 = '1' and CS2_N = '0' in the input file    
*
*        Copyright(c) SAMSUNG ELECTRONICS Co,. 2001 
*        All rights reserved
*  
*   Revision History :
*
*   Rev  Author          Phone            Date        Changes
*   ---  --------------  --------------   ----------  --------------------------------------
*   0.0  Seungmin Lee   (82) 31-209-3823  10/11/2001  
*   0.1  Seungmin Lee   (82) 31-209-3823  11/22/2001  modify the part of CLK, async signal 
*   0.2  Seungmin Lee   (82) 31-209-3823  12/22/2001  correct the pin configuration 
*   0.3  Seungmin Lee   (82) 31-209-3823  01/07/2001  add the effect of tOH
*   0.4  Seungmin Lee   (82) 31-209-3823  01/30/2001  speed bin merge, ac parameter change
*
****************************************************************************************/

// Define time scale $ accuracy  
`timescale 1ns / 1ps

`define qc25

`ifdef qc25
        `define         tCYC    4.0
        `define         tCD     2.6
        `define         tOE     2.6
        `define         tLZC    0.1
        `define         tOH     1.5
        `define         tLZOE   0.1
        `define         tHZOE   2.6
        `define         tHZC    1.5
        `define         tCH     1.7
        `define         tCL     1.7
        `define         tAS     1.2
        `define         tSS     1.2
        `define         tDS     1.2
        `define         tWS     1.2
        `define         tADVS   1.2
        `define         tCSS    1.2
        `define         tAH     0.3
        `define         tSH     0.3
        `define         tDH     0.3
        `define         tWH     0.3
        `define         tADVH   0.3
        `define         tCSH    0.3
        `define         tPUS    8
        `define         tPDS    8
`endif

`ifdef qc22
        `define         tCYC    4.4
        `define         tCD     2.8
        `define         tOE     2.8
        `define         tLZC    0
        `define         tOH     1.5
        `define         tLZOE   0
        `define         tHZOE   2.8
        `define         tHZC    1.5
        `define         tCH     1.8
        `define         tCL     1.8
        `define         tAS     1.4
        `define         tSS     1.4
        `define         tDS     1.4
        `define         tWS     1.4
        `define         tADVS   1.4
        `define         tCSS    1.4
        `define         tAH     0.4
        `define         tSH     0.4
        `define         tDH     0.4
        `define         tWH     0.4
        `define         tADVH   0.4
        `define         tCSH    0.4
        `define         tPUS    8.8
        `define         tPDS    8.8
`endif

`ifdef qc20
        `define         tCYC    5.0
        `define         tCD     3.1
        `define         tOE     3.1
        `define         tLZC    0
        `define         tOH     1.5
        `define         tLZOE   0
        `define         tHZOE   3.0
        `define         tHZC    1.5
        `define         tCH     2.0
        `define         tCL     2.0
        `define         tAS     1.4
        `define         tSS     1.4
        `define         tDS     1.4
        `define         tWS     1.4
        `define         tADVS   1.4
        `define         tCSS    1.4
        `define         tAH     0.4
        `define         tSH     0.4
        `define         tDH     0.4
        `define         tWH     0.4
        `define         tADVH   0.4
        `define         tCSH    0.4
        `define         tPUS    10
        `define         tPDS    10
`endif

`ifdef qc16
        `define         tCYC    6.0
        `define         tCD     3.5
        `define         tOE     3.5
        `define         tLZC    0
        `define         tOH     1.5
        `define         tLZOE   0
        `define         tHZOE   3.0
        `define         tHZC    1.5
        `define         tCH     2.1
        `define         tCL     2.1
        `define         tAS     1.5
        `define         tSS     1.5
        `define         tDS     1.5
        `define         tWS     1.5
        `define         tADVS   1.5
        `define         tCSS    1.5
        `define         tAH     0.5
        `define         tSH     0.5
        `define         tDH     0.5
        `define         tWH     0.5
        `define         tADVH   0.5
        `define         tCSH    0.5
        `define         tPUS    12
        `define         tPDS    12
`endif

`ifdef qc14
        `define         tCYC    7.2
        `define         tCD     4.0
        `define         tOE     4.0
        `define         tLZC    0
        `define         tOH     1.5
        `define         tLZOE   0
        `define         tHZOE   3.5
        `define         tHZC    1.5
        `define         tCH     2.5
        `define         tCL     2.5
        `define         tAS     1.5
        `define         tSS     1.5
        `define         tDS     1.5
        `define         tWS     1.5
        `define         tADVS   1.5
        `define         tCSS    1.5
        `define         tAH     0.5
        `define         tSH     0.5
        `define         tDH     0.5
        `define         tWH     0.5
        `define         tADVH   0.5
        `define         tCSH    0.5
        `define         tPUS    14.4
        `define         tPDS    14.4
`endif

// speed option 

////////////////////////////////////////////////////////////////////////////////
//////////////////       Main module       ////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

module k7a161830b (A, ADV_N, ADSP_N, ADSC_N, CLK, CS1_N, CS2, CS2_N, WE_N, OE_N, GW_N, BW_N, ZZ, LBO_N, DQ);

	// Constant Parameters
	parameter	addr_bits =      20;    // This is external address
	parameter	data_bits =      18;
	parameter	mem_sizes =  1*1024*1024 - 1;

	// Port Declaration
	input		[addr_bits - 1 : 0]	A;
	input					ADV_N;
	input					ADSP_N;
	input					ADSC_N;
	input					CLK;
	input					CS1_N;
	input					CS2;
	input					CS2_N;
	input		[1 : 0]			WE_N;
	input					OE_N;
	input					GW_N;
	input					BW_N;
	input					ZZ;
	input					LBO_N;
	inout		[data_bits - 1 : 0]	DQ;

	reg		[data_bits - 1 : 0]	SMEM [0 : mem_sizes];
	reg					Write_N;
	reg					zz_tm;
	reg		[addr_bits -1 : 0]	Addr_reg;
	reg		[addr_bits -1 : 0]	Init_addr;
	reg		[data_bits -1 : 0]	Out_reg;
	reg		[data_bits -1 : 0]	Out_buf;
	reg		[data_bits -1 : 0]	Out_buf_tm;
	reg		[data_bits -1 : 0]	In_reg;
	reg		[data_bits -1 : 0]	Data_tm;
	reg		[2 : 0]			Command_pi	[0 : 2];	// 001 : Begin Read, 010 : Begin Write, 
										// 011 : Conti Read, 100 : Conti Write
										// 101 : Suspend Read, 110 : Suspend Write			
	reg		[addr_bits - 1 : 0]	Addr_pi		[0 : 1];
	reg		[addr_bits - 1 : 0]	Addr_tm;		
	reg					Int_clk;
	reg					enable;
	reg					cs2_reg;
	reg					cs2b_reg;
	
	integer					id;
	integer					addr_cnt;

	// Initial Condition
	initial begin	
		enable = 1'b0;
		zz_tm = 0;
		Out_reg = {data_bits{1'bz}};
		Out_buf = {data_bits{1'bz}};
	end	// initial end

	always	@ (posedge CLK) begin
			Int_clk = CLK & ~zz_tm;
	end

	always	@ (negedge CLK) begin
			Int_clk = 1'b0;
	end

	always  @ (posedge ZZ) begin
		zz_tm <= #`tPDS ZZ;
		Out_buf <= #`tPDS {data_bits{1'bz}};
		Command_pi[0] = 3'b111;
	end

	always  @ (negedge ZZ) begin
		zz_tm <= #`tPUS ZZ;
	end

	always	@ (posedge OE_N) begin
		enable <= #`tHZOE OE_N;
	end

	always	@ (negedge OE_N) begin
		enable <= #`tLZOE OE_N;
	end


	assign	DQ = enable ? {data_bits{1'bz}} : Out_buf;

	always @ (posedge Int_clk) begin	// always-00

	// $display("$m : at time %t : ----------------------------------------------------------------------------------------",$time);	
	// Command pipe
	Command_pi[2] = Command_pi[1];
	Command_pi[1] = Command_pi[0];
	Command_pi[0] = 3'b111;

	// Address pipe
	Addr_pi[1] = Addr_pi[0];
	Addr_pi[0] = {addr_bits{1'bx}};

	if (GW_N == 1'b0 || (GW_N == 1'b1 && BW_N == 1'b0 && (WE_N[0] == 1'b0 || WE_N[1] == 1'b0 ))) begin	// if-00
		Write_N = 1'b0;
	end 	// end-00 
	else begin	// if-000
		Write_N = 1'b1;
	end	// end-000
	  
	if (ZZ == 1'b0) begin 
	// Begin Read or Write
	if ((CS1_N == 1'b0) && (CS2 == 1'b1) && (CS2_N == 1'b0)) begin	// if-01
		if (ADSP_N == 1'b0 || (ADSP_N == 1'b1 && ADSC_N == 1'b0 && Write_N == 1'b1)) begin	// if-02
			// begin read
			// $display("$m : at time %t : comand = begin read !!",$time); 
			Command_pi[0] = 3'b001;
			Addr_pi[0] = A;
			Init_addr = A;
			$display("$m : at time %t : BR-addr = %b",$time, Addr_pi[0]); 
		end	// end-02
		else if (ADSP_N == 1'b1 && ADSC_N == 1'b0 && Write_N == 1'b0 ) begin	// if-03
			// begin write
			// $display("$m : at time %t : comand = begin write !!",$time); 
			Command_pi[0] = 3'b010;
			Addr_pi[0] = A;  
			Init_addr = A;
			$display("$m : at time %t : BW-addr = %b",$time, Addr_pi[0]); 
		end	// end-03
	end	// end-01

	// Continue Read or Write 
	else if (((ADSP_N == 1'b1 && ADSC_N == 1'b1) || (CS1_N == 1'b1 && ADSC_N == 1'b1)) && ADV_N == 1'b0) begin	// if-04

		if (Command_pi[1] !== 3'b111) begin	// if-040
			if (Write_N == 1'b1) begin	// if-05
				// continue read
				// $display("$m : at time %t : comand = continue read !!",$time); 
				Command_pi[0] = 3'b011;
				AddrCnt;
				$display("$m : at time %t : CR-addr = %b",$time, Addr_pi[0]); 
			end 	// end-05
			else if (Write_N == 1'b0) begin	// if-06
				// continue write
				// $display("$m : at time %t : comand = continue write !!",$time); 
				Command_pi[0] = 3'b100;  
				AddrCnt;
				$display("$m : at time %t : CW-addr = %b",$time, Addr_pi[0]); 
			end	// end-06
		end 	// end-040	
	end	// end-04

	// Suspend Read or Write
	else if (((ADSP_N == 1'b1 && ADSC_N == 1'b1) || (CS1_N == 1'b1 && ADSC_N == 1'b1)) && ADV_N == 1'b1) begin 	// if-07
		if (Command_pi[1] !== 3'b111) begin	// if-070
			if (Write_N == 1'b1) begin 	// if-08
				// suspend read
				// $display("$m : at time %t : comand = suspend read !!",$time); 
				Command_pi[0] = 3'b101;
				Addr_pi[0] = Addr_pi[1];  
				$display("$m : at time %t : SR-addr = %b",$time, Addr_pi[0]); 
			end	// end-08
			if (Write_N == 1'b0) begin	// if-09
				// suspend write
				// $display("$m : at time %t : comand = suspend write !!",$time); 
				Command_pi[0] = 3'b110;  
				Addr_pi[0] = Addr_pi[1];  
				$display("$m : at time %t : SW-addr = %b",$time, Addr_pi[0]); 
			end 	// end-09
		end	// end-070
	end	// end-07

	if (Command_pi[0] === 3'b111) begin
		// $display("$m : at time %t : Not selected!!", $time);
	end	
	end	

 	// Read Operation
	if (Command_pi[0] === 3'b111) begin
		Out_buf <= #`tHZC {data_bits{1'bz}};
	end
	else if (Command_pi[1] === 3'b001 || Command_pi[1] === 3'b011 || Command_pi[1] === 3'b101) begin	// if-10
		Addr_reg = Addr_pi[1];
		Out_reg = SMEM[Addr_reg];
		$display("$m : at time %t : read : address = %h, data = %h!!", $time, Addr_reg, Out_reg); 
		Out_buf <= #`tCD Out_reg;
	end	// end-11
	if (Command_pi[2] === 3'b001 || Command_pi[2] === 3'b011 || Command_pi[2] === 3'b101) begin	// if-10
		Out_buf <= #`tOH {data_bits{1'bz}};
	end

	// Write Operation
	if (Command_pi[0] === 3'b010 || Command_pi[0] === 3'b100 || Command_pi[0] === 3'b110) begin	// if-11
		Addr_reg = Addr_pi[0];
		Data_tm	= SMEM[Addr_reg];
		if(GW_N == 1'b0) begin 	// if-12
			In_reg = DQ;
		end	// end-12
		else if (BW_N == 1'b0) begin	// if-13
			if (WE_N[0] == 1'b0) begin 	// if-14
				Data_tm[data_bits/2 - 1 : 0] = DQ[data_bits/2 - 1 : 0];
			end 	// end-14

			if (WE_N[1] == 1'b0) begin 	// if-17
				Data_tm[data_bits - 1 : data_bits/2] = DQ[data_bits - 1 : data_bits/2];
			end 	// end-17

			In_reg = Data_tm;
		end	// end-13
	 		
		$display("$m : at time %t : write : address = %h, data = %h", $time, Addr_reg, In_reg); 
		SMEM[Addr_reg] = In_reg;
	  
	end	// end-11
	end	// always_end-00	

	task AddrCnt;
		reg	[addr_bits - 1 : 0]	tmp1, 	tmp2;
	begin
		tmp1 = Addr_pi[1] % 4;
		tmp2 = Addr_pi[1] - tmp1;
		if (LBO_N == 1'b0) begin
			Addr_pi[0] = (tmp1 + 1) % 4;
			Addr_pi[0] = Addr_pi[0] + tmp2;
		end
		else if (LBO_N == 1'b1) begin
			if (Init_addr % 2 == 0) begin 
				Addr_pi[0] = (tmp1 + 1) % 4;
				Addr_pi[0] = Addr_pi[0] + tmp2;
			end
			else begin
				Addr_pi[0] = (tmp1 - 1) % 4;
				Addr_pi[0] = Addr_pi[0] + tmp2;
			end
		end
	end
	endtask

	// Timing Check
	specify
		specparam 	tCYC_p	=	`tCYC,	// cycle time
			 	tCH_p	=	`tCH,	// clock high time 
			 	tCL_p	=	`tCL,	// clock high time 
				tAS_p	=	`tAS,	// address setup to clock high 
				tSS_p	=	`tSS,	// address status setup to clock high
				tDS_p	=	`tDS,	// data setup to clock high
				tWS_p	=	`tWS,	// write setup to clock high
				tADVS_p	=	`tADVS,	// address advance setup to clock high
				tCSS_p	=	`tCSS,	// chip select setup to clock high
				tAH_p	=	`tAH,	// address hold from clock high
				tSH_p	=	`tSH,	// address status hold from clock high
				tDH_p	=	`tDH,	// data hold from clock high
				tWH_p	=	`tWH,	// write hold from clock high
				tADVH_p	=	`tADVH,	// address advance hold from clock high
				tCSH_p	=	`tCSH;	// chip select hold from clock high
		$period		(posedge CLK,	tCYC_p);		
		$period		(negedge CLK,	tCYC_p);		
		$width		(posedge CLK,	tCH_p);		
		$width		(negedge CLK,	tCL_p);		
		$setuphold	(posedge CLK,	A,		tAS_p,	tAH_p); 
		$setuphold	(posedge CLK,	ADSP_N,		tSS_p,	tSH_p); 
		$setuphold	(posedge CLK,	ADSC_N,		tSS_p,	tSH_p); 
		$setuphold	(posedge CLK,	CS1_N,		tCSS_p,	tCSH_p); 
		$setuphold	(posedge CLK,	CS2,		tCSS_p,	tCSH_p); 
		$setuphold	(posedge CLK,	CS2_N,		tCSS_p,	tCSH_p); 
		$setuphold	(posedge CLK,	GW_N,		tWS_p,	tWH_p); 
		$setuphold	(posedge CLK,	BW_N,		tWS_p,	tWH_p); 
		$setuphold	(posedge CLK,	WE_N[0],	tWS_p,	tWH_p); 
		$setuphold	(posedge CLK,	WE_N[1],	tWS_p,	tWH_p); 
	endspecify

endmodule
