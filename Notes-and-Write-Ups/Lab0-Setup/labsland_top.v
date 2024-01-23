module labsland_top(
    // LEDs
    LEDG,
    LEDR,

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
    HEX7
);

// OUTPUTS

output [8:0] LEDG;
output [17:0] LEDR;

output [6:0] HEX0;
output [6:0] HEX1;
output [6:0] HEX2;
output [6:0] HEX3;
output [6:0] HEX4;
output [6:0] HEX5;
output [6:0] HEX6;
output [6:0] HEX7;

input [17:0] SW;

// WIRES

wire [7:0] a = SW[7:0];
wire [7:0] b = SW[15:8];

// HEX DISPLAY
seven_seg seven_seg_inst0(
    .in(4'b0010),
    .hex(HEX7)
);
seven_seg seven_seg_inst1(
    .in(4'b0000),
    .hex(HEX6)
);
seven_seg seven_seg_inst2(
    .in(4'b0010),
    .hex(HEX5)
);
seven_seg seven_seg_inst3(
    .in(4'b0100),
    .hex(HEX4)
);

seven_seg seven_seg_inst4(
    .in(4'b0000),
    .hex(HEX3)
);
seven_seg seven_seg_inst5(
    .in(4'b0010),
    .hex(HEX2)
);

seven_seg seven_seg_inst6(
    .in(4'b0011),
    .hex(HEX1)
);
seven_seg seven_seg_inst7(
    .in(4'b0010),
    .hex(HEX0)
);

// LEDS

assign LEDG[7:0] = 8'b0000001;
assign LEDR[15:8] = b;
assign LEDR[7:0] = a;

endmodule