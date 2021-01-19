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