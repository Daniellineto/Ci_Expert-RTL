`timescale 1ns/1ps

module ula #(
    parameter WIDTH = 8
)(
    input  logic [WIDTH-1:0] a,
    input  logic [WIDTH-1:0] b,

    input  logic [1:0] op,

    output logic [WIDTH-1:0] result
);

    // =========================
    // Enum dos opcodes
    // =========================
    typedef enum logic [1:0] {
        NOP  = 2'b00,
        ADD  = 2'b01,
        SUB  = 2'b10,
        MULT = 2'b11
    } operation_t;

    always_comb begin

        case(operation_t'(op))

            NOP:  result = a + 0;
            ADD:  result = a + b;
            SUB:  result = a - b;
            MULT: result = a * b;

            default: result = '0;

        endcase

    end

endmodule