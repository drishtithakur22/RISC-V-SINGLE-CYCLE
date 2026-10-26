`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2026 01:07:38 AM
// Design Name: 
// Module Name: register_file
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



module register_file (
    input wire clk,
    input wire reset,
    input wire reg_write,

    input wire [4:0] rs1,
    input wire [4:0] rs2,
    input wire [4:0] rd,

    input wire [31:0] write_data,

    output wire [31:0] read_data1,
    output wire [31:0] read_data2
);

    reg [31:0] registers [0:31];
    integer i;

    // Write port: update on the rising clock edge
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'b0;
        end
        else if (reg_write && rd != 5'd0) begin
            registers[rd] <= write_data;
        end
    end

    // Two asynchronous read ports
    assign read_data1 =
        (rs1 == 5'd0) ? 32'b0 : registers[rs1];

    assign read_data2 =
        (rs2 == 5'd0) ? 32'b0 : registers[rs2];

endmodule

