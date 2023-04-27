module register_top(
    // Clocks
    CLOCK_50,

    // LEDs
    LEDG,
    LEDR,

    // KEY
    KEY,

    // SW
    SW,

    // SEG7
    HEX0,
    HEX1,
    HEX2,
    HEX3,
    HEX4,
    HEX5,
    HEX6,
    HEX7,
);

// INPUT

input CLOCK_50;

output [8:0] LEDG;
output [17:0] LEDR;

input [3:0] KEY;

input [17:0] SW;

output [6:0] HEX0;
output [6:0] HEX1;
output [6:0] HEX2;
output [6:0] HEX3;
output [6:0] HEX4;
output [6:0] HEX5;
output [6:0] HEX6;
output [6:0] HEX7;

// WIRES

wire clk = CLOCK_50;
wire one_shot_clock;
wire reset = ~KEY[0];
wire latch = ~KEY[1];
wire enable = ~KEY[2];
wire button = ~KEY[3];

reg latch_a_reg = 0;
reg latch_b_reg = 0;
reg latch_o_reg = 0;
reg latch_alu = 0;

wire [7:0] i_bus;
wire [7:0] a_bus;
wire [7:0] b_bus;
wire [7:0] o_bus;

reg [7:0] i_drive_r;
reg [7:0] a_drive_r;
reg [7:0] b_drive_r;
reg [7:0] o_drive_r;

reg [7:0] alu_drive_a;
reg [7:0] alu_drive_b;
reg [7:0] alu_drive_o;

wire [7:0] instruction_reg;
wire [7:0] a_reg;
wire [7:0] b_reg;
wire [7:0] out_reg;

wire [7:0] a = SW[7:0];
wire [7:0] b = SW[15:8];

wire [1:0] program_selection = SW[17:16];

reg [7:0] instruction;
reg [3:0] alu_instruction;

// Components

clock_pulse clock_pulse_inst0(
    .clk(clk),
    .btn(button),
    .pulse(one_shot_clock)
);




always @(posedge one_shot_clock) begin
    if (latch) begin
        alu_drive_a = instruction[3:2] == 2'b00 ? a_reg : b_reg;
        alu_drive_b = instruction[1:0] == 2'b00 ? a_reg : b_reg;
        case (instruction[7:4]) // 1001 00 00
            4'b0000: begin // add
                alu_instruction = 4'b0000;
            end
            4'b0001: begin // subtract
                alu_instruction = 4'b0001;
            end
            4'b0010: begin // multiply // 0010 00 01
                alu_instruction = 4'b0010;
            end
            4'b0011: begin // divide
                alu_instruction = 4'b0011;
            end
            4'b0100: begin // shift left
                alu_instruction = 4'b0100;
            end
            4'b0101: begin // shift right
                alu_instruction = 4'b0101;
            end
            4'b0110: begin // square a
                alu_instruction = 4'b0110;
            end
            4'b0111: begin // square b
                alu_instruction = 4'b0111;
            end
            4'b1000: begin // store alu
                case (instruction[3:2])
                    2'b00: a_drive_r = alu_drive_o;
                    2'b01: b_drive_r = alu_drive_o;
                endcase
                latch_a_reg = instruction[3:2] == 2'b00 ? 1'b1 : 1'b0;
                latch_b_reg = instruction[3:2] == 2'b01 ? 1'b1 : 1'b0;
                latch_o_reg = 1'b0;
                alu_drive_a = instruction[3:2] == 2'b00 ? a_reg : b_reg;
                alu_drive_b = instruction[1:0] == 2'b00 ? a_reg : b_reg;
            end
            4'b1001: begin // load a
                case (instruction[3:2]) // 1001 00 00
                    2'b00: a_drive_r = a;
                    2'b01: b_drive_r = a;
                endcase
                latch_a_reg = instruction[3:2] == 2'b00 ? 1'b1 : 1'b0;
                latch_b_reg = instruction[3:2] == 2'b01 ? 1'b1 : 1'b0;
                latch_o_reg = 1'b0;
                alu_drive_a = instruction[3:2] == 2'b00 ? a_reg : b_reg;
                alu_drive_b = instruction[1:0] == 2'b00 ? a_reg : b_reg;
            end
            4'b1010: begin // load b
                // case (instruction[3:2]) // 1010 01 00
                //     2'b00: a_drive_r = b;
                //     2'b01: b_drive_r = b;
                // endcase
                // latch_a_reg = instruction[3:2] == 2'b00 ? 1'b1 : 1'b0;
                // latch_b_reg = instruction[3:2] == 2'b01 ? 1'b1 : 1'b0;
                b_drive_r = b;
                latch_a_reg = 1'b0;
                latch_b_reg = 1'b1;
                latch_o_reg = 1'b0;
                alu_drive_a = instruction[3:2] == 2'b00 ? a_reg : b_reg;
                alu_drive_b = instruction[1:0] == 2'b00 ? a_reg : b_reg;
            end
            4'b1011: begin // output
                o_drive_r = instruction[3:2] == 2'b00 ? a_reg : b_reg;
                latch_a_reg = 1'b0;
                latch_b_reg = 1'b0;
                latch_o_reg = 1'b1;
            end
        endcase
    end
