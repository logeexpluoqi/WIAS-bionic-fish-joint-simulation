% @Author: luoqi 
% @Date: 2021-01-23 14:26:10 
% @Last Modified by:   luoqi 

function f_set_zero(id_list)
    mode = 3;
    [~, num] = size(id_list);
    com = seriallist;
    serial_port = f_set_serialport(com);
    msg = uint8(zeros(1, num + 6));
    msg(1) = uint8(123); % '{', start of frame
    msg(num + 6) = uint8(125); % '}', end of frame
    msg(2) = mode;
    msg(3) = num;
    for i=1:num
       msg(3+i) = id_list(i);
    end

    write(serial_port, msg, "uint8");
    rx = read(serial_port, 14, "uint8");
    fprintf("%s\n",rx);
    
    clear serial_port;
end