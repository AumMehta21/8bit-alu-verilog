`timescale 1ns/1ps

module alu_tb;

    reg [7:0] A, B;
    reg [2:0] sel;

    wire [7:0] result;
    wire zero, negative, carry, overflow;

    alu uut (
        .A(A),
        .B(B),
        .sel(sel),
        .result(result),
        .zero(zero),
        .negative(negative),
        .carry(carry),
        .overflow(overflow)
    );

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        $display("START SIM");

        // ADD
        A = 10; B = 5; sel = 3'b000; #10;
        $display("ADD done");

        // ADD overflow
        A = 127; B = 1; sel = 3'b000; #10;
        $display("ADD overflow done");

        // SUB
        A = 5; B = 10; sel = 3'b001; #10;
        $display("SUB done");

        // AND
        A = 8'b10101010; B = 8'b11001100; sel = 3'b010; #10;

        // OR
        sel = 3'b011; #10;

        // XOR
        sel = 3'b100; #10;

        // SHIFT LEFT
        A = 8'b00001111; sel = 3'b101; #10;

        // SHIFT RIGHT
        sel = 3'b110; #10;

        // COMPLEMENT
        sel = 3'b111; #10;

        // ZERO TEST
        A = 0; B = 0; sel = 3'b000; #10;

        $display("END SIM");
        $finish;
    end

endmodule
