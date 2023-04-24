module eight_bit_register(
    input clk,
	 input enable,
	 input wire reset,
    input [3:0] sel,
    input [7:0] data_in,
    output reg [7:0] data_out,
	 output [7:0] reg_out0,
	 output [7:0] reg_out1,
	 output [7:0] reg_out2,
	 output [7:0] reg_out3
);

reg [7:0] reg0;// = 8'b0;
reg [7:0] reg1;// = 8'b0;
reg [7:0] reg2;// = 8'b0;
reg [7:0] reg3;// = 8'b0;

assign reg_out0 = reg0;
assign reg_out1 = reg1;
assign reg_out2 = reg0;
assign reg_out3 = reg0;

always @(posedge clk) begin
	if (enable) begin
		if (reset) begin
			reg0 <= 0;
			reg1 <= 0;
			reg2 <= 0;
			reg3 <= 0;
		end else begin
		 case (sel)
			  4'b0000: reg0 <= data_in;
			  4'b0001: reg1 <= data_in;
			  4'b0010: reg2 <= data_in;
			  4'b0011: reg3 <= data_in;
			  default:  reg0 <= data_in;  // if sel is invalid, store in reg0
		 endcase
		end
	end
end

always @(*) begin
	if (enable) begin
		 case (sel)
			  4'b0000: data_out = reg0;
			  4'b0001: data_out = reg1;
			  4'b0010: data_out = reg2;
			  4'b0011: data_out = reg3;
			  default:  data_out = reg0;  // if sel is invalid, output reg0
		 endcase
	 end
end

endmodule