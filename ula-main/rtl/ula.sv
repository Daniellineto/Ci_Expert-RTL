`timescale 1ns/1ps

import ula_pkg::*;

module ula #(
    parameter WIDTH = 8
)(
    input  logic [WIDTH-1:0] a,
    input  logic [WIDTH-1:0] b,

    input  operation_t op,

    output logic [WIDTH-1:0] result
);

    always_comb begin

        case(operation_t'(op))

            NOP:  result = a + 0;
            ADD:  result = a + b;
            SUB:  result = a - b;
            MULT: result = a * b;
            SHL:  result = a << b;

            default: result = '0;

        endcase

    end

endmodule