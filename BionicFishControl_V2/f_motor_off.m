% @Author: luoqi 
% @Date: 2021-01-23 14:25:20 
% @Last Modified by:   luoqi 

function f_motor_off(id_list)
    mode = 2;
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
    rx = read(serial_port, num*2 + 6, "uint8");
    
    if (rx(1) == '{') && (rx(num*2 + 6) == '}') && (rx(2) == 2) && ((rx(3) + 6) == (num*2 + 6))
        fprintf(" ** MOTOR POWER OFF ** \n ");
        for i=1:num
            fprintf("   ID: %2d, ", rx(4+(i-1)*2));
            fprintf("State: %d\n ", rx(5+(i-1)*2));
        end 
    else
        fprintf("** MOTOR OFF FEEDBACK ERROR ! **\n");
        fprintf("%s\n",rx);
    end
    
    clear serial_port;
end