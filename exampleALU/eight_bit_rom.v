module eight_bit_rom(
    input [1:0] prog,
    input [7:0] address,
    output reg [7:0] instruction
);

// Instruction breakdown
// 8 bit instruction
// first 4 are the opp_code
// next 2 is the first reg
// next 2 is the second reg

reg[1:0] nullReg = 2'b0;

reg[1:0] reg1 = 2'b00;
reg[1:0] reg2 = 2'b01;
reg[1:0] reg3 = 2'b10;
reg[1:0] reg4 = 2'b11;

reg[3:0] add = 4'b0000;
reg[3:0] sub = 4'b0001;
reg[3:0] mul = 4'b0010;
reg[3:0] div = 4'b0011;
reg[3:0] shl = 4'b0100;
reg[3:0] shr = 4'b0101;
reg[3:0] sqa = 4'b0110;
reg[3:0] sqb = 4'b0111;
reg[3:0] mov = 4'b1000;
reg[3:0] lda = 4'b1001;
reg[3:0] ldb = 4'b1010;
reg[3:0] out = 4'b1011;

always @(*) begin
	case (prog)
		2'b00: begin case (address)
			  8'b00000000: instruction = {lda, reg1, nullReg};
			  8'b00000001: instruction = {ldb, reg2, nullReg};
			  8'b00000010: instruction = {mul, reg1, reg2};
			  8'b00000011: instruction = {shl, reg1, nullReg};
			  8'b00000100: instruction = {out, reg1, nullReg};
			  default:  instruction = {lda, reg1, nullReg};
		endcase end
		2'b01: begin case (address)
			  8'b00000000: instruction = {lda, reg1, nullReg};
			  8'b00000001: instruction = {out, reg1, nullReg};
			  default:  instruction = {lda, reg1, nullReg};
		endcase end
		2'b10: begin case (address)
			  8'b00000000: instruction = {lda, reg1, nullReg};
			  8'b00000001: instruction = {ldb, reg2, nullReg};
			  8'b00000010: instruction = {mul, reg1, reg2};
			  8'b00000011: instruction = {shl, reg1, nullReg};
			  8'b00000100: instruction = {out, reg1, nullReg};
			  default:  instruction = {lda, reg1, nullReg};
		endcase end
		2'b11: begin case (address)
			  8'b00000000: instruction = {lda, reg1, nullReg};
			  8'b00000001: instruction = {ldb, reg2, nullReg};
			  8'b00000010: instruction = {mul, reg1, reg2};
			  8'b00000011: instruction = {shl, reg1, nullReg};
			  8'b00000100: instruction = {out, reg1, nullReg};
			  default:  instruction = {lda, reg1, nullReg};
		endcase end
	endcase
end

endmodule