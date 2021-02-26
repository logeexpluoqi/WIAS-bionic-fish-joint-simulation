% @Author: luoqi 
% @Date: 2021-02-25 10:42:28 
% @Last Modified by:   luoqi

function motor_feedback = f_motor_ctrl(data, num, t, serial_port)
    % data: motor control data
    % num: motor quantity
    % t: time
    % motor_feedback: 4 row x 4 col
    %                 row: different motor data
    msg = uint8(zeros(1, 6 + num*11));
    motor_feedback = zeros(num, 4);
    msg(1) = uint8(123); % '{', SOF
    msg(6 + num*11) = uint8(125); % '}', EOF

    msg(2) = 4; % motor conttrol mode
    msg(3) = num; % motor number

    for i = 0 : num
        msg((4 + num*11) : (14 + num*11)) = f_data_tx_convert(data, i, t);
    end

    write(serial_port, msg, "uint8");
    try
        rx = read(serial_port, 6 + num*7, "uint8");
        for i = 0 : num
            rx_data = f_data_rx_convert(rx((4 + i*7) : (10 + i*7)));
            motor_feedback(i+1, 1) = rx_data(1);
            motor_feedback(i+1, 2) = rx_data(2);
            motor_feedback(i+1, 3) = rx_data(3);
            motor_feedback(i+1, 4) = rx_data(4);
        end
    catch
        f_lock_motor(data(:,:,1));
    end
end
