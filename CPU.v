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
    inout [15:1] data_ram,
    output [5:0] address_to_rom,
    output enable_to_rom,
    output write_enable_to_ram,
    output [5:0] address_to_ram,
    output read_enable_to_ram,
    output enable_ram_read
    );
	 
	 


endmodule
