module signext(
	input [31:0] din,
	input [1:0] signext_sel,
	input [31:0] addr,
	input func3,
	output reg [31:0] data_signed
);

reg [31:0] half;
always@(*) begin
	case(signext_sel)
		2'd0: data_signed <= din;
		2'd1: begin
			case(addr%4)
				0: begin
					half <= din & 32'h0000FFFF;
					if(func3) data_signed <= {{16{1'b0}},half[15:0]};
					else data_signed <= {{16{half[15]}},half[15:0]};
				end
				1: begin
					half <= din & 32'h00FFFF00;
					if(func3) data_signed <= {{16{1'b0}},half[23:8]};
					else data_signed <= {{16{half[23]}},half[23:8]};
				end
				2,3: begin
					half <= din & 32'hFFFF0000;
					if(func3) data_signed <= {{16{1'b0}},half[31:16]};
					else data_signed <= {{16{half[31]}},half[31:16]};
				end
			endcase
		end
		2'd2: begin
			case(addr%4)
				0: begin
					half <= din & 32'h000000FF;
					if(func3) data_signed <= {{24{1'b0}},half[7:0]};
					else data_signed <= {{24{half[7]}},half[7:0]};
				end
				1: begin
					half <= din & 32'h0000FF00;
					if(func3) data_signed <= {{24{1'b0}},half[15:8]};
					else data_signed <= {{24{half[15]}},half[15:8]};
				end
				2: begin
					half <= din & 32'h00FF0000;
					if(func3) data_signed <= {{24{1'b0}},half[23:16]};
					else data_signed <= {{24{half[23]}},half[23:16]};
				end
				3: begin
					half <= din & 32'hFF000000;
					if(func3) data_signed <= {{24{1'b0}},half[31:24]};
					else data_signed <= {{24{half[31]}},half[31:24]};
				end
			endcase
		end
	endcase
end
endmodule
