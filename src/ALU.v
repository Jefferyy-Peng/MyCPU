// Module: ALU.v
// Desc:   32-bit ALU for the RISC-V Processor
// Inputs: 
//    A: 32-bit value
//    B: 32-bit value
//    ALUop: Selects the ALU's operation 
// 						
// Outputs:
//    Out: The chosen function mapped to A and B.

`include "Opcode.vh"
`include "ALUop.vh"

module ALU(
    input [31:0] A,B,
    input [3:0] ALUop,
    output reg [31:0] Out
);

    // Implement your ALU here, then delete this comment
always@* begin
case (ALUop)
	`ALU_ADD:begin
		Out = $signed(A) + $signed(B);//should be signed?
	end
	`ALU_SUB:begin
		Out = A - B;//should be signed?
	end
	`ALU_AND:begin
		Out = B & A;
	end
	`ALU_OR:begin
		Out = B | A;
	end
	`ALU_XOR:begin
		Out = B ^ A;
	end
	`ALU_SLT:begin
		if($signed(A) < $signed(B))
			Out = 1;
		else
			Out = 0;
	end
	`ALU_SLTU:begin
		if(A < B)
			Out = 1;
		else
			Out = 0;
	end
	`ALU_SLL:begin
		Out = A << B[4:0];
	end
	`ALU_SRA:begin
		Out = $signed(A) >>> B[4:0];
	end
	`ALU_SRL:begin
		Out = A >> B[4:0];
	end
	`ALU_COPY_B:begin
		Out = B;
	end
	`ALU_XXX:begin
		Out = 32'b0;
	end
	endcase
end
endmodule
