`include "../../rtl/adder.v"

module tb_full_behavior ();

    reg data_1, data_2;
    wire sum;

    adder DUT (
        .data_1_i(data_1),
        .data_2_i(data_2),
        .sum_o   (sum)
    );

    initial begin
        $dumpfile("./cache/tb_full_behavior.vcd");
        $dumpvars(0, tb_full_behavior);
    end

    initial begin
        data_1 = 0;
        data_2 = 0;
        #1 sum_should_equal(0);
        data_1 = 0;
        data_2 = 1;
        #1 sum_should_equal(1);
        data_1 = 1;
        data_2 = 0;
        #1 sum_should_equal(1);
        data_1 = 1;
        data_2 = 1;
        #1 sum_should_equal(0);
        $display("TEST tb_full_behavior PASSED");
        $finish;
    end

    task sum_should_equal(input reg value);
        begin
            if (sum !== value) begin
                $display("FAIL : sum should be equal to %b but was equal to %b", value, sum);
                $finish;
            end
        end
    endtask

endmodule
