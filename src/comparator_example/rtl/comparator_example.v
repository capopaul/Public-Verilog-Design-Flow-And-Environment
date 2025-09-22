// Author: Paul Capgras
// Date  : Sept 2025

module comparator (
    input            rst,
    input            clk,
    input      [1:0] A,
    input      [1:0] B,
    output reg       A_gt_B_reg,
    output reg       A_eq_B_reg,
    output reg       A_lt_B_reg
);
    wire A_gt_B;
    wire A_eq_B;
    wire A_lt_B;

    assign A_gt_B = A > B;
    assign A_eq_B = A == B;
    assign A_lt_B = A < B;

    always @(posedge clk) begin
        if (rst) A_gt_B_reg <= 'd0;
        else A_gt_B_reg <= A_gt_B;
    end

    always @(posedge clk) begin
        if (rst) A_eq_B_reg <= 'd0;
        else A_eq_B_reg <= A_eq_B;
    end

    always @(posedge clk) begin
        if (rst) A_lt_B_reg <= 'd0;
        else A_lt_B_reg <= A_lt_B;
    end

endmodule
