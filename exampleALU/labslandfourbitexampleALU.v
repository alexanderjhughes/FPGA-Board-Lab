module labslandfourbitexampleALU(
           input [11:0] SW,// ALU Selection
           output [7:0] LEDG // ALU 8-bit Output
    );
    reg [7:0] ALU_Result;
    assign LEDG = ALU_Result; // ALU out
    always @(*)
    begin
        case(SW[11:8])
        4'b0000: // Addition
           ALU_Result = SW[3:0] + SW[7:4]; 
        4'b0001: // Subtraction
           ALU_Result = SW[3:0] - SW[7:4];
        4'b0010: // Multiplication
           ALU_Result = SW[3:0] * SW[7:4];
        4'b0011: // Division
           ALU_Result = SW[3:0]/SW[7:4];
        4'b0100: // Logical shift left
           ALU_Result = SW[3:0]<<1;
         4'b0101: // Logical shift right
           ALU_Result = SW[3:0]>>1;
         4'b0110: // Rotate left
           ALU_Result = {SW[2:0],SW[3]};
         4'b0111: // Rotate right
           ALU_Result = {SW[0],SW[3:1]};
          4'b1000: //  Logical and 
           ALU_Result = SW[3:0] & SW[7:4];
          4'b1001: //  Logical or
           ALU_Result = SW[3:0] | SW[7:4];
          4'b1010: //  Logical xor 
           ALU_Result = SW[3:0] ^ SW[7:4];
          4'b1011: //  Logical nor
           ALU_Result = ~(SW[3:0] | SW[7:4]);
          4'b1100: // Logical nand 
           ALU_Result = ~(SW[3:0] & SW[7:4]);
          4'b1101: // Logical xnor
           ALU_Result = ~(SW[3:0] ^ SW[7:4]);
          4'b1110: // Greater comparison
           ALU_Result = (SW[3:0]>SW[7:4])?8'd1:8'd0 ;
          4'b1111: // Equal comparison   
            ALU_Result = (SW[3:0]==SW[7:4])?8'd1:8'd0 ;
          default: ALU_Result = SW[3:0] + SW[7:4] ; 
        endcase
    end

endmodule