`timescale 1ns/1ps

module logic_unit (
    input [7:0] A,
    input [7:0] B,
    input [1:0] sel,
    output reg [7:0] result
);

    always @(*) begin
        case(sel)
            2'b00: result = A & B;
            2'b01: result = A | B;
            2'b10: result = A ^ B;
            2'b11: result = ~A;
        endcase
    end

endmodule