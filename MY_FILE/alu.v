`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2026 08:51:58 PM
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module alu (
    input  wire [31:0] operand_a,
    input  wire [31:0] operand_b,
    input  wire [3:0]  alu_control,

    output reg  [31:0] alu_result,
    output reg         zero
);

    always @(*) begin
        case (alu_control)

            4'b0000: alu_result = operand_a + operand_b;  // ADD
            4'b0001: alu_result = operand_a - operand_b;  // SUB
            4'b0010: alu_result = operand_a & operand_b;  // AND
            4'b0011: alu_result = operand_a | operand_b;  // OR
            4'b0100: alu_result = operand_a ^ operand_b;  // XOR
            4'b0101: alu_result = operand_a << operand_b[4:0]; // SLL
            4'b0110: alu_result = operand_a >> operand_b[4:0]; // SRL
            4'b0111: alu_result = $signed(operand_a) >>> operand_b[4:0]; // SRA
            4'b1000: alu_result = ($signed(operand_a) < $signed(operand_b)) ? 32'd1 : 32'd0; // SLT
            4'b1001: alu_result = (operand_a < operand_b) ? 32'd1 : 32'd0; // SLTU

            default: alu_result = 32'b0;

        endcase

        zero = (alu_result == 32'b0);
    end

endmodule

