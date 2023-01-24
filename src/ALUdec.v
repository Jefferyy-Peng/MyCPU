// Module: ALUdecoder
// Desc:   Sets the ALU operation
// Inputs: opcode: the top 6 bits of the instruction
//         funct: the funct, in the case of r-type instructions
//         add_rshift_type: selects whether an ADD vs SUB, or an SRA vs SRL
// Outputs: ALUop: Selects the ALU's operation
//

`include "Opcode.vh"
`include "ALUop.vh"

module ALUdec(
  input [6:0]       opcode,
  input [2:0]       funct,
  input             add_rshift_type,
  output reg [3:0]  ALUop
);

always @* begin
case(opcode)
	`OPC_NOOP:begin
		ALUop = `ALU_XXX;
	end
	`OPC_LUI:begin
		ALUop = `ALU_COPY_B;
	end
	`OPC_AUIPC, `OPC_BRANCH, `OPC_LOAD, `OPC_STORE, `OPC_JAL, `OPC_JALR:begin //add JAL,JALR(Peter)
		ALUop = `ALU_ADD;
	end
	`OPC_ARI_RTYPE:begin
		case(funct)
			`FNC_ADD_SUB:begin
				if(add_rshift_type) ALUop = `ALU_SUB;
				else ALUop = `ALU_ADD;
			end
			`FNC_SLL:begin
				ALUop = `ALU_SLL;
			end
			`FNC_SLT:begin
				ALUop = `ALU_SLT;
			end
			`FNC_SLTU:begin
				ALUop = `ALU_SLTU;
			end
			`FNC_XOR:begin
				ALUop = `ALU_XOR;
			end
			`FNC_OR:begin
				ALUop = `ALU_OR;
			end
			`FNC_AND:begin
				ALUop = `ALU_AND;
			end
			`FNC_SRL_SRA:begin	
				if(add_rshift_type) ALUop = `ALU_SRA;
				else ALUop = `ALU_SRL;
			end
		endcase
	end
	`OPC_ARI_ITYPE: begin
		case(funct)
			`FNC_ADD_SUB:begin
				ALUop = `ALU_ADD;
			end
			`FNC_SLL:begin
				ALUop = `ALU_SLL;
			end
			`FNC_SLT:begin
				ALUop = `ALU_SLT;
			end
			`FNC_SLTU:begin
				ALUop = `ALU_SLTU;
			end
			`FNC_XOR:begin
				ALUop = `ALU_XOR;
			end
			`FNC_OR:begin
				ALUop = `ALU_OR;
			end
			`FNC_AND:begin
				ALUop = `ALU_AND;
			end
			`FNC_SRL_SRA:begin	
				if(add_rshift_type) ALUop = `ALU_SRA;
				else ALUop = `ALU_SRL;
			end
		endcase
	end
	default: ALUop = `ALU_XXX;
endcase
end
endmodule
