// Author : Paul Capgras
// Date : Sep 2025

// Moore-style state machine
module fsm_example (
    input       arstn,
    input       clk,
    input       data,
    output wire E,
    output wire Z
);
    localparam S0 = 3'd0;
    localparam S1 = 3'd1;
    localparam S2 = 3'd2;
    localparam S3 = 3'd3;
    localparam S4 = 3'd4;
    localparam S5 = 3'd5;
    localparam S6 = 3'd6;

    reg [2:0] state_current;
    reg [2:0] state_next;

    always @(negedge arstn or posedge clk) begin
        if (!arstn) begin
            state_current <= S0;
        end else begin
            state_current <= state_next;
        end
    end

    always @(*) begin
        case (state_current)
            S0: begin
                if (data) state_next = S1;
                else state_next = S4;
            end

            S1: begin
                if (data) state_next = S2;
                else state_next = S4;
            end

            S2: begin
                if (data) state_next = S2;
                else state_next = S3;
            end

            S3: begin
                if (data) state_next = S1;
                else state_next = S5;
            end

            S4: begin
                if (data) state_next = S1;
                else state_next = S5;
            end

            S5: begin
                if (data) state_next = S6;
                else state_next = S5;
            end

            S6: begin
                state_next = S6;
            end

            default: state_next = S0;
        endcase
    end

    assign E = state_current == S6;
    assign Z = state_current == S3;

endmodule
