module RegFile(
	input clk, reset, RegWEn,
	input [4:0] regA, regB, regD,
	input [31:0] wb_data,
	output [31:0] dataA, dataB
);
integer i;
reg [31:0] regs [0:31];

assign dataA = regs[regA];
assign dataB = regs[regB];

always @(posedge clk) begin
	if(reset) begin
		for (i = 0; i < 32; i = i+1) begin
			regs[i] <= 0;
		end
	end
	else if(RegWEn && regD != 0) regs[regD] <= wb_data;
end

endmodule




