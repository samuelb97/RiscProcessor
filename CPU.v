`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:03:38 11/19/2019 
// Design Name: 
// Module Name:    CPU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CPU(
    input [15:0] data_from_rom,
    input reset,
    input clk,
    inout [15:0] data_ram,
    output [5:0] address_to_rom,
    output enable_to_rom,
    output write_enable_to_ram,
    output [5:0] address_to_ram,
    output read_enable_to_ram,
    output enable_ram_read
    );
	 
wire [3:0] Rd;
wire [3:0]Rs;
wire [3:0]Rt;
wire [3:0] OpCode;
wire [5:0] PC_Off;
wire [5:0] PC;
wire [2:0] State;


ControlUnit CU(
		.clk(clk),
		.reset(reset),
		.PC_Off(PC_Off),
		.data_from_rom(data_from_rom),
		.State(State),
		.address_to_rom(PC),
		.Rd(Rd),
		.Rs(Rs),
		.Rt(Rt),
		.OpCode(OpCode),
		.enable_to_rom(enable_to_rom),
		.enable_ram_read(enable_ram_read)
		
);

DataPath DP(
		.clk(clk),
		.OpCode(OpCode),
		.Rd(Rd),
		.Rs(Rs),
		.Rt(Rt),
		.State(State),
		.PC(PC),
		.PC_Off(PC_Off),
		.write_enable_to_ram(write_enable_to_ram),
		.read_enable_to_ram(read_enable_to_ram),
		.data_ram(data_ram),
		.address_to_ram(address_to_ram)
);

assign address_to_rom=PC;


endmodule
