`timescale 1ns/1ps

module ALU_tb;

    // Testbench signals
    reg clk;
    reg rst;
    reg [7:0] A;
    reg [7:0] B;
    reg [2:0] opcode;

    wire [7:0] result;
    wire zero;
    wire carry;

    // DUT = Device Under Test
    // Instantiate the ALU top module
    alu_top DUT (
        .clk    (clk),
        .rst    (rst),
        .A      (A),
        .B      (B),
        .opcode (opcode),
        .result (result),
        .zero   (zero),
        .carry  (carry)
    );

    // 10 ns clock period = 100 MHz
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // VCD waveform dump
    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, ALU_tb);
    end

    // Apply one test vector
    task apply_test;
        input [7:0] test_A;
        input [7:0] test_B;
        input [2:0] test_opcode;

        begin
            @(negedge clk);
            A = test_A;
            B = test_B;
            opcode = test_opcode;

            // Allow registered input and output stages
            @(posedge clk);
            #1;

            $display(
                "TIME=%0t | A=%h B=%h OPCODE=%b | RESULT=%h ZERO=%b CARRY=%b",
                $time, A, B, opcode, result, zero, carry
            );
        end
    endtask

    // Main stimulus
    initial begin

        // Initial values
        A = 8'h00;
        B = 8'h00;
        opcode = 3'b000;

        // Reset
        rst = 1'b1;
        repeat (2) @(posedge clk);
        rst = 1'b0;

        // ------------------------------------------------
        // Arithmetic Operations
        // ------------------------------------------------

        // Opcode 000 : Addition
        apply_test(8'h14, 8'h22, 3'b000);

        // Opcode 001 : Addition with carry-in
        apply_test(8'h14, 8'h22, 3'b001);

        // Carry test
        apply_test(8'hFF, 8'h01, 3'b000);

        // ------------------------------------------------
        // Logical Operations
        // ------------------------------------------------

        // Opcode 010 : AND
        apply_test(8'hF0, 8'h0F, 3'b010);

        // Opcode 011 : OR
        apply_test(8'hF0, 8'h0F, 3'b011);

        // Opcode 100 : XOR
        apply_test(8'hF0, 8'h0F, 3'b100);

        // Opcode 101 : NOT A
        apply_test(8'h0F, 8'h00, 3'b101);

        // ------------------------------------------------
        // Shift Operations
        // ------------------------------------------------

        // Opcode 110 : Logical left shift
        apply_test(8'h12, 8'h00, 3'b110);

        // Opcode 111 : Logical right shift
        apply_test(8'h12, 8'h00, 3'b111);

        // ------------------------------------------------
        // Zero flag test
        // ------------------------------------------------

        // 0 + 0 = 0
        apply_test(8'h00, 8'h00, 3'b000);

        // Finish simulation
        repeat (2) @(posedge clk);

        $display("--------------------------------------------");
        $display("ALU TESTBENCH COMPLETED");
        $display("--------------------------------------------");

        $finish;
    end

endmodule