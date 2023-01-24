

module ImmGen (
	input [24:0] inst,
	input [2:0] ImmSel,
	output [31:0] imm_out
);

assign imm_out = (ImmSel == 0)? {{20{inst[24]}},inst[24:13]}: //I-typr
                 (ImmSel == 1)? {{20{inst[24]}},inst[24:18],inst[4:0]}: //S-type
			  	 (ImmSel == 2)? {{20{inst[24]}},inst[0],inst[23:18],inst[4:1],1'b0}://B-type
				 (ImmSel == 3)? {{12{inst[24]}},inst[12:5],inst[13],inst[23:14],1'b0}://JAL
				 (ImmSel == 4)? {inst[24:5],12'b0} : //LUI,AUIPC
				 (ImmSel == 5)? {{20{inst[24]}},inst[24:14],1'b0}: 0;//JALR

endmodule
