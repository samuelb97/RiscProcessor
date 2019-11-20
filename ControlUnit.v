`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:51:33 12/05/2016 
// Design Name: 
// Module Name:    ControlUnit 
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
module ControlUnit(
	input clk,
	input reset,
	input [5:0] PC_Off,
	input [15:0] data_from_rom,
	output[2:0] State,
	output[5:0] address_to_rom,
	output[3:0] Rd,
	output[3:0] Rs,
	output[3:0] Rt,
	output[3:0] OpCode,
	output enable_to_rom,
	output enable_ram_read
    );


reg [2:0] Statetmp;
reg [3:0] Rdtmp,Rstmp,Rttmp,tmp_OpCode;
reg [5:0] PC; 
reg enable_ram_read_tmp;
reg enable_to_rom_tmp;
reg [2:0] DP_State;       

always @ (posedge clk)
	begin
		if(reset)
			begin
				Statetmp<=3'b000;
				DP_State<=3'b000;
				PC<=5'd0;
				enable_ram_read_tmp=1'b0;
				
			end
		else
			begin
			case(Statetmp)
				3'b000: //RESET
					begin
						DP_State<=3'b000;
						Statetmp<=3'b010;//3'b001;
						enable_to_rom_tmp<=1'b1;
					end
				3'b001: //DECODE
					begin
						/*if(data_from_rom==16'hFF00) // Terminate program if instruction is EOE
							begin
								DP_State<=3'b101;
								Statetmp<=3'b101;
							end
						else
							begin
								DP_State<=3'b001;
								Statetmp<=3'b010;
								tmp_OpCode<=data_from_rom[15:12];
								Rdtmp<=data_from_rom[11:8];
								Rstmp<=data_from_rom[7:4];
								Rttmp<=data_from_rom[3:0];
							end*/
					end
				3'b010: //EXECUTE
					begin
					
						//begin
						if(data_from_rom==16'hFF00) // Terminate program if instruction is EOE
							begin
								DP_State<=3'b101;
								Statetmp<=3'b101;
							end
						else
							begin
								DP_State<=3'b010;//3'b001;
								Statetmp<=3'b100;//3'b010;
								tmp_OpCode<=data_from_rom[15:12];
								Rdtmp<=data_from_rom[11:8];
								Rstmp<=data_from_rom[7:4];
								Rttmp<=data_from_rom[3:0];
							end
					//end
					
						enable_to_rom_tmp<=1'b0;
						//DP_State<=3'b010;
						/*case(tmp_OpCode)
							4'b1001: //LW
								begin
									Statetmp<=3'b011;
								end
							4'b1010: //SW
								begin
									Statetmp<=3'b011;
								end	*/
							//default:
							//	begin
							//		Statetmp<=3'b100;
							//	end
						//endcase
					end 
				/*3'b011: //RAM
					begin
						DP_State<=3'b011;
						case(tmp_OpCode)
							4'b1001: //LW
								begin
									Statetmp<=3'b100;
								end
							4'b1010: //SW
								begin
									Statetmp<=3'b100;
								end
							default:
								begin
									Statetmp<=3'b100;
								end
						endcase
					end
		*/				
				3'b100: //STORE
					begin
						DP_State<=3'b100;
						Statetmp<=3'b010;//3'b001;
						enable_to_rom_tmp<=1'b1;
						case(tmp_OpCode)
							4'b1111: //JR
								PC<=PC_Off;
							default:
								PC<=PC+PC_Off;
						endcase
					end
				3'b101: //FINISHED PROGRAM
					begin
						DP_State<=3'b101;
						enable_ram_read_tmp=1'b1;
					end
				default:
					begin
						DP_State<=3'b101;
						enable_ram_read_tmp=1'b1;
					end
				endcase 
			end
	end

		assign OpCode = tmp_OpCode;
		assign Rd = Rdtmp;
		assign Rs = Rstmp;
		assign Rt = Rttmp;
		assign State = DP_State;
		assign address_to_rom = PC;
		assign enable_to_rom = enable_to_rom_tmp;
		assign enable_ram_read = enable_ram_read_tmp;
		

endmodule