end

eight_bit_register intruction_register(
	.clk(one_shot_clock),
	.enable(enable),
    .latch(latch),
	.reset(reset),
	.DATA(i_bus),
	.REG_OUT(instruction_reg)
);

eight_bit_register a_register(
	.clk(one_shot_clock),
	.enable(enable),
    .latch(latch_a_reg),
	.reset(reset),
	.DATA(a_bus),
	.REG_OUT(a_reg)
);

eight_bit_register b_register(
	.clk(one_shot_clock),
	.enable(enable),
    .latch(latch_b_reg),
	.reset(reset),
	.DATA(b_bus),
	.REG_OUT(b_reg)
);

eight_bit_register out_register(
	.clk(one_shot_clock),
	.enable(enable),
    .latch(latch_o_reg),
	.reset(reset),
	.DATA(o_bus),
	.REG_OUT(out_reg)
);

seven_seg seven_seg_inst0(
    .in(instruction_reg[3:0]),
    .hex(HEX6)
);
seven_seg seven_seg_inst1(
    .in(instruction_reg[7:4]),
    .hex(HEX7)
);
seven_seg seven_seg_inst2(
    .in(alu_drive_o[7:4]),
    .hex(HEX5)
);
seven_seg seven_seg_inst3(
    .in(alu_drive_o[3:0]),
    .hex(HEX4)
);

seven_seg seven_seg_inst4(
    .in(b_reg[7:4]),
    .hex(HEX3)
);
seven_seg seven_seg_inst5(
    .in(b_reg[3:0]),
    .hex(HEX2)
);

seven_seg seven_seg_inst6(
    .in(a_reg[7:4]),
    .hex(HEX1)
);
seven_seg seven_seg_inst7(
    .in(a_reg[3:0]),
    .hex(HEX0)
);

program_counter program_counter_inst0(
    .address(i_drive_r),
    .enable(latch),
    .reset(reset),
    .clk(one_shot_clock)
);

eight_bit_rom rom(
    .prog(program_selection),
    .address(instruction_reg),
    .instruction(instruction)
);

eight_bit_alu alu(
    .A(alu_drive_a),
    .B(alu_drive_b),
    .ALU_Sel(alu_instruction),
    .ALU_Out(alu_drive_o),
    .CarryOut()
);

// logic

// assign LEDG = alu_drive_o;
assign LEDG = instruction;
assign LEDR[17:16] = program_selection;
assign LEDR[15:8] = out_reg;
assign LEDR[7:0] = a_reg;
assign i_bus = (latch) ? i_drive_r : 8'bZZZZZZZZ;
assign a_bus = (latch_a_reg) ? a_drive_r : 8'bZZZZZZZZ;
assign b_bus = (latch_b_reg) ? b_drive_r : 8'bZZZZZZZZ;
assign o_bus = (latch_o_reg) ? o_drive_r : 8'bZZZZZZZZ;

endmodule