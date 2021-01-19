clear;
t = -30:0.01:30;

table = zeros(size(t));
j = 0;
for i = -30:0.01:30
    j = j+1;
    [chr_1, chr_0] = msg_float_to_char(i);
    table(j) = msg_char_to_float(chr_1, chr_0);
end
table = table';