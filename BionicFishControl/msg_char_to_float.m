% num = msg_char_to_float(chr_1, chr_0)
% Two char data convert to a float data.
% @ chr_1: input char 1, higher byte;
% @ chr_0: input cahr 2, lower byte;
% @ num: output float data.

% @Author: luoqi 
% @Date: 2021-01-22 20:57:40 
% @Last Modified by:   luoqi 
% @Last Modified time: 2021-01-22 20:57:40 

function num = msg_char_to_float(chr_1, chr_0)
    chr_1 = uint16(chr_1);
    chr_0 = uint16(chr_0);
    if bitand(chr_1, 128) == 128
        num = -int16(bitor(bitshift(bitand(chr_1, 127), 8), chr_0)); 
    else
        num = int16(bitor(bitshift(bitand(chr_1, 127), 8), chr_0));
    end
    num = double(num) / 100.0;
end