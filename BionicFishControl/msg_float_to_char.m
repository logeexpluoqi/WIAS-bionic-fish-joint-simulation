% @Author: luoqi 
% @Date: 2021-01-22 20:58:21 
% @Last Modified by:   luoqi 
% @Last Modified time: 2021-01-22 20:58:21 

function [chr_1, chr_0] = msg_float_to_char(num)
% 
% [chr_1, chr_0] = msg_float_to_char(num)
%
% A float data convert to two char data.
% Notation: num*100 must less than 16 bits
% @ mum: input data;
% @ chr_1: output char 1, higher 8 bit; 
% @ chr_0: output char 0, lower 8 bit.

num = int16(num*100);
if num < 0
    num = -num;
    chr_1 = uint8(bitor(bitshift(num, -8), 128));
    chr_0 = uint8(bitand(num, 255));
else
    chr_1 = uint8(bitshift(num,-8));
    chr_0 = uint8(bitand(num, 255));
end