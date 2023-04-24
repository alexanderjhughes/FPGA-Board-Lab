module eight_bit_alu(
           input [7:0] A,B,  // ALU 4-bit Inputs                 
           input [3:0] ALU_Sel,// ALU Selection
           output [7:0] ALU_Out, // ALU 8-bit Output
           output CarryOut // Carry Out Flag
    );
    reg [7:0] ALU_Result;
	 reg [3:0] REG_Result = 2'b10;
    wire [8:0] tmp;
    assign ALU_Out = ALU_Result; // ALU out
    assign tmp = {1'b0,A} + {1'b0,B};
    assign CarryOut = tmp[8]; // Carryout flag
    always @(*)
    begin
        case(ALU_Sel)
			  4'b0000: // Addition
				  ALU_Result = A + B ; 
			  4'b0001: // Subtraction
				  ALU_Result = A - B ;
			  4'b0010: // Multiplication
				  ALU_Result = A * B;
			  4'b0011: // Division
				  ALU_Result = A/B;
			  4'b0100: // Logical shift left
				  ALU_Result = A<<1;
			  4'b0101: // Logical shift right
				  ALU_Result = A>>1;
			  4'b0110: // A sqaured
				  ALU_Result = A * A;
			  4'b0111: // B sqaured
				  ALU_Result = B * B;
			  default: ALU_Result = A + B ; 
        endcase
    end

endmodule