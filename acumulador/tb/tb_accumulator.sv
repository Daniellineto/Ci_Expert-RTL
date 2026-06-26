module tb_accumulator;

    // Importamos o package para ter acesso ao tipo enumerado operation_t e suas constantes.
    import accumulator_pkg::*;

    // Definimos a largura do acumulador e dos dados de entrada.
    parameter WIDTH = 8;
    
    logic clk; // Sinal de clock para o DUT
    logic rst;
    logic enable;

    logic [1:0] op;
    logic [WIDTH-1:0] data_in;

    logic [WIDTH-1:0] acc;

    //------------------------------------
    // DUT
    //------------------------------------
    accumulator #(
        .WIDTH(WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .op(op),
        .data_in(data_in),
        .acc(acc)
    );

    //------------------------------------
    // Clock de 10 ns
    // Esse bloco gera um clock de 10 ns, alternando o sinal clk a cada 5 ns.
    //------------------------------------
    
    always #5 clk = ~clk;

    //------------------------------------
    // Dump para waveform
    //------------------------------------
    initial begin
        $fsdbDumpfile("waves.fsdb");
        $fsdbDumpvars(0, tb_accumulator);
    end

    //------------------------------------
    // Estímulos
    //------------------------------------
    initial begin

        clk     = 0;
        rst     = 1;
        enable  = 0;
        op      = HOLD;
        data_in = 0;

        //--------------------------------
        // Reset
        //--------------------------------
        #20 begin // Após 20 ns, desativamos o reset e habilitamos o acumulador.
            rst    = 0;
            enable = 1;
        end

        //--------------------------------
        // LOAD 20
        //--------------------------------
        @(posedge clk); // Dessa forma o lint do VCS dá um warning

        op = LOAD;
        data_in = 20;

        @(posedge clk) begin // Dessa forma o lint do VCS não dá warning mas fica muito verboso
            #1; // O #1 é para garantir que o valor de acc seja atualizado antes de imprimir.
            $display("LOAD 20  -> acc = %0d", acc);
        end

        //--------------------------------
        // ADD 5
        //--------------------------------
        op = ADD;
        data_in = 5;

        @(posedge clk)

        #1;
        
        $display("ADD 5    -> acc = %0d", acc);
        

        //--------------------------------
        // ADD 7
        //--------------------------------
        data_in = 7;

        @(posedge clk)
        #1;
        $display("ADD 7    -> acc = %0d", acc);

        //--------------------------------
        // SUB 10
        //--------------------------------
        op = SUB;
        data_in = 10;

        @(posedge clk)
        #1;
        $display("SUB 10   -> acc = %0d", acc);


        //--------------------------------
        // HOLD
        //--------------------------------
        op = HOLD;

        @(posedge clk)
        #1;
        $display("HOLD     -> acc = %0d", acc);

        //--------------------------------
        // enable = 0
        //--------------------------------
        enable = 0;

        op = ADD;
        data_in = 100;

        @(posedge clk)
        #1;
        $display("enable=0 -> acc = %0d", acc);

        //--------------------------------
        // Reabilita e carrega 100
        //--------------------------------
        enable = 1;
        op = LOAD;
        data_in = 100;

        @(posedge clk)
        #1;
        $display("LOAD 100 -> acc = %0d", acc);


        #20; // Espera um pouco antes de finalizar
             // a simulação para garantir que todas as mensagens sejam exibidas.
        
        $finish;

    end

endmodule