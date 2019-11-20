`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:57 12/05/2016 
// Design Name: 
// Module Name:    DataPath 
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
module DataPath(
	input clk,
	input [3:0] OpCode,
	input [3:0] Rd,
	input [3:0] Rs,
	input [3:0] Rt,
	input [2:0] State,
	input [5:0] PC,
	output [5:0] PC_Off,
	output write_enable_to_ram,
	output read_enable_to_ram,
	inout [15:0] data_ram,
	output [5:0] address_to_ram
    );
	 
//16 general purpose registers
reg [15:0] R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15;

//Temp regs to be assigned later and update values for CU operation  
reg [15:0] Rdtmp,Rstmp,Rttmp; 
reg [7:0] immediate; // immediate offset => Branch/Jmp
reg [5:0] PC_Offtmp,address_to_ram_tmp;
reg read_enable_to_ram_tmp,write_enable_to_ram_tmp;
reg [15:0] data_to_ram; //result 


// Register constants to select appropriate destination,source and target in switch statement. 
parameter Reg0=4'd0,
			 Reg1=4'd1,
			 Reg2=4'd2,
			 Reg3=4'd3,
			 Reg4=4'd4,
			 Reg5=4'd5,
			 Reg6=4'd6,
			 Reg7=4'd7,
			 Reg8=4'd8,
			 Reg9=4'd9,
			 Reg10=4'd10,
			 Reg11=4'd11,
			 Reg12=4'd12,
			 Reg13=4'd13,
			 Reg14=14'd4,
			 Reg15=4'd15;

always @ (negedge clk)
	begin
		case(State) // check which state were in 
			3'b000: //Reset
				begin
					//Set offset to zero
					PC_Offtmp<=6'd0;
				end
				
		//	3'b001://Decode
		//		begin
					/*immediate<={Rs,Rt}; //concatenate because 8 bit number to be immediately loaded 
					case(OpCode)
						4'b1011: //BIZ
							begin
								case(Rd) //Decode Destination Reg if BIZ
									   Reg0:
											Rstmp<=R0;
										Reg1:
											Rstmp<=R1;
										Reg2:
											Rstmp<=R2;
										Reg3:
											Rstmp<=R3;
										Reg4:
											Rstmp<=R4;
										Reg5:
											Rstmp<=R5;
										Reg6:
											Rstmp<=R6;
										Reg7:
											Rstmp<=R7;
										Reg8:
											Rstmp<=R8;
										Reg9:
											Rstmp<=R9;
										Reg10:
											Rstmp<=R10;
										Reg11:
											Rstmp<=R11;
										Reg12:
											Rstmp<=R12;
										Reg13:
											Rstmp<=R13;
										Reg14:
											Rstmp<=R14;
										Reg15:
											Rstmp<=R15;
								endcase
							end
						4'b1100: //BNZ
							begin
								case(Rd) //Decode Destination Reg if BNZ
										Reg0:
											Rstmp<=R0;
										Reg1:
											Rstmp<=R1;
										Reg2:
											Rstmp<=R2;
										Reg3:
											Rstmp<=R3;
										Reg4:
											Rstmp<=R4;
										Reg5:
											Rstmp<=R5;
										Reg6:
											Rstmp<=R6;
										Reg7:
											Rstmp<=R7;
										Reg8:
											Rstmp<=R8;
										Reg9:
											Rstmp<=R9;
										Reg10:
											Rstmp<=R10;
										Reg11:
											Rstmp<=R11;
										Reg12:
											Rstmp<=R12;
										Reg13:
											Rstmp<=R13;
										Reg14:
											Rstmp<=R14;
										Reg15:
											Rstmp<=R15;
									endcase
								end
						default:
							begin
								case(Rs) // Decode Source Reg
									Reg0:
										Rstmp<=R0;
									Reg1:
										Rstmp<=R1;
									Reg2:
										Rstmp<=R2;
									Reg3:
										Rstmp<=R3;
									Reg4:
										Rstmp<=R4;
									Reg5:
										Rstmp<=R5;
									Reg6:
										Rstmp<=R6;
									Reg7:
										Rstmp<=R7;
									Reg8:
										Rstmp<=R8;
									Reg9:
										Rstmp<=R9;
									Reg10:
										Rstmp<=R10;
									Reg11:
										Rstmp<=R11;
									Reg12:
										Rstmp<=R12;
									Reg13:
										Rstmp<=R13;
									Reg14:
										Rstmp<=R14;
									Reg15:
										Rstmp<=R15;
								endcase
								
								case(Rt) //Decode Target Reg
									Reg0:
										Rttmp<=R0;
									Reg1:
										Rttmp<=R1;
									Reg2:
										Rttmp<=R2;
									Reg3:
										Rttmp<=R3;
									Reg4:
										Rttmp<=R4;
									Reg5:
										Rttmp<=R5;
									Reg6:
										Rttmp<=R6;
									Reg7:
										Rttmp<=R7;
									Reg8:
										Rttmp<=R8;
									Reg9:
										Rttmp<=R9;
									Reg10:
										Rttmp<=R10;
									Reg11:
										Rttmp<=R11;
									Reg12:
										Rttmp<=R12;
									Reg13:
										Rttmp<=R13;
									Reg14:
										Rttmp<=R14;
									Reg15:
										Rttmp<=R15;
								endcase
							end
					endcase*/
				//end
				
			3'b010: //Execute
				begin
				
				
				immediate={Rs,Rt}; //concatenate because 8 bit number to be immediately loaded 
					case(OpCode)
						4'b1011: //BIZ
							begin
								case(Rd) //Decode Destination Reg if BIZ
									   Reg0:
											Rstmp=R0;
										Reg1:
											Rstmp=R1;
										Reg2:
											Rstmp=R2;
										Reg3:
											Rstmp=R3;
										Reg4:
											Rstmp=R4;
										Reg5:
											Rstmp=R5;
										Reg6:
											Rstmp=R6;
										Reg7:
											Rstmp=R7;
										Reg8:
											Rstmp=R8;
										Reg9:
											Rstmp=R9;
										Reg10:
											Rstmp=R10;
										Reg11:
											Rstmp=R11;
										Reg12:
											Rstmp=R12;
										Reg13:
											Rstmp=R13;
										Reg14:
											Rstmp=R14;
										Reg15:
											Rstmp=R15;
								endcase
							end
						4'b1100: //BNZ
							begin
								case(Rd) //Decode Destination Reg if BNZ
										Reg0:
											Rstmp=R0;
										Reg1:
											Rstmp=R1;
										Reg2:
											Rstmp=R2;
										Reg3:
											Rstmp=R3;
										Reg4:
											Rstmp=R4;
										Reg5:
											Rstmp=R5;
										Reg6:
											Rstmp=R6;
										Reg7:
											Rstmp=R7;
										Reg8:
											Rstmp=R8;
										Reg9:
											Rstmp=R9;
										Reg10:
											Rstmp=R10;
										Reg11:
											Rstmp=R11;
										Reg12:
											Rstmp=R12;
										Reg13:
											Rstmp=R13;
										Reg14:
											Rstmp=R14;
										Reg15:
											Rstmp=R15;
									endcase
								end
						default:
							begin
								case(Rs) // Decode Source Reg
									Reg0:
										Rstmp=R0;
									Reg1:
										Rstmp=R1;
									Reg2:
										Rstmp=R2;
									Reg3:
										Rstmp=R3;
									Reg4:
										Rstmp=R4;
									Reg5:
										Rstmp=R5;
									Reg6:
										Rstmp=R6;
									Reg7:
										Rstmp=R7;
									Reg8:
										Rstmp=R8;
									Reg9:
										Rstmp=R9;
									Reg10:
										Rstmp=R10;
									Reg11:
										Rstmp=R11;
									Reg12:
										Rstmp=R12;
									Reg13:
										Rstmp=R13;
									Reg14:
										Rstmp=R14;
									Reg15:
										Rstmp=R15;
								endcase
								
								case(Rt) //Decode Target Reg
									Reg0:
										Rttmp=R0;
									Reg1:
										Rttmp=R1;
									Reg2:
										Rttmp=R2;
									Reg3:
										Rttmp=R3;
									Reg4:
										Rttmp=R4;
									Reg5:
										Rttmp=R5;
									Reg6:
										Rttmp=R6;
									Reg7:
										Rttmp=R7;
									Reg8:
										Rttmp=R8;
									Reg9:
										Rttmp=R9;
									Reg10:
										Rttmp=R10;
									Reg11:
										Rttmp=R11;
									Reg12:
										Rttmp=R12;
									Reg13:
										Rttmp=R13;
									Reg14:
										Rttmp=R14;
									Reg15:
										Rttmp=R15;
								endcase
							end
					endcase
				
					case(OpCode)
						4'b0000: //ADD
							begin
								Rdtmp=Rstmp+Rttmp;
								PC_Offtmp<=6'd1;
							end
						4'b0001: //SUB
							begin
								Rdtmp=Rstmp-Rttmp;
								PC_Offtmp<=6'd1;
							end
						4'b0010: //AND
							begin
								Rdtmp=Rstmp & Rttmp;
								PC_Offtmp<=6'd1;
							end
						4'b0011: // OR
							begin
								Rdtmp=Rstmp | Rttmp;
								PC_Offtmp<=6'd1;
							end
						4'b0100: //XOR
							begin
								Rdtmp=Rstmp ^ Rttmp;
								PC_Offtmp<=6'd1;
							end
						4'b0101: //NOT
							begin
								Rdtmp= ~Rstmp;
								PC_Offtmp<=6'd1;
							end
						4'b0110: //SLA Shift Left A
							begin
								Rdtmp=Rstmp<<1;
								PC_Offtmp<=6'd1;
							end
						4'b0111: //SRA Shift Right A 
							begin
								Rdtmp=Rstmp>>1;
								PC_Offtmp<=6'd1;
							end
						4'b1000: //LI
							begin
								Rdtmp=immediate;
								PC_Offtmp<=6'd1;
							end
						4'b1001: //LW
							begin
								address_to_ram_tmp<=Rstmp[5:0];
								read_enable_to_ram_tmp<=1'b1;
								PC_Offtmp<=6'd1;
							end
						4'b1010: //SW
							begin
								address_to_ram_tmp<=Rstmp[5:0];
								write_enable_to_ram_tmp=1'b1;
								PC_Offtmp<=6'd1;
								data_to_ram<=Rttmp;
							end
						4'b1011: //BIZ (Branch If Zero)
							begin
								if(Rstmp==16'd0)
									PC_Offtmp<=immediate[5:0];
								else
									PC_Offtmp<=6'd1;
							end
						4'b1100: //BNZ (Branch if Not Zero)
							begin
								if(Rstmp==16'd0)
									PC_Offtmp<=6'd1;
								else
									PC_Offtmp<=immediate[5:0]+6'd1;
							end
						4'b1101: //JAL Jump And Link 
							begin
								Rdtmp=PC+6'd1;
								PC_Offtmp<=immediate[5:0]+6'd1;
							end
						4'b1110: //JMP
							begin 
								PC_Offtmp<=immediate[5:0]+6'd1;
							end
						4'b1111: //JR Jump Return 
							begin
								PC_Offtmp<=Rstmp[5:0];
							end
					endcase
				end
		/*		
			3'b011: //RAM access
				begin
					case(OpCode)
						4'b1001: //LW
							begin
								Rdtmp<=data_ram;
								read_enable_to_ram_tmp<=1'b0;
							end
						4'b1010: //SW
							begin	
							end
						default:
							begin
							end
					endcase
				end
			*/
			3'b100: // Store 
				begin
					read_enable_to_ram_tmp<=1'b0;
					write_enable_to_ram_tmp=1'b0;
					case(OpCode)
					//Nothing needs to be done for any of these commands in the Store state
						4'b1010: //SW
							begin
							end
						4'b1011: //BIZ
							begin
							end
						4'b1100: //BNZ 
							begin
							end
						4'b1110: //JMP
							begin
							end
						4'b1111: //JR
							begin
							end
						4'b1001: //LW
							begin
								Rdtmp=data_ram;
								//read_enable_to_ram_tmp<=1'b0;
							end
						endcase
	
						//default:
							begin
								case(Rd)
									Reg0:
										R0<=Rdtmp;
									Reg1:
										R1<=Rdtmp;
									Reg2:
										R2<=Rdtmp;
									Reg3:
										R3<=Rdtmp;
									Reg4:
										R4<=Rdtmp;
									Reg5:
										R5<=Rdtmp;
									Reg6:
										R6<=Rdtmp;
									Reg7:
										R7<=Rdtmp;
									Reg8:
										R8<=Rdtmp;
									Reg9:
										R9<=Rdtmp;
									Reg10:
										R10<=Rdtmp;
									Reg11:
										R11<=Rdtmp;
									Reg12:
										R12<=Rdtmp;
									Reg13:
										R13<=Rdtmp;
									Reg14:
										R14<=Rdtmp;
									Reg15:
										R15<=Rdtmp;
								endcase		
							end
					//endcase
				end
			
			3'b101: // Finished
				begin
				end
			 
		endcase
		
	end
	
assign PC_Off=PC_Offtmp;

assign read_enable_to_ram=read_enable_to_ram_tmp;
assign write_enable_to_ram=write_enable_to_ram_tmp;
assign address_to_ram=address_to_ram_tmp;
assign data_ram = (write_enable_to_ram_tmp) ? data_to_ram : 16'bz; //if write signal is 1, assign data_to_ram to data_ram
assign data_ram = (read_enable_to_ram_tmp) ? data_to_ram : 16'bz;
//assign data_ram = data_to_ram;


endmodule

