// Author: Paul Capgras
// Date  : Sept 2025

`include "../../rtl/comparator_example.v"

module tb_full_behavior ();

    parameter integer CLK_PERIOD = 10;

    reg           rst;
    reg           clk;
    reg     [1:0] A;
    reg     [1:0] B;
    wire          A_gt_B_reg;
    wire          A_eq_B_reg;
    wire          A_lt_B_reg;

    integer       int_A;
    integer       int_B;

    initial begin
        $dumpfile("./cache/tb_full_behavior.vcd");
        $dumpvars(0, tb_full_behavior);
    end

    // Design Under Test : Comparator

    comparator comparator (
        .rst       (rst),
        .clk       (clk),
        // Inputs
        .A         (A),
        .B         (B),
        // Outputs
        .A_gt_B_reg(A_gt_B_reg),
        .A_eq_B_reg(A_eq_B_reg),
        .A_lt_B_reg(A_lt_B_reg)
    );

    ///////////////////////////////////
    //           Clock               //
    ///////////////////////////////////

    initial begin
        clk = 0;
    end

    always #(CLK_PERIOD / 2) clk = ~clk;

    ///////////////////////////////////
    //           Test                //
    ///////////////////////////////////

    initial begin
        rst = 0;
        A   = 0;
        B   = 0;

        // Synchronous reset
        wait_clk_cycles(1);
        rst = 1;
        wait_clk_cycles(1);
        rst = 0;
        #(CLK_PERIOD / 10);

        check_A_gt_B_reg_equals(0);
        check_A_eq_B_reg_equals(0);
        check_A_lt_B_reg_equals(0);

        // Main test
        for (int_A = 0; int_A < 4; int_A = int_A + 1) begin
            for (int_B = 0; int_B < 4; int_B = int_B + 1) begin
                A <= int_A[1:0];
                B <= int_B[1:0];
                wait_clk_cycles(1);
                check_outputs();
                wait_clk_cycles(1);
            end
        end

        // Test Synchronous reset again
        wait_clk_cycles(1);
        rst = 1;
        wait_clk_cycles(1);
        rst = 0;
        #(CLK_PERIOD / 10);

        check_A_gt_B_reg_equals(0);
        check_A_eq_B_reg_equals(0);
        check_A_lt_B_reg_equals(0);

        $display("TEST tb_full_behavior PASSED");
        $finish;
    end

    task automatic wait_clk_cycles(input integer clk_cycles);
        integer i;
        begin
            for (i = 0; i < clk_cycles; i = i + 1) begin
                @(posedge clk);
            end
        end
    endtask

    task automatic check_A_gt_B_reg_equals(input integer value);
        begin
            if (A_gt_B_reg != value) begin
                $display("FAIL : A_gt_B_reg should be equal to %b but was equal to %b", value,
                         A_gt_B_reg);
                $finish;
            end
        end
    endtask

    task automatic check_A_eq_B_reg_equals(input integer value);
        begin
            if (A_eq_B_reg != value) begin
                $display("FAIL : A_eq_B_reg should be equal to %b but was equal to %b", value,
                         A_eq_B_reg);
                $finish;
            end
        end
    endtask

    task automatic check_A_lt_B_reg_equals(input integer value);
        begin
            if (A_lt_B_reg != value) begin
                $display("FAIL : A_lt_B_reg should be equal to %b but was equal to %b", value,
                         A_lt_B_reg);
                $finish;
            end
        end
    endtask

    task automatic check_outputs();
        begin
            #(CLK_PERIOD / 10);
            check_A_gt_B_reg_equals(A > B);
            check_A_eq_B_reg_equals(A == B);
            check_A_lt_B_reg_equals(A < B);
        end
    endtask

endmodule
