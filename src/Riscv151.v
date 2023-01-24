`include "const.vh"

module Riscv151(
    input clk,
    input reset,

    // Memory system ports
    output [31:0] dcache_addr,
    output [31:0] icache_addr,
    output [3:0] dcache_we,
    output dcache_re,
    output icache_re,
    output [31:0] dcache_din,
    input [31:0] dcache_dout,
    input [31:0] icache_dout,
    input stall,
    output [31:0] csr

);


//ASel = 0 > Reg, ASel = 1 > PC
//BSel = 0 > Imm, BSel = 1 > Reg
//PCSel = 0 > PC+4, PCSel = 1 > ALU
//WBSel = 0 > Mem, = 1 > ALU, = 2 > PC+4, = 3 > CSR
//MemRW = 0 > Read, = 1 > Write 
wire BrEq, BrLT, PCSel, RegWEn, BrUn;
wire [1:0] ASel, BSel;
//ImmSel = 0 > I, = 1 > S, = 2 > B, = 3 > J, = 4 > U
wire [2:0] ImmSel;
wire [2:0] WBSel;
wire [1:0] signext_sel;
wire noopSel;
wire [31:0] wb_data, dataA, dataB;

//PC
reg [31:0] pc_reg;

//CSR
reg [31:0] csrReg;
assign csr = csrReg;


//Stage 1: IF
reg [31:0] inst0,inst1;
wire [31:0] inst = (noopSel == 1) ? 32'h00000013 : icache_dout; //noop mux
reg [31:0] pc0;


wire [6:0] opcode = inst[6:0];
wire [2:0] funct3 = inst[14:12];
wire [6:0] funct7 = inst[31:25];

wire [6:0] opcode0 = inst0[6:0];
wire [2:0] funct3_0 = inst0[14:12];
wire [4:0] rs1 = inst0[19:15];
wire [4:0] rs2 = inst0[24:20];
wire [6:0] funct7_0 = inst0[31:25];

wire [6:0] opcode1 = inst1[6:0];
wire [4:0] rd = inst1[11:7];
wire [2:0] funct3_1 = inst1[14:12];


//ALU wires
wire [3:0] ALUop;
//double check pls
wire add_r_shift_type = funct7_0[5];
wire [31:0] alu_out;


wire [31:0] pcmux_out = (PCSel == 1) ? alu_out : pc_reg+4;

assign icache_addr = pcmux_out;




//Stage 2: ID+EX
reg [31:0] pc1, alu_reg;


//Reg > ALU
wire [31:0] signext_out;
wire [31:0] imm_out;
wire [31:0] A = (ASel == 2) ? signext_out :
				(ASel == 1) ? pc0 :
				dataA;
wire [31:0] B = (BSel == 2) ? signext_out :
				(BSel == 1) ? dataB :
				imm_out;


//Stage 3: MEM+WB
assign icache_re = stall ? 0 : 1;
assign dcache_re = ((opcode0 == `OPC_STORE || opcode0 == `OPC_LOAD)) ? 1 : 0;

wire store_data_hazard;
wire [31:0] wbmux_out = (WBSel == 0) ? dcache_dout :
				(WBSel == 1) ? alu_reg:
				(WBSel == 2) ? pc1 + 4:
				0; 
assign dcache_addr = alu_out;
assign dcache_din = (store_data_hazard == 1 && alu_out%4 == 0) ? signext_out :
					(store_data_hazard == 1 && alu_out%4 == 1) ? signext_out << 8:
					(store_data_hazard == 1 && alu_out%4 == 2) ? signext_out << 16:
					(store_data_hazard == 1 && funct3_0 == 3'b000 && alu_out%4 == 3) ? signext_out << 24 :	
					(store_data_hazard == 1 && funct3_0 == 3'b001 && alu_out%4 == 3) ? signext_out << 16 :
					(alu_out%4 == 0) ? dataB :
					(alu_out%4 == 1) ? dataB << 8 :
					(alu_out%4 == 2) ? dataB << 16 :
					(funct3_0 == 3'b000 && alu_out%4 == 3) ? dataB << 24 :		
					dataB << 16 ;

wire [1:0] branch_hazard;
wire [31:0] branch_dataA = (branch_hazard[0] == 1) ? signext_out :
						   dataA ;
wire [31:0] branch_dataB = (branch_hazard[1] == 1) ? signext_out :
						   dataB ;

wire func3_signext = funct3_1[2];
wire csr_hazard;


assign wb_data = signext_out;


Control control(
	.reset(reset),
	.inst(inst),
	.inst0(inst0),
	.inst1(inst1),
	.alu_out(alu_out),
	.BrEq(BrEq),
	.BrLT(BrLT),
	.PCSel(PCSel),
	.RegWEn(RegWEn),
	.BrUn(BrUn),
	.ASel(ASel),
	.BSel(BSel),
	.MemRW(dcache_we),
	.ImmSel(ImmSel),
	.WBSel(WBSel),
	.signext_sel(signext_sel),
	.noopSel(noopSel),
	.store_data_hazard(store_data_hazard),
	.branch_hazard(branch_hazard),
	.csr_hazard(csr_hazard)
);


REGFILE_1W2R #(
	.DWIDTH(32),
	.AWIDTH(5),
	.DEPTH(32) 
) regfile (
	.clk(clk),
	.rst(reset),
	.d0(wb_data),
	.addr0(rd),
	.we0(RegWEn),
	.addr1(rs1),
	.q1(dataA),
	.addr2(rs2),
	.q2(dataB)
);

signext signext(
	.din(wbmux_out),
	.signext_sel(signext_sel),
	.data_signed(signext_out),
	.addr(alu_reg),
	.func3(func3_signext)
);

ALU alu(
	.A(A),
	.B(B),
	.ALUop(ALUop),
	.Out(alu_out)
);

ALUdec aludec(
	.opcode(opcode0),
	.funct(funct3_0),
	.add_rshift_type(add_r_shift_type),
	.ALUop(ALUop)
);

branch_compare branch(
	.DataA(branch_dataA),
	.DataB(branch_dataB),
	.BrUn(BrUn),
	.BrEq(BrEq),
	.BrLT(BrLT)
);


ImmGen ImmGen(
	.inst(inst0[31:7]),
	.ImmSel(ImmSel),
	.imm_out(imm_out)
);

always @(posedge clk or posedge reset) begin
	if(reset) begin
		pc_reg <= 32'h00002000 - 32'd4;
	end
	else if(!stall) begin
		//CSR
		if(inst0[6:0] == 7'b1110011 && inst0[31:20] == 12'h51e) begin
			if((inst0[14:12] == 3'b001) && (csr_hazard == 0)) begin
				csrReg <= dataA;
			end
			else if((inst0[14:12] == 3'b001) && (csr_hazard == 1)) begin
				csrReg <= signext_out;
			end
			else if(inst0[14:12] == 3'b101) begin
				csrReg <= inst[19:15];
			end
		end
		pc_reg <= pcmux_out;
		//stage 1
		pc0 <= pc_reg;
		inst0 <= inst;
		//stage 2
		pc1 <= pc0;
		alu_reg <= alu_out;
		inst1 <= inst0;	
	end
end
endmodule
