module MultiCycleALU (
    input clk,                // Clock signal
    input reset,              // Reset signal
    input start,              // Start signal
    input [1:0] A,            // 2-bit input A
    input [1:0] B,            // 2-bit input B
    input [1:0] Op,           // Operation selector
    output reg [2:0] Y,       // 3-bit output
    output reg done           // Done signal
);
    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        EXECUTE = 2'b01,
        WRITEBACK = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Internal registers
    reg [2:0] temp_result;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= IDLE;
        else 
            current_state <= next_state;
    end

    // Next-state logic
    always @(*) begin
        case (current_state)
            IDLE: 
                if (start)
                    next_state = EXECUTE;
                else
                    next_state = IDLE;

            EXECUTE: 
                next_state = WRITEBACK;

            WRITEBACK: 
                next_state = IDLE;

            default: 
                next_state = IDLE;
        endcase
    end

    // Output and internal operation logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            temp_result <= 3'b000;
            Y <= 3'b000;
            done <= 1'b0;
        end else begin
            case (current_state)
                IDLE: begin
                    done <= 1'b0;
                end

                EXECUTE: begin
                    case (Op)
                        2'b00: temp_result <= A + B;  // Addition
                        2'b01: temp_result <= A - B;  // Subtraction
                        2'b10: temp_result <= A & B;  // Bitwise AND
                        2'b11: temp_result <= A | B;  // Bitwise OR
                        default: temp_result <= 3'b000;
                    endcase
                end

                WRITEBACK: begin
                    Y <= temp_result;
                    done <= 1'b1;
                end
            endcase
        end
    end
endmodule
