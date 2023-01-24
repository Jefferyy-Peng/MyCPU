module branch_compare(
	input [31:0] DataA, DataB,
	input BrUn,
	output BrEq,
	output BrLT
);


assign BrEq = (DataA == DataB) ? 1 : 0;

assign BrLT = (BrUn == 1 & (DataA < DataB)) ? 1 :
			(BrUn == 1 & (DataA >= DataB)) ? 0 :	
			(BrUn == 0 & ($signed(DataA) < $signed(DataB))) ? 1 :
			0;


endmodule
