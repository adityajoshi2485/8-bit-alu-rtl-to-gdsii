`timescale 1ns/1ps

module adder_8bit (
    input [7:0] A,
    input [7:0] B,
    input cin,
    output [7:0] sum,
    output cout
);

    assign {cout, sum} = A + B + cin;

endmodule