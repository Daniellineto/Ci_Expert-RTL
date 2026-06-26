module accumulator #(
    /* 
     * Esse parâmetro define a largura do acumulador e dos dados de entrada.
     * Ele é configurável para permitir flexibilidade no design,
     * podendo ser ajustado conforme as necessidades do projeto.
     */
    parameter WIDTH = 8
)(
    input  logic              clk,
    input  logic              rst,
    input  logic              enable,

    input  logic [1:0]        op,
    input  logic [WIDTH-1:0]  data_in,

    output logic [WIDTH-1:0]  acc
);

    // Dessa forma, criamos um tipo enumerado para representar as operações que o acumulador pode realizar.
    // Usando um package, podemos definir esse tipo de forma centralizada,
    // facilitando a manutenção e a legibilidade do código.
    import accumulator_pkg::*;

    // --------------------------------
    // Aqui está a novidade: usamos um always_ff para descrever o comportamento do acumulador.
    // O always_ff é uma construção específica para descrever lógica sequencial, ou seja, 
    // lógica que depende de um clock.
    // Poderíamos fazer isso apenas com bloco always, mas o always_ff é mais específico
    // e ajuda a evitar erros comuns em lógica sequencial.
    // --------------------------------
    always_ff @(posedge clk) begin

        if (rst) // Se o sinal de reset estiver ativo, o acumulador é zerado.
            // O operador <= é usado para atribuição não bloqueante,
            // que é a forma correta de atribuir valores em lógica sequencial.    
            acc <= '0; 

        else if (enable) begin

            case (operation_t'(op))

                HOLD: acc <= acc;

                LOAD: acc <= data_in;

                ADD : acc <= acc + data_in;

                SUB : acc <= acc - data_in;

                default: acc <= '0;

            endcase

        end

    end

endmodule