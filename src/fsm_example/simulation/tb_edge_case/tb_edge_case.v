// Author : Paul Capgras
// Date : Sep 2025

`include "../../rtl/fsm_example.v"

module tb_edge_case ();

    parameter integer CLK_PERIOD = 10;

    reg  arstn;
    reg  clk;
    reg  data;
    wire E;
    wire Z;

    fsm_example DUT (
        .arstn(arstn),
        .clk  (clk),
        .data (data),
        .E    (E),
        .Z    (Z)
    );

    initial begin
        $dumpfile("./cache/tb_edge_case.vcd");
        $dumpvars(0, tb_edge_case);
    end

    ///////////////////////////////////
    //           Clock               //
    ///////////////////////////////////

    initial begin
        clk = 0;
    end

    always #(CLK_PERIOD / 2) clk = ~clk;

    ///////////////////////////////////
    //           Test                //
    //     Using vector test         //
    ///////////////////////////////////

    // Vector : MSB - 00100101001111010111011[1] - LSB

    initial begin
        data  <= 0;
        arstn <= 0;

        // Reset
        arstn <= 0;
        wait_clk_cycles(1);
        arstn <= 1;

        // Test

        // in S0
        check_outputs(0, 0);
        data <= 1;  // Vector : MSB - 00100101001111010111011[1] - LSB
        wait_clk_cycles(1);

        // in S1
        check_outputs(0, 0);
        data <= 1;  // Vector : MSB - 0010010100111101011101[1]- - LSB
        wait_clk_cycles(1);

        // in S2
        check_outputs(0, 0);
        data <= 1;  // Vector : MSB - 001001010011110101110[1]-- - LSB
        wait_clk_cycles(1);

        // in S2 (again)
        check_outputs(0, 0);
        data <= 0;  // Vector : MSB - 00100101001111010111[0]--- - LSB
        wait_clk_cycles(1);

        // in S3
        check_outputs(0, 1);
        data <= 1;  // Vector : MSB - 0010010100111101011[1]---- - LSB
        wait_clk_cycles(1);

        // in S1
        check_outputs(0, 0);
        data <= 1;  // Vector : MSB - 001001010011110101[1]----- - LSB
        wait_clk_cycles(1);

        // in S2
        check_outputs(0, 0);
        data <= 1;  // Vector : MSB - 00100101001111010[1]------ - LSB
        wait_clk_cycles(1);

        // in S2 (again)
        check_outputs(0, 0);
        data <= 0;  // Vector : MSB - 0010010100111101[0]------- - LSB
        wait_clk_cycles(1);

        // in S3
        check_outputs(0, 1);
        data <= 1;  // Vector : MSB - 001001010011110[1]-------- - LSB
        wait_clk_cycles(1);

        // in S1
        check_outputs(0, 0);
        data <= 0;  // Vector : MSB - 00100101001111[0]--------- - LSB
        wait_clk_cycles(1);

        // in S4
        check_outputs(0, 0);
        data <= 1;  // Vector : MSB - 0010010100111[1]---------- - LSB
        wait_clk_cycles(1);

        // in S1
        check_outputs(0, 0);
        data <= 1;  // Vector : MSB - 001001010011[1]----------- - LSB
        wait_clk_cycles(1);

        // in S2
        check_outputs(0, 0);
        data <= 1;  // Vector : MSB - 00100101001[1]------------ - LSB
        wait_clk_cycles(1);

        // in S2 (again)
        check_outputs(0, 0);
        data <= 1;  // Vector : MSB - 0010010100[1]------------- - LSB
        wait_clk_cycles(1);

        // in S2 (again..)
        check_outputs(0, 0);
        data <= 0;  // Vector : MSB - 001001010[0]-------------- - LSB
        wait_clk_cycles(1);

        // in S3
        check_outputs(0, 1);
        data <= 0;  // Vector : MSB - 00100101[0]--------------- - LSB
        wait_clk_cycles(1);

        // in S5
        check_outputs(0, 0);
        data <= 1;  // Vector : MSB - 0010010[1]---------------- - LSB
        wait_clk_cycles(1);

        // in S6
        check_outputs(1, 0);
        data <= 0;  // Vector : MSB - 001001[0]----------------- - LSB
        wait_clk_cycles(1);

        // in S6 (Dead end)
        check_outputs(1, 0);
        data <= 1;  // Vector : MSB - 00100[1]------------------ - LSB
        wait_clk_cycles(1);

        // in S6 (Dead end)
        check_outputs(1, 0);
        data <= 0;  // Vector : MSB - 0010[0]------------------- - LSB
        wait_clk_cycles(1);

        // in S6 (Dead end)
        check_outputs(1, 0);
        data <= 0;  // Vector : MSB - 001[0]-------------------- - LSB
        wait_clk_cycles(1);

        // in S6 (Dead end)
        check_outputs(1, 0);
        data <= 1;  // Vector : MSB - 00[1]--------------------- - LSB
        wait_clk_cycles(1);

        // in S6 (Dead end)
        check_outputs(1, 0);
        data <= 0;  // Vector : MSB - 0[0]---------------------- - LSB
        wait_clk_cycles(1);

        // in S6 (Dead end)
        check_outputs(1, 0);
        data <= 0;  // Vector : MSB - [0]----------------------- - LSB
        wait_clk_cycles(1);

        $display("TEST tb_edge_case PASSED");
        $finish;
    end

    task automatic check_outputs(input integer value_E, input integer value_Z);
        begin
            #(CLK_PERIOD / 10);
            if (E != value_E) begin
                $display("FAIL : E should be equal to %b but was equal to %b", value_E, E);
                $finish;
            end
            if (Z != value_Z) begin
                $display("FAIL : Z should be equal to %b but was equal to %b", value_Z, Z);
                $finish;
            end
        end
    endtask

    task automatic wait_clk_cycles(input integer clk_cycles);
        integer i;
        begin
            for (i = 0; i < clk_cycles; i = i + 1) begin
                @(posedge clk);
            end
        end
    endtask

endmodule
