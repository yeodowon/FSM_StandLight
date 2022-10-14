`timescale 1ns / 1ps

module FSM_Light(
    input i_clk,
    input i_reset,
    input [2:0]i_button,
    output [2:0]o_light_state
    );

    parameter S_LED_000 = 3'b000,  // c언어에서 enum 역할, 상태 정의
              S_LED_001 = 3'b001,
              S_LED_010 = 3'b010,
              S_LED_011 = 3'b011,
              S_LED_100 = 3'b100;
             

    reg [2:0] curState, nextState;
    reg [3:0] r_light;

    assign o_light_state = r_light;

//상태 변경 적용
    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset) curState <= S_LED_000;
        else curState <= nextState;
    end

//이벤트 처리 부분
    always @(curState or i_button) begin
        case (curState)
            S_LED_000 : begin
                if (i_button[0])      nextState <= S_LED_001;
                else if (i_button[2]) nextState <= S_LED_000;
                else                  nextState <= S_LED_000;
            end 
            S_LED_001 : begin
                if (i_button[0])      nextState <= S_LED_010;
                else if (i_button[1]) nextState <= S_LED_000;
                else if (i_button[2]) nextState <= S_LED_000;
                else                  nextState <= S_LED_001;
            end
            S_LED_010 : begin
                if (i_button[0])      nextState <= S_LED_011;
                else if (i_button[1]) nextState <= S_LED_001;
                else if (i_button[2]) nextState <= S_LED_000;
                else                  nextState <= S_LED_010;
            end
            S_LED_011 : begin
                if (i_button[0])      nextState <= S_LED_100;
                else if (i_button[1]) nextState <= S_LED_010;
                else if (i_button[2]) nextState <= S_LED_000;
                else                  nextState <= S_LED_011;
            end
             S_LED_100 : begin
                if (i_button[1])      nextState <= S_LED_011;
                else if (i_button[2]) nextState <= S_LED_000;
                else                   nextState <= S_LED_100;
            end 
          

        endcase
    end
    
//상태에 따른 동작 부분
    always @(curState) begin
        r_light <= 3'b000;
        case (curState)
            S_LED_000 : r_light <= 3'b000;  
            S_LED_001 : r_light <= 3'b001;  
            S_LED_010 : r_light <= 3'b010;  
            S_LED_011 : r_light <= 3'b011;  
            S_LED_100 : r_light <= 3'b100;  
        endcase
    end

endmodule
