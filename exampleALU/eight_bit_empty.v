module eight_bit_empty(
		output [7:0] Out // 8-bit Output
);
	reg [7:0] zero;
	assign Out = zero;
	always @(*) begin
		zero = 8'b0;
	end
endmodule