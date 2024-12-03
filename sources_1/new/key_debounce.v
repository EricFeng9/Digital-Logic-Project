`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/02 20:36:08
// Design Name: 
// Module Name: key_debounce
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


module key_debounce (
    input wire clk,            // ʱ���ź�
    input wire rst_n,          // �����ź�
    input wire key_in,         // ��������
    output reg key_out         // ȥ����İ������
);

    // ����ȥ���ļ��������
    parameter DEBOUNCE_COUNT = 100000; // ������ֵ�����Ը���ʵ��ʱ��Ƶ�ʵ���

    // �����������״̬�Ĵ���
    reg [17:0] counter;        // ������
    reg key_in_sync_1, key_in_sync_2; // ͬ���Ĵ���������ʱ�Ӷ���Ӱ��

    // ͬ�������ź�
    always @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            key_in_sync_1 <= 1'b0;
            key_in_sync_2 <= 1'b0;
        end else begin
            key_in_sync_1 <= key_in;
            key_in_sync_2 <= key_in_sync_1;
        end
    end

    // ����ȥ���߼�
    always @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            counter <= 18'b0;
            key_out <= 1'b0;
        end else begin
            if (key_in_sync_2 != key_out) begin
                counter <= counter + 1;
                if (counter == DEBOUNCE_COUNT) begin
                    key_out <= key_in_sync_2; // �������
                    counter <= 0; // ���ü�����
                end
            end else begin
                counter <= 0; // �������û�б仯�����ü�����
            end
        end
    end
endmodule

