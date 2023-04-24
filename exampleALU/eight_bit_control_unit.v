module eight_bit_control_unit(
    input clk,
    input [7:0] a,
    input [7:0] b,
    input [7:0] alu_in,
	 input [7:0] reg0,
	 input [7:0] reg1,
	 input [7:0] reg2,
	 input [7:0] reg3,
	 input [7:0] instruction,
    output reg [7:0] a_out,
    output reg [7:0] b_out,
    output reg enable_alu,
    output reg enable_reg,
    output reg enable_out,
	 output reg [3:0] instruction_out
);

// Instruction breakdown
// 8 bit instruction
// first 4 are the op_code
// next 2 is the first reg
// next 2 is the second reg

// reg[7:0] instr = instruction;

initial a_out = a;
initial b_out = b;

always @(posedge clk) begin
	case (instruction[7:4])
		4'b0000: begin // add
			a_out = a;
			b_out = b;
			enable_alu = 1'b1;
			enable_reg = 1'b0;
			enable_out = 1'b0;
			instruction_out = 4'b0000;
		end
		4'b0001: begin // subtract
			a_out = a;
			b_out = b;
			enable_alu = 1'b1;
			enable_reg = 1'b0;
			enable_out = 1'b0;
			instruction_out = 4'b0001;
		end
		4'b0010: begin // multiply
			a_out = a;
			b_out = b;
			enable_alu = 1'b1;
			enable_reg = 1'b0;
			enable_out = 1'b0;
			instruction_out = 4'b0010;
		end
		4'b0011: begin // divide
			a_out = a;
			b_out = b;
			enable_alu = 1'b1;
			enable_reg = 1'b0;
			enable_out = 1'b0;
			instruction_out = 4'b0011;
		end
		4'b0100: begin // shift left
			a_out = a;
			b_out = b;
			enable_alu = 1'b1;
			enable_reg = 1'b0;
			enable_out = 1'b0;
			instruction_out = 4'b0100;
		end
		4'b0101: begin // shift right
			a_out = a;
			b_out = b;
			enable_alu = 1'b1;
			enable_reg = 1'b0;
			enable_out = 1'b0;
			instruction_out = 4'b0101;
		end
		4'b0110: begin // square a
			a_out = a;
			b_out = b;
			enable_alu = 1'b1;
			enable_reg = 1'b0;
			enable_out = 1'b0;
			instruction_out = 4'b0110;
		end
		4'b0111: begin // square b
			a_out = a;
			b_out = b;
			enable_alu = 1'b1;
			enable_reg = 1'b0;
			enable_out = 1'b0;
			instruction_out = 4'b0111;
		end
		4'b1000: begin // move
			a_out = a;
			b_out = 8'b00000000;
			enable_alu = 1'b0;
			enable_reg = 1'b1;
			enable_out = 1'b0;
			instruction_out = 4'b0010;
		end
		4'b1001: begin // load a
			a_out = a;
			b_out = 8'b00000000;
			enable_alu = 1'b1;
			enable_reg = 1'b1;
			enable_out = 1'b0;
			instruction_out = 4'b0001;
		end
		4'b1010: begin // load b
			a_out = a;
			b_out = 8'b00000000;
			enable_alu = 1'b0;
			enable_reg = 1'b1;
			enable_out = 1'b0;
			instruction_out = 4'b0010;
		end
		4'b1011: begin // output a
			a_out = a;
			b_out = 8'b00000000;
			enable_alu = 1'b0;
			enable_reg = 1'b0;
			enable_out = 1'b1;
			instruction_out = 4'b0000;
		end
	endcase
end

endmodule