% @Author: luoqi 
% @Date: 2021-02-25 10:42:28 
% @Last Modified by:   luoqi

function msg = f_get_tx_msg(data, num, t)
    % data: motor control data
    % num: motor quantity
    % t: time
    msg             = uint8(zeros(1, 6 + num*11));
    msg(1)          = uint8(123); % '{', SOF
    msg(6 + num*11) = uint8(125); % '}', EOF

    msg(2) = 4; % motor conttrol mode
    msg(3) = num*11; % motor number
 
    for i = 1 : num
        msg((4 + (i-1)*11) : (14 + (i-1)*11)) = f_data_tx_convert(data, i, t);
    end
end
