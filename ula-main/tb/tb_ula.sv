`timescale 1ns/1ps

module tb_ula;

    parameter WIDTH = 8;

    logic [WIDTH-1:0] a;
    logic [WIDTH-1:0] b;

    logic [1:0] op;

    logic [WIDTH-1:0] result;

    // =========================
    // Opcodes locais do TB
    // =========================
    typedef enum logic [1:0] {
        NOP  = 2'b00,
        ADD  = 2'b01,
        SUB  = 2'b10,
        MULT = 2'b11
    } operation_t;

    // =========================
    // DUT
    // =========================
    ula #(
        .WIDTH(WIDTH)
    ) dut (
        .a(a),
        .b(b),
        .op(op),
        .result(result)
    );

    initial begin

        $display("Inicio da simulacao");

        a = 10;
        b = 5;

        op = NOP;
        #10
        $display("NOP  -> result = %0d", result);

        op = ADD;
        #10
        $display("ADD  -> result = %0d", result);

        op = SUB;
        #10
        $display("SUB  -> result = %0d", result);

        op = MULT;
        #10
        $display("MULT -> result = %0d", result);

        $finish;

    end

endmodule