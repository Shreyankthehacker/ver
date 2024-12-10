module MultiCycleALUmem (
    input clk,                 // Clock signal
    input reset,               // Reset signal
    input start,               // Start signal
    input [1:0] A,             // 2-bit input A
    input [1:0] B,             // 2-bit input B
    input [2:0] Op,            // Operation selector (ALU and memory ops)
    input [3:0] Address,       // Memory address for load/store
    output reg [2:0] Y,        // ALU result
    output reg [2:0] MemOut,   // Data from memory (load result)
    output reg done            // Done signal
);
    // Memory declaration
    reg [2:0] Memory [0:15];   // Simple 16x3-bit memory
    reg [2:0] temp_result;     // Temporary result register

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        EXECUTE = 3'b001,
        MEMORY_READ = 3'b010,
        MEMORY_WRITE = 3'b011,
        WRITEBACK = 3'b100
    } state_t;

    state_t current_state, next_state;

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
                    next_state = (Op[2]) ? ((Op[1]) ? MEMORY_WRITE : MEMORY_READ) : EXECUTE;
                else
                    next_state = IDLE;

            EXECUTE: 
                next_state = WRITEBACK;

            MEMORY_READ: 
                next_state = WRITEBACK;

            MEMORY_WRITE: 
                next_state = IDLE;

            WRITEBACK: 
                next_state = IDLE;

            default: 
                next_state = IDLE;
        endcase
    end

    // Output and operation logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            temp_result <= 3'b000;
            Y <= 3'b000;
            MemOut <= 3'b000;
            done <= 1'b0;
        end else begin
            case (current_state)
                IDLE: 
                    done <= 1'b0;

                EXECUTE: begin
                    case (Op[1:0])
                        2'b00: temp_result <= A + B;  // Addition
                        2'b01: temp_result <= A - B;  // Subtraction
                        2'b10: temp_result <= A & B;  // AND
                        2'b11: temp_result <= A | B;  // OR
                        default: temp_result <= 3'b000;
                    endcase
                end

                MEMORY_READ: 
                    MemOut <= Memory[Address];

                MEMORY_WRITE: 
                    Memory[Address] <= A;

                WRITEBACK: begin
                    Y <= temp_result;
                    done <= 1'b1;
                end
            endcase
        end
    end
endmodule
