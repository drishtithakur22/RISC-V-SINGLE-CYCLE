////////////////////////////////// Company: 
// Engineer: 
// 
// Create Date: 10/25/2026 08:24:56 PM
// Design Name: 
// Module Name: id_stage
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


module id_stage (
    input wire clk,
    input wire rst,
    input wire [31:0] instruction,

    // Register writeback inputs
    input wire reg_write,
    input wire [4:0] wb_rd,
    input wire [31:0] wb_data,

    // Register values
    output wire [31:0] read_data1,
    output wire [31:0] read_data2,

    // Decoded instruction fields
    output wire [31:0] immediate,
    output wire [4:0] rs1,
    output wire [4:0] rs2,
    output wire [4:0] rd,
    output wire [6:0] opcode,
    output wire [2:0] funct3,
    output wire [6:0] funct7
);

    // Extract instruction fields
    assign opcode = instruction[6:0];
    assign rd     = instruction[11:7];
    assign funct3 = instruction[14:12];
    assign rs1    = instruction[19:15];
    assign rs2    = instruction[24:20];
    assign funct7 = instruction[31:25];

    // Immediate generation
    reg [31:0] imm;

    always @(*) begin
        case (opcode)

            // I-type: arithmetic, loads, JALR
            7'b0010011,
            7'b0000011,
            7'b1100111:
                imm = {{20{instruction[31]}}, instruction[31:20]};

            // S-type: stores
            7'b0100011:
                imm = {{20{instruction[31]}},
                       instruction[31:25], instruction[11:7]};

            // B-type: branches
            7'b1100011:
                imm = {{19{instruction[31]}}, instruction[31],
                       instruction[7], instruction[30:25],
                       instruction[11:8], 1'b0};

            // U-type: LUI, AUIPC
            7'b0110111,
            7'b0010111:
                imm = {instruction[31:12], 12'b0};

            // J-type: JAL
            7'b1101111:
                imm = {{11{instruction[31]}}, instruction[31],
                       instruction[19:12], instruction[20],
                       instruction[30:21], 1'b0};

            default:
                imm = 32'b0;

        endcase
    end

    assign immediate = imm;

    // Register file with writeback support
    register_file rf (
        .clk(clk),
        .reset(rst),
        .reg_write(reg_write),
        .rs1(rs1),
        .rs2(rs2),
        .rd(wb_rd),
        .write_data(wb_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

endmodule



