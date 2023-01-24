
//ALU control in ALUdec.v already
module Control(
	input [31:0] inst0, inst1, alu_out, inst,
	input BrEq, BrLT, reset,
	output reg PCSel, RegWEn, BrUn, noopSel,
	output reg [1:0] signext_sel, ASel, BSel,
	output reg [2:0] ImmSel,
	output reg [2:0] WBSel,
	output reg [3:0] MemRW,
	output reg store_data_hazard, 
	output reg [1:0] branch_hazard,
	output reg csr_hazard
);

wire [6:0] opcode = inst[6:0];
wire [2:0] funct3 = inst[14:12];
wire [6:0] funct7 = inst[31:25];

wire [6:0] opcode0 = inst0[6:0];
wire [4:0] rd0 = inst0[11:7];
wire [2:0] funct30 = inst0[14:12];
wire [4:0] rs1_next = inst0[19:15];
wire [4:0] rs2_next = inst0[24:20];

wire [6:0] opcode1 = inst1[6:0];
wire [4:0] rd1 = inst1[11:7];
wire [2:0] funct31 = inst1[14:12];


always @* begin
	if(reset) begin
		ImmSel <= 5;
		ASel <= 2'b00;
		BSel <= 2'b00;
		PCSel <= 1'b0;
		MemRW <= 4'd0;
		noopSel <= 1'b0;
		store_data_hazard <= 1'b0;
		branch_hazard <= 0;
	end
	case(opcode0)
		7'b0110011: begin // R-type
			ImmSel <= 0;// by default, doesn't matter
			PCSel <= 1'b0;
			MemRW <= 4'd0;//read by default, doesn't matter
			noopSel <= 1'b0;
			store_data_hazard <= 1'b0;
			case(opcode1)
				7'b0110011,7'b0010011,7'b0110111,7'b0010111,7'b0000011,7'b1101111,7'b1100111: begin//R,I,LUI,AUIPC,L,JAL,JALR
				  	if(rs1_next == rd1 && rs2_next != rd1 && rd1 != 0) begin
						ASel <= 2;
						BSel <= 1;
					end
					else if(rs2_next == rd1 && rs1_next != rd1 && rd1 != 0) begin
						ASel <= 2'b00;
						BSel <= 2;
					end
					else if(rs1_next == rd1 && rs2_next == rd1 && rd1 != 0) begin
						ASel <= 2;
						BSel <= 2;
					end
					else begin
						ASel <= 2'b00;
						BSel <= 1;
					end
				end
				default begin
						ASel <= 2'b00;
						BSel <= 1;
				end
			endcase
		end
		7'b0010011: begin // I-type
			ImmSel <= 0;
			PCSel <= 1'b0;
			MemRW <= 4'd0; 
			noopSel <= 1'b0;
			store_data_hazard <= 1'b0;
			case(opcode1)
				7'b0110011,7'b0010011,7'b0110111,7'b0010111,7'b0000011,7'b1101111,7'b1100111: begin//R,I,LUI,AUIPC,L,JAL,JALR
				  	if(rs1_next == rd1 && rd1 != 0) begin
						ASel <= 2;
						BSel <= 2'b00;
					end
					else begin
						ASel <= 2'b00;
						BSel <= 2'b00;
					end
				end
				default begin
						ASel <= 2'b00;
						BSel <= 2'b00;
				end
			endcase
		end
		7'b0000011: begin // Load
			ImmSel <= 0;
			ASel <= 2'b00;
			BSel <= 2'b00;
			PCSel <= 1'b0;
			MemRW <= 4'd0; 
			noopSel <= 1'b0;
			store_data_hazard <= 1'b0;
			case(opcode1)
				7'b0110011,7'b0010011,7'b0110111,7'b0010111,7'b0000011,7'b1101111,7'b1100111: begin//R,I,LUI,AUIPC,L,JAL,JALR
				  	if(rs1_next == rd1 && rd1 != 0) begin
						ASel <= 2;
						BSel <= 2'b00;
					end
					else begin
						ASel <= 2'b00;
						BSel <= 2'b00;
					end
				end
				default begin
						ASel <= 2'b00;
						BSel <= 2'b00;
				end
			endcase
		end
		7'b1100111: begin // JALR
			ImmSel <= 5;
			PCSel <= 1;
			MemRW <= 4'd0;
			noopSel <= 1;
			store_data_hazard <= 1'b0;
			case(opcode1)
				7'b0110011,7'b0010011,7'b0110111,7'b0010111,7'b0000011,7'b1101111,7'b1100111: begin//R,I,LUI,AUIPC,L,JAL,JALR
				  	if(rs1_next == rd1 && rd1 != 0) begin
						ASel <= 2;
						BSel <= 2'b00;
					end
					else begin
						ASel <= 2'b00;
						BSel <= 2'b00;
					end
				end
				default begin
						ASel <= 2'b00;
						BSel <= 2'b00;
				end
			endcase
		end
		7'b0100011: begin //S-type
			ImmSel <= 1;
			case(opcode1)
				7'b0110011,7'b0010011,7'b0110111,7'b0010111,7'b0000011,7'b1101111,7'b1100111: begin//R,I,LUI,AUIPC,L,JAL,JALR
				  	if(rs1_next == rd1 && rs2_next != rd1 && rd1 != 0) begin
						ASel <= 2;
						BSel <= 2'b00;
						store_data_hazard <= 1'b0;
					end
					else if(rs2_next == rd1 && rs1_next != rd1 && rd1 != 0) begin
						ASel <= 2'b00;
						BSel <= 2'b00;
						store_data_hazard <= 1;
					end
					else if(rs1_next == rd1 && rs2_next == rd1 && rd1 != 0) begin
						ASel <= 2;
						BSel <= 2;
					end
					else begin
						ASel <= 2'b00;
						BSel <= 2'b00;
						store_data_hazard <= 1'b0;
					end
				end
				default begin
						ASel <= 2'b00;
						BSel <= 2'b00;
						store_data_hazard <= 1'b0;
				end
			endcase
			PCSel <= 1'b0;
			noopSel <= 1'b0;
			case(funct30)
			3'b000: begin
				case(alu_out%4)
				0: MemRW <= 4'b0001;
				1: MemRW <= 4'b0010;
				2: MemRW <= 4'b0100;
				3: MemRW <= 4'b1000;
				endcase
			end
			3'b001: begin
				case(alu_out%4)
				0: MemRW <= 4'b0011;
				1: MemRW <= 4'b0110;
				2,3: MemRW <= 4'b1100;
				endcase
			end
			default: MemRW <= 4'b1111;
			endcase
		end
		7'b1100011: begin //B-type
			case(opcode1)
				7'b0110011,7'b0010011,7'b0110111,7'b0010111,7'b0000011,7'b1101111,7'b1100111: begin//R,I,LUI,AUIPC,L,JAL,JALR
					if(rs1_next == rd1 && rs2_next != rd1 && rd1 != 0) branch_hazard <= 1;
					else if(rs2_next == rd1 && rs1_next != rd1 && rd1 != 0) branch_hazard <= 2;
					else if(rs1_next == rd1 && rs2_next == rd1 && rd1 != 0) branch_hazard <= 3;
					else branch_hazard <= 0;
				end
				default begin
						branch_hazard <= 0;
				end
			endcase
			store_data_hazard <= 1'b0;
			case(funct30)
			3'b000: begin
				BrUn <= 0;
				if(BrEq) begin	
					ImmSel <= 2;
					ASel <= 1;
					BSel <= 2'b00;
					PCSel <= 1;
					MemRW <= 4'd0;
					noopSel <= 1;
				end
				else begin
					ImmSel <= 2;
					ASel <= 2'b00;
					BSel <= 2'b00;
					PCSel <= 1'b0;
					MemRW <= 4'd0;
					noopSel <= 1'b0;
				end
				
			end
			3'b001: begin
				BrUn <= 0;
				if(!BrEq) begin	
					ImmSel <= 2;
					ASel <= 1;
					BSel <= 2'b00;
					PCSel <= 1;
					MemRW <= 4'd0;
					noopSel <= 1;
				end
				else begin
					ImmSel <= 2;
					ASel <= 2'b00;
					BSel <= 2'b00;
					PCSel <= 1'b0;
					MemRW <= 4'd0;
					noopSel <= 1'b0;
				end
			end
			3'b100: begin
				BrUn <= 0;
				if(BrLT) begin	
					ImmSel <= 2;
					ASel <= 1;
					BSel <= 2'b00;
					PCSel <= 1;
					MemRW <= 4'd0;
					noopSel <= 1;
				end
				else begin
					ImmSel <= 2;
					ASel <= 2'b00;
					BSel <= 2'b00;
					PCSel <= 1'b0;
					MemRW <= 4'd0;
					noopSel <= 1'b0;
				end
			end
			3'b110: begin
				BrUn <= 1;
				if(BrLT) begin	
					ImmSel <= 2;
					ASel <= 1;
					BSel <= 2'b00;
					PCSel <= 1;
					MemRW <= 4'd0;
					noopSel <= 1;
				end
				else begin
					ImmSel <= 2;
					ASel <= 2'b00;
					BSel <= 2'b00;
					PCSel <= 1'b0;
					MemRW <= 4'd0;
					noopSel <= 1'b0;
				end
			end
			3'b101: begin
				BrUn <= 0;
				if(!BrLT) begin	
					ImmSel <= 2;
					ASel <= 1;
					BSel <= 2'b00;
					PCSel <= 1;
					MemRW <= 4'd0;
					noopSel <= 1;
				end
				else begin
					ImmSel <= 2;
					ASel <= 1;
					BSel <= 2'b00;
					PCSel <= 1'b0;
					MemRW <= 4'd0;
					noopSel <= 1'b0;
				end
			end
			3'b111: begin
				BrUn <= 1;
				if(!BrLT) begin	
					ImmSel <= 2;
					ASel <= 1;
					BSel <= 2'b00;
					PCSel <= 1;
					MemRW <= 4'd0;
					noopSel <= 1;
				end
				else begin
					ImmSel <= 2;
					ASel <= 1;
					BSel <= 2'b00;
					PCSel <= 1'b0;
					MemRW <= 4'd0;
					noopSel <= 1'b0;
				end
			end
			endcase
		end
		7'b1101111: begin //JAL
			ImmSel <= 3;
			PCSel <= 1;
			MemRW <= 4'd0;
			noopSel <= 1;
			ASel <= 1;
			BSel <= 2'b00;
			store_data_hazard <= 1'b0;
		end
		7'b0110111: begin //LUI
			ImmSel <= 4;
			PCSel <= 1'b0;
			MemRW <= 4'd0;
			noopSel <= 1'b0;
			ASel <= 2'b00;
			BSel <= 2'b00;
			store_data_hazard <= 1'b0;
		end
		7'b0010111: begin //AUIPC
			ImmSel <= 4;
			PCSel <= 1'b0;
			MemRW <= 4'd0;
			noopSel <= 1'b0;
			ASel <= 1;
			BSel <= 2'b00;
			store_data_hazard <= 1'b0;
		end
		7'b1110011: begin //CSR
			if(funct30 == 3'b001) begin
				case(opcode1)
					7'b0110011,7'b0010011,7'b0110111,7'b0010111,7'b0000011,7'b1101111,7'b1100111: begin//R,I,LUI,AUIPC,L,JAL,JALR
				  		if(rs1_next == rd1 && rd1 != 0) begin
							csr_hazard <= 1;
						end
						else begin
						csr_hazard <= 0;
						end
					end
					default begin
						csr_hazard <= 0;
					end
				endcase
			end
		end
		default begin //NOOP
			ImmSel <= 0;
			ASel <= 2'b00;
			BSel <= 1;
			PCSel <= 1'b0;
			MemRW <= 4'd0;
			noopSel <= 1'b0;
			store_data_hazard <= 1'b0;
		end
	endcase
end

always @* begin
	if(reset) begin	
		WBSel <= 2'b00;
		RegWEn <= 1'b0;
		signext_sel <= 0;
	end
	case(opcode1)
		7'b0000011: begin // Load
			WBSel <= 2'b00;
			RegWEn <= 1;
			case(funct31)
				3'b000,3'b100: signext_sel <= 2;
				3'b001,3'b101: signext_sel <= 1;
				default: signext_sel <= 0;
			endcase
		end
		7'b1100111: begin // JALR
			WBSel <= 2;
			RegWEn <= 1;
			signext_sel <= 0;
		end
		7'b0100011: begin //S-type
			WBSel <= 2'b00;
			RegWEn <= 1'b0;
			signext_sel <= 0;
		end
		7'b1100011: begin //B-type
			WBSel <= 2'b00;
			RegWEn <= 1'b0;
			signext_sel <= 0;
		end
		7'b1101111: begin //JAL
			WBSel <= 2;
			RegWEn <= 1;
			signext_sel <= 0;
		end
		default begin //NOOP,LUI,AUIPC,R,I
			WBSel <= 1;
			RegWEn <= 1;
			signext_sel <= 0;
		end
	endcase
end


endmodule
