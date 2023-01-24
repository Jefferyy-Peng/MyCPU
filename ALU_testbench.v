`timescale 1 ns / 100 ps

module ALU_testbench;

reg [31:0] A,B;
reg [3:0] ALUop;
wire [31:0] Out;

ALU dut(
	.A(A),
	.B(B),
	.ALUop(ALUop),
	.Out(Out)
);
integer i = 0;
integer j = 0;
initial begin
	$vcdpluson;
		for(j=0; j < 100; j = j + 1) begin
			#5
			A = $random%65536;
			B = $random%65536;
			ALUop = 0;
			#5
			if (Out == A + B) begin
        		$display(" [ passed ] ADD_Test ( %d ), [ %d == %d ] (decimal)",j,Out,A + B);
      		end else begin
        		$display(" [ failed ] ADD_Test ( %d ), [ %d == %d ] (decimal)",j,Out,A + B);
      		end
		end	
		for(j=0; j < 100; j = j + 1) begin
			#5
			A = $random%65536;
			B = $random%65536;
			ALUop = 1;
			#5
			if (Out == B - A) begin
        		$display(" [ passed ] SUB_Test ( %d ), [ %d == %d ] (decimal)",j,Out,B - A);
      		end else begin
        		$display(" [ failed ] SUB_Test ( %d ), [ %d == %d ] (decimal)",j,Out,B - A);
      		end
		end	for(j=0; j < 100; j = j + 1) begin
			#5
			A = $random%65536;
			B = $random%65536;
			ALUop = 2;
			#5
			if (Out == A & B) begin
        		$display(" [ passed ] AND_Test ( %d ), [ %d == %d ] (decimal)",j,Out,A & B);
      		end else begin
        		$display(" [ failed ] AND_Test ( %d ), [ %d == %d ] (decimal)",j,Out,A & B);
      		end
		end	for(j=0; j < 100; j = j + 1) begin
			#5
			A = $random%65536;
			B = $random%65536;
			ALUop = 3;
			#5
			if (Out == A | B) begin
        		$display(" [ passed ] OR_Test ( %d ), [ %d == %d ] (decimal)",j,Out,A | B);
      		end else begin
        		$display(" [ failed ] OR_Test ( %d ), [ %d == %d ] (decimal)",j,Out,A | B);
      		end
		end	for(j=0; j < 100; j = j + 1) begin
			#5
			A = $random%65536;
			B = $random%65536;
			ALUop = 4;
			#5
			if (Out == A ^ B) begin
        		$display(" [ passed ] XOR_Test ( %d ), [ %d == %d ] (decimal)",j,Out,A ^ B);
      		end else begin
        		$display(" [ failed ] XOR_Test ( %d ), [ %d == %d ] (decimal)",j,Out,A ^ B);
      		end
		end	for(j=0; j < 100; j = j + 1) begin
			#5
			A = $random%65536;
			B = $random%65536;
			ALUop = 5;
			#5
			if (($signed(A) < $signed(B))&&(Out == 1)) begin
        		$display(" [ passed ] SLT_Test ( %d ), [ %d == %d ] (decimal)",j,Out,1);
      		end 
			else if (($signed(A) > $signed(B))&&(Out == 0))	begin
				$display(" [ passed ] SLT_Test ( %d ), [ %d == %d ] (decimal)",j,Out,0);
      		end 
			else begin
        		$display(" [ failed ] SLT_Test ( %d ), [ %d == %d ] (decimal)",j,1,0);
      		end
		end	for(j=0; j < 100; j = j + 1) begin
			#5
			A = $random%65536;
			B = $random%65536;
			ALUop = 6;
			#5
			if (((A) < (B))&&(Out == 1)) begin
        		$display(" [ passed ] SLTU_Test ( %d ), [ %d == %d ] (decimal)",j,Out,1);
      		end 
			else if (((A) > (B))&&(Out == 0))	begin
				$display(" [ passed ] SLTU_Test ( %d ), [ %d == %d ] (decimal)",j,Out,0);
      		end 
			else begin
        		$display(" [ failed ] SLTU_Test ( %d ), [ %d == %d ] (decimal)",j,1,0);
      		end
		end	for(j=0; j < 100; j = j + 1) begin
			#5
			A = $random%65536;
			B = $random%65536;
			ALUop = 7;
			#5
			if (Out == A << B) begin
        		$display(" [ passed ] SLL_Test ( %d ), [ %d == %d ] (decimal)",j,Out,A << B);
      		end else begin
        		$display(" [ failed ] SLL_Test ( %d ), [ %d == %d ] (decimal)",j,Out,A << B);
      		end
		end	for(j=0; j < 100; j = j + 1) begin
			#5
			A = $random%65536;
			B = $random%65536;
			ALUop = 8;
			#5
			if (Out == A >>> B) begin
        		$display(" [ passed ] SRA_Test ( %d ), [ %d == %d ] (decimal)",j,Out,A >>> B);
      		end else begin
        		$display(" [ failed ] SRA_Test ( %d ), [ %d == %d ] (decimal)",j,Out,A >>> B);
      		end
		end	for(j=0; j < 100; j = j + 1) begin
			#5
			A = $random%65536;
			B = $random%65536;
			ALUop = 9;
			#5
			if (Out == A >> B) begin
        		$display(" [ passed ] SRL_Test ( %d ), [ %d == %d ] (decimal)",j,Out,A >> B);
      		end else begin
        		$display(" [ failed ] SRL_Test ( %d ), [ %d == %d ] (decimal)",j,Out,A >> B);
      		end
		end	for(j=0; j < 100; j = j + 1) begin
			#5
			A = $random%65536;
			B = $random%65536;
			ALUop = 10;
			#5
			if (Out == B) begin
        		$display(" [ passed ] COPY_B_Test ( %d ), [ %d == %d ] (decimal)",j,Out,B);
      		end else begin
        		$display(" [ failed ] COPY_B_Test ( %d ), [ %d == %d ] (decimal)",j,Out,B);
      		end
		end	for(j=0; j < 100; j = j + 1) begin
			#5
			A = $random%65536;
			B = $random%65536;
			ALUop = 15;
			#5
			if (Out == 0) begin
        		$display(" [ passed ] XXX_Test ( %d ), [ %d == %d ] (decimal)",j,Out,0);
      		end else begin
        		$display(" [ failed ] XXX_Test ( %d ), [ %d == %d ] (decimal)",j,Out,0);
      		end
		end	
	$vcdplusoff;
	//$finish
end

endmodule
