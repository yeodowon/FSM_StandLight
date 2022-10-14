`timescale 1ns / 1ps

module top_lightStand(
    input i_clk,
    input i_reset,
    input [2:0] i_button,
    output o_light_led
    );
    
    wire w_clk_1MHz;

    clock_divider CLK_DIV(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .o_clk(w_clk_1MHz)
    );

   
    wire [9:0] w_counter;

    counter CNT(
    .i_clk(w_clk_1MHz),
    .i_reset(i_reset),
    .o_counter(w_counter)
    );

   wire [3:0] w_light_pwm;

    comperator CMP(
    .i_counter(w_counter),
    .o_light_1(w_light_pwm[0]), 
    .o_light_2(w_light_pwm[1]), 
    .o_light_3(w_light_pwm[2]), 
    .o_light_4(w_light_pwm[3]) 
    );


    wire [2:0] w_button;

    button_controller BTN_OFF(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_button(i_button[2]),
    .o_button(w_button[2])
    );

    button_controller BTN_UP(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_button(i_button[0]),
    .o_button(w_button[0])
    );

    button_controller BTN_DOWN(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_button(i_button[1]),
    .o_button(w_button[1])
    );

    wire [2:0] w_light_state;

    FSM_Light FSM(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_button(w_button),
    .o_light_state(w_light_state)
    );

    mux MUX_4x1(
    .i_x(w_light_pwm),
    .sel(w_light_state),
    .o_y(o_light_led)
    );

endmodule
