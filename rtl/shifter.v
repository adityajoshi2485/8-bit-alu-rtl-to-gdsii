`timescale 1ns/1ps

module shifter (
    input [7:0] A,
    input dir, // 0 = left, 1 = right
    output [7:0] result
);

    assign result = (dir == 0) ? (A << 1) : (A >> 1);

endmodule