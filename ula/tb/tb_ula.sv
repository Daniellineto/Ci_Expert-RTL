`timescale 1ns/1ps

import ula_pkg::*;

module tb_ula;

    parameter WIDTH = 8;

    logic [WIDTH-1:0] a;
    logic [WIDTH-1:0] b;

    logic [1:0] op;

    logic [WIDTH-1:0] result;


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
    
    
    // Geração do dump FSDB 
    initial begin
        $fsdbDumpfile("waves.fsdb");
        $fsdbDumpvars(0, tb_ula);
    end


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

        op = SHL;
        #10
        $display("SHIFT LEFT -> result =%0d", result);

        $finish;

    end

endmodule