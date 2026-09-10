`timescale 1ns/1ps

module alu_top (
    input clk,
    input rst,
    input [7:0] A,
    input [7:0] B,
    input [2:0] opcode,
    output reg [7:0] result,
    output reg zero,
    output reg carry
);

    // Registered inputs
    reg [7:0] A_reg, B_reg;
    reg [2:0] opcode_reg;

    // Internal wires
    wire [7:0] alu_result;
    wire alu_carry;

    // Input Registers
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            A_reg <= 0;
            B_reg <= 0;
            opcode_reg <= 0;
        end else begin
            A_reg <= A;
            B_reg <= B;
            opcode_reg <= opcode;
        end
    end

    // Instantiate combinational ALU core
    alu_core core (
        .A(A_reg),
        .B(B_reg),
        .opcode(opcode_reg),
        .result(alu_result),
        .carry(alu_carry)
    );

    // Output Registers
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            result <= 0;
            zero <= 0;
            carry <= 0;
        end else begin
            result <= alu_result;
            zero <= (alu_result == 0);
            carry <= alu_carry;
        end
    end

endmodule