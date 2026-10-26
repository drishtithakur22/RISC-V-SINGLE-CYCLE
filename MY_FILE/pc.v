`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2026 12:45:37 AM
// Design Name: 
// Module Name: pc
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



module pc (
    input wire clk,
    input wire reset,
    input wire [31:0] next_pc,
    output reg [31:0] pc_out
);

    always @(posedge clk) begin
        if (reset)
            pc_out <= 32'd0;
        else
            pc_out <= next_pc;
    end

endmodule

