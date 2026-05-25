`timescale 1ns/1ps

package ula_pkg;
    // =========================
    // Enum dos opcodes
    // =========================
    typedef enum logic [2:0] {
        NOP  = 3'b000,
        ADD  = 3'b001,
        SUB  = 3'b010,
        MULT = 3'b011,
        SHL  = 3'b100 
    } operation_t;

endpackage