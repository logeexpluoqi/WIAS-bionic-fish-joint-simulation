% @Author: luoqi 
% @Date: 2021-01-23 14:26:10 
% @Last Modified by:   luoqi 

function state = f_set_zero(id)
    mode = 3;
    P  = 0; V  = 0; T = 0;
    Kp = 0; Kd = 0;

    port = seriallist;
    serial_port = serialport (port, 921600, 'Timeout', 0.1);
    msg = uint8(zeros(1, 30));
    msg(1)  = uint8(123); % '{', start of frame
    msg(30) = uint8(125); % '}', end of frame
    msg(2)  = mode;
    
    [P_h, P_l]   = f_msg_float_to_char(P);
    [V_h, V_l]   = f_msg_float_to_char(V);
    [T_h, T_l]   = f_msg_float_to_char(T);
    [Kp_h, Kp_l] = f_msg_float_to_char(Kp);
    [Kd_h, Kd_l] = f_msg_float_to_char(Kd);

    motor_ctrl_data = [id, P_h, P_l, V_h, V_l, T_h, T_l, Kp_h, Kp_l, Kd_h, Kd_l];
    msg(3:13) = motor_ctrl_data; 
    
    write(serial_port, msg, "uint8");
    rx = read(serial_port, 9, "uint8");
    if rx(1) == '{' && rx(9) == '}'
        fprintf("\nID: %d, %s\n\n", id,rx(2:8));
        state = "OK";
    else
        fprintf("\n**** error ****\n\n");
        state = "ERROR";
    end
    clear serial_port;
end