function [chr_1, chr_0] = msg_float_to_char(num)

num = int16(num*100);
if num < 0
    num = -num;
    chr_1 = uint8(bitor(bitshift(num, -8), 128));
    chr_0 = uint8(bitand(num, 255));
else
    chr_1 = uint8(bitshift(num,-8));
    chr_0 = uint8(bitand(num, 255));
end