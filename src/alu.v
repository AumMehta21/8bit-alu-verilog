module alu #(parameter WIDTH = 8)(
    input  [WIDTH-1:0] A,
    input  [WIDTH-1:0] B,
    input  [2:0] sel,

    output reg [WIDTH-1:0] result,
    output zero,
    output negative,
    output carry,
    output overflow
);

    reg [WIDTH:0] temp;

    always @(*) begin
        temp = 0;
        result = 0;

        case (sel)
            3'b000: begin // ADD
                temp = A + B;
                result = temp[WIDTH-1:0];
            end

            3'b001: begin // SUB
                temp = A + (~B + 1);
                result = temp[WIDTH-1:0];
            end

            3'b010: result = A & B;
            3'b011: result = A | B;
            3'b100: result = A ^ B;
            3'b101: result = A << 1;
            3'b110: result = A >> 1;
            3'b111: result = ~A;

            default: result = 0;
        endcase
    end

    // FLAGS
    assign zero = (result == 0);
    assign negative = result[WIDTH-1];
    assign carry = temp[WIDTH];

    assign overflow =
        (sel == 3'b000) ? ((A[WIDTH-1] == B[WIDTH-1]) &&
                           (result[WIDTH-1] != A[WIDTH-1])) :

        (sel == 3'b001) ? ((A[WIDTH-1] != B[WIDTH-1]) &&
                           (result[WIDTH-1] != A[WIDTH-1])) :

        1'b0;

endmodule
