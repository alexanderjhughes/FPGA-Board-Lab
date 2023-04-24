module program_counter(
		input [7:0] address,  // 8-bit address
		input enable, // Enable Flag
		input clk, // Clock
		output [7:0] Out // 8-bit Output
	);
	reg [7:0] Result = 8'b0;
	assign Out = Result; // ALU out
	always @(posedge clk) begin
		if (enable) begin
			Result = address + 1'b1;
		end else begin
			Result = address;
		end
	end
endmodule