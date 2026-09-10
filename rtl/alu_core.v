`timescale 1ns/1ps

module alu_core (
    input [7:0] A,
    input [7:0] B,
    input [2:0] opcode,
    output reg [7:0] result,
    output carry
);

    wire [7:0] add_result;
    wire add_cout;
    wire [7:0] logic_result;
    wire [7:0] shift_result;

    reg cin;
    reg [1:0] logic_sel;
    reg shift_dir;

    adder_8bit U1 (
        .A(A),
        .B(B),
        .cin(cin),
        .sum(add_result),
        .cout(add_cout)
    );

    logic_unit U2 (
        .A(A),
        .B(B),
        .sel(logic_sel),
        .result(logic_result)
    );

    shifter U3 (
        .A(A),
        .dir(shift_dir),
        .result(shift_result)
    );

    always @(*) begin
        cin = 0;
        logic_sel = 2'b00;
        shift_dir = 0;

        case(opcode)
            3'b000: result = add_result;

            3'b001: begin
                cin = 1;
                result = add_result;
            end

            3'b010: begin
                logic_sel = 2'b00;
                result = logic_result;
            end

            3'b011: begin
                logic_sel = 2'b01;
                result = logic_result;
            end

            3'b100: begin
                logic_sel = 2'b10;
                result = logic_result;
            end

            3'b101: begin
                logic_sel = 2'b11;
                result = logic_result;
            end

            3'b110: begin
                shift_dir = 0;
                result = shift_result;
            end

            3'b111: begin
                shift_dir = 1;
                result = shift_result;
            end
        endcase
    end

    assign carry = add_cout;

endmodule