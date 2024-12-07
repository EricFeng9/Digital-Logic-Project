`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/06 19:01:29
// Design Name: 
// Module Name: edge_detect_100Hz
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module edge_detect_100Hz(
    input clk_100Hz,         // ʱ���ź�
    input rst_n,       // ��λ�ź�
    input key_in,      // �ȶ��İ����źţ�debounced��
    output reg press_once  // ���ɰ��������źţ�����һ�Σ�
    );
    reg key_in_dly;  // �����źŵ��ӳٰ汾

    always @(posedge clk_100Hz, negedge rst_n) begin
        if (~rst_n) begin
            key_in_dly <= 0;
            press_once <= 0;
        end else begin
            key_in_dly <= key_in;  // ������һ�����ڵİ����ź�

            // ��ⰴ����������
            if (key_in && ~key_in_dly)
                press_once <= 1;  // ��������ʱ���� press_once �ź�
            else
                press_once <= 0;  // δ����ʱ��� press_once �ź�
        end
    end
endmodule

