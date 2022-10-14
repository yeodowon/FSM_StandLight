`timescale 1ns / 1ps

module comperator(
    input [9:0] i_counter,
    output o_light_1, o_light_2, o_light_3, o_light_4 
    );

    assign o_light_1= (i_counter <300) ? 1'b1 : 1'b0; // i_counter가 300보다 작으면 
    assign o_light_2= (i_counter <600) ? 1'b1 : 1'b0;
    assign o_light_3= (i_counter <800) ? 1'b1 : 1'b0;
    assign o_light_4= (i_counter <900) ? 1'b1 : 1'b0;

endmodule
