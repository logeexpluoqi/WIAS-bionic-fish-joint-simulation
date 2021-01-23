% @Author: luoqi 
% @Date: 2021-01-22 20:31:25 
% @Last Modified by:   luoqi 

clear; clc;

%% Parameter initialize
T_LIMIT = 100000;
MOTOR_NUM  = 4;

mode  = 4; 
P_dst = zeros(MOTOR_NUM, 1);
V_dst = zeros(MOTOR_NUM, 1);
T_dst = zeros(MOTOR_NUM, 1);
Kp    = zeros(MOTOR_NUM, 1);
Kd    = zeros(MOTOR_NUM, 1);

motor_id            = [1, 2, 3, 4];
motor_feedback_data = zeros(T_LIMIT, 3, MOTOR_NUM);
motor_input         = zeros(MOTOR_NUM, T_LIMIT, 3);

%% Motor motion curve
for i = 1:1:MOTOR_NUM
    motor_input(MOTOR_NUM, :, 1) = sin(T_LIMIT); % P curve
    motor_input(MOTOR_NUM, :, 2) = sin(T_LIMIT); % V curve
    motor_input(MOTOR_NUM, :, 3) = sin(T_LIMIT); % T curve
end

%% Data distribute
motor_ctrl_data = zeros(MOTOR_NUM, T_LIMIT, 6);
for num = 1:1:MOTOR_NUM
    motor_ctrl_data(num, :, 1) = motor_id(num);
    motor_ctrl_data(num, :, 5) = Kp(num);
    motor_ctrl_data(num, :, 6) = Kd(num);
end


%% Unlock motor
if mode == 1
    for num = 1:1:MOTOR_NUM
        unlock_motor(motor_id(num));
    end

%% Lock motor
elseif mode == 2
    for num = 1:1:MOTOR_NUM
        lock_motor(motor_id(num));
    end

%% Set zero
elseif mode == 3
    for num = 1:1:MOTOR_NUM
        set_zero(motor_id(num))
    end

%% Control data frame define
elseif mode == 4
    serial_port = serialport("COM3", 115200, 'Timeout', 0.1);

    msg = uint8(zeros(1, 30));
    msg(1) = uint8(123); % '{', start of frame
    msg(30) = uint8(125); % '}', end of frame
    msg(4) = mode;

    %% Control motor
    for t = 1:1:T_LIMIT

        for num = 1:1:MOTOR_NUM
            id = motor_ctrl_data(num, t, 1);
            [P_h, P_l]   = msg_float_to_char(motor_ctrl_data(num, t, 2));
            [V_h, V_l]   = msg_float_to_char(motor_ctrl_data(num, t, 3));
            [T_h, T_l]   = msg_float_to_char(motor_ctrl_data(num, t, 4));
            [Kp_h, Kp_l] = msg_float_to_char(motor_ctrl_data(num, t, 5));
            [Kd_h, Kd_l] = msg_float_to_char(motor_ctrl_data(num, t, 6));

            send_data = [id, P_h, P_l, V_h, V_l, T_h, T_l, Kp_h, Kp_l, Kd_h, Kd_l];

            msg(3:13) = send_data; 
            write(serial_port, msg, "uint8");
        end
    end
end