`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2026 08:57:44 PM
// Design Name: 
// Module Name: ex_stage
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



module ex_stage (
    input  wire [31:0] operand_a,
    input  wire [31:0] operand_b,
    input  wire [31:0] immediate,
    input  wire        alu_src,
    input  wire [3:0]  alu_control,

    output wire [31:0] alu_result,
    output wire        zero
);

    // Select register operand or immediate
    wire [31:0] alu_operand_b;

    assign alu_operand_b =
        (alu_src) ? immediate : operand_b;

    // Arithmetic Logic Unit
    alu alu_unit (
        .operand_a  (operand_a),
        .operand_b  (alu_operand_b),
        .alu_control(alu_control),
        .alu_result (alu_result),
        .zero       (zero)
    );

endmodule

