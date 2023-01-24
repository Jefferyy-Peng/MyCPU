`include "util.vh"
`include "const.vh"

module cache #
(
  parameter LINES = 64,
  parameter CPU_WIDTH = `CPU_INST_BITS,
  parameter WORD_ADDR_BITS = `CPU_ADDR_BITS-`ceilLog2(`CPU_INST_BITS/8)
)
(
  input clk,
  input reset,

  input                       cpu_req_valid,
  output reg                  cpu_req_ready,
  input [WORD_ADDR_BITS-1:0]  cpu_req_addr,
  input [CPU_WIDTH-1:0]       cpu_req_data,
  input [3:0]                 cpu_req_write,

  output reg                  cpu_resp_valid,
  output reg [CPU_WIDTH-1:0]  cpu_resp_data,

  output reg                  mem_req_valid,
  input                       mem_req_ready,
  output reg [WORD_ADDR_BITS-1:`ceilLog2(`MEM_DATA_BITS/CPU_WIDTH)] mem_req_addr,
  output reg                       mem_req_rw,
  output reg                       mem_req_data_valid,
  input                            mem_req_data_ready,
  output reg [`MEM_DATA_BITS-1:0]  mem_req_data_bits,
  // byte level masking
  output reg [(`MEM_DATA_BITS/8)-1:0]  mem_req_data_mask,

  input                       mem_resp_valid,
  input [`MEM_DATA_BITS-1:0]  mem_resp_data
);

reg [7:0] dataA;
reg dataWEB; 
reg [127:0] dataI, dataO;
reg [15:0] byteMask;
wire [127:0] dataO_wire;

SRAM1RW256x128 dataRAM (
	.A(dataA),
	.CE(clk),
	.WEB(dataWEB),
	.OEB(1'b0),
	.CSB(1'b0),
	.BYTEMASK(byteMask),
	.I(dataI),
	.O(dataO_wire)
);


reg [5:0] tagA;
reg tagWEB;
reg [31:0] tagI;
wire [31:0] tagO_wire;

//Only need 23 bits for tag. Will use LSBs.
SRAM1RW64x32 tagRAM (
	.A(tagA),
	.CE(clk),
	.WEB(tagWEB),
	.OEB(1'b0),
	.CSB(1'b0),
	.I(tagI),
	.O(tagO_wire)

);

always @* begin
	dataO = dataO_wire;
end
//Valid bit for each tag at tagRAM[index]
reg [7:0] valid_bit;

wire [22:0]  cache_tag = tagO_wire[22:0];

reg [29:0] curr_addr;
wire [3:0] offset = curr_addr[3:0];
wire [2:0] index = curr_addr[6:4];
wire [22:0] tag = curr_addr[29:7];

wire [8:0] data_addr = index*4 + offset[3:2];

parameter IDLE = 4'b0000;
parameter READTAG = 4'b0010;
parameter LOADDATA = 4'b0011;
parameter WRITEDATA = 4'b1011;
parameter READ = 4'b0101;
parameter WRITEBACK = 4'b0110;
parameter WRITEBACKDATA = 4'b0111;
parameter DATAREQ = 4'b0100;
parameter TAGREQ = 4'b0001;
parameter MEMREQ = 4'b1000;

wire cpu_req_fire = cpu_req_valid && cpu_req_ready;
wire mem_req_fire = mem_req_valid && mem_req_ready;
wire mem_req_data_fire = mem_req_data_valid && mem_req_data_ready;

reg [3:0] state, nextstate;
reg [2:0] cycle;

always @* begin
	//default
	cpu_resp_valid = 1'b0;	
	cpu_resp_data = {CPU_WIDTH{1'b0}}; 
	mem_req_valid = 1'b0;
	mem_req_addr = {(WORD_ADDR_BITS-1-`ceilLog2(`MEM_DATA_BITS/CPU_WIDTH)){1'b0}};
	mem_req_rw = 1'b0;
	mem_req_data_valid = 1'b0;
	mem_req_data_bits = {`MEM_DATA_BITS{1'b0}};
	mem_req_data_mask = {(`MEM_DATA_BITS/8){1'b0}};
	tagWEB = 1'b1;
	dataWEB = 1'b1;
	cpu_req_ready = 1'b0;
	byteMask = 16'd0;
	dataI = 128'd0;
	case(state)
		IDLE : begin
			cpu_req_ready = 1'b1;
			cpu_resp_valid	= 1'b0;
			if(cpu_req_fire) begin
				tagA = {2'b00, index};
				tagWEB = 1'b1;
				nextstate = TAGREQ;
			end else begin
				nextstate = IDLE;
			end
		end
		
		TAGREQ: begin
			tagA = {2'b00, index};
			nextstate = READTAG;
		end
	
		READTAG : begin	
			if(valid_bit[index] != 1'b1 || tag != cache_tag) begin
				//Cache Miss
				tagWEB = 1'b0;
				tagI = {{9{1'b0}}, tag};
				mem_req_addr = curr_addr[WORD_ADDR_BITS-1:`ceilLog2(`MEM_DATA_BITS/CPU_WIDTH)];
				mem_req_valid = 1'b1;
				mem_req_rw = 1'b0;
				if(mem_req_ready) nextstate = LOADDATA;
				else nextstate = MEMREQ;
			end else begin
				//Cache Hit
				dataA = data_addr;
				if(cpu_req_write == 4'd0) begin
					dataWEB = 1'b1;
					nextstate = READ;
				end else begin
					dataWEB = 1'b0;
					byteMask = cpu_req_write << offset[1:0]*4;
					dataI = cpu_req_data << offset[1:0]*32;
					nextstate = WRITEBACK;
				end
			end
		end				

		MEMREQ : begin
			mem_req_addr = curr_addr[WORD_ADDR_BITS-1:`ceilLog2(`MEM_DATA_BITS/CPU_WIDTH)];
			mem_req_valid = 1'b1;
			mem_req_rw = 1'b0;
			if(mem_req_ready) nextstate = LOADDATA;
			else nextstate = MEMREQ;
		end

		
		LOADDATA : begin
			if(mem_resp_valid) begin
				dataWEB = 1'b0;
				dataA = index*4 + cycle;
				byteMask = {16{1'b1}};
				dataI = mem_resp_data;
				if(cycle < 3'b100) begin
					if(cycle == 3'b011) nextstate = WRITEDATA;
					else nextstate = LOADDATA;
				end
			end else begin
				 nextstate = LOADDATA;
			end
		end

		WRITEDATA: begin
			if(cpu_req_write == 4'd0) nextstate = DATAREQ;
			else begin 
				dataA = data_addr;	
				dataWEB = 1'b0;
				byteMask = cpu_req_write << offset[1:0]*4;
				dataI = cpu_req_data << offset[1:0]*32;
				nextstate = WRITEBACK;
			end

		end
		
		DATAREQ: begin
			dataA = index*4 + offset[3:2];
			nextstate = READ;
		end
	
		READ: begin
			case(offset[1:0])	
				2'b00 : cpu_resp_data = dataO[31: 0];
				2'b01 : cpu_resp_data = dataO[63: 32];
				2'b10 : cpu_resp_data = dataO[95: 64];
				2'b11 : cpu_resp_data = dataO[127: 96];
			endcase
			cpu_resp_valid = 1'b1;
			nextstate = IDLE;
		end

		WRITEBACK: begin
			if(mem_req_ready) begin
				mem_req_rw = 1'b1;
				mem_req_valid = 1'b1;
				mem_req_addr = curr_addr[WORD_ADDR_BITS-1:`ceilLog2(`MEM_DATA_BITS/CPU_WIDTH)];
				nextstate = WRITEBACKDATA;
			end else nextstate = WRITEBACK;
		end

		WRITEBACKDATA: begin
			if(mem_req_data_ready) begin
				mem_req_data_valid = 1'b1;
				mem_req_data_bits = dataO;
				mem_req_data_mask = 16'hFFFF;
				nextstate = IDLE;
			end else nextstate = WRITEBACKDATA;
		end

	endcase
end

always @(posedge clk) begin
	if(reset) begin
		state <= IDLE;
		valid_bit <= 8'd0;
	end	
	else state <= nextstate;
	if(state == IDLE) curr_addr <= cpu_req_addr;
	if(state == LOADDATA) cycle <= cycle + 1;
	else cycle <= 3'd0;
	if(state == LOADDATA || state == MEMREQ) valid_bit[index] <= 1'b1;
end



endmodule
