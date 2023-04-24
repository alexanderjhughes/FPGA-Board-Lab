module eight_bit_output(
           input [7:0] A,  // 8-bit Input
           input enable, // Enable Flag
           output [7:0] Out // 8-bit Output
    );
    reg [7:0] Result;
    assign Out = Result; // ALU out
    always @(*)
    begin
		if (enable) begin
			Result = A;
		end else begin
			Result = 8'b0;
		end
    end
endmodule