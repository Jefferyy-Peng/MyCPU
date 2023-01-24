//`include "/scratch/eecs151-aej/lab4/src/ALUop.vh"

module ALU(
    input [31:0] A,B,
    input [3:0] ALUop,
    output reg [31:0] Out
);
parameter ALU_ADD    =4'd0;
parameter ALU_SUB    =4'd1;
parameter ALU_AND    =4'd2;
parameter ALU_OR     =4'd3;
parameter ALU_XOR    =4'd4;
parameter ALU_SLT    =4'd5;
parameter ALU_SLTU   =4'd6;
parameter ALU_SLL    =4'd7;
parameter ALU_SRA    =4'd8;
parameter ALU_SRL    =4'd9;
parameter ALU_COPY_B =4'd10;
parameter ALU_XXX    =4'd15;
// Your code goes here
always@* begin
case (ALUop)
	ALU_ADD:begin
		Out = A + B;
	end
	ALU_SUB:begin
		Out = B - A;
	end
	ALU_AND:begin
		Out = B & A;
	end
	ALU_OR:begin
		Out = B | A;
	end
	ALU_XOR:begin
		Out = B ^ A;
	end
	ALU_SLT:begin
		if($signed(A) < $signed(B))
			Out = 1;
		else
			Out = 0;
	end
	ALU_SLTU:begin
		if(A < B)
			Out = 1;
		else
			Out = 0;
	end
	ALU_SLL:begin
		Out = A << B;
	end
	ALU_SRA:begin
		Out = A >>> B;
	end
	ALU_SRL:begin
		Out = A >> B;
	end
	ALU_COPY_B:begin
		Out = B;
	end
	ALU_XXX:begin
		Out = 32'b0;
	end
	endcase
end
endmodule
