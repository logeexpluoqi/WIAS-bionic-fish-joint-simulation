% @Author: luoqi 
% @Date: 2021-01-22 20:31:25 
% @Last Modified by:   luoqi 

clear; clc; close all;

%% Parameter initialize
T_LIMIT = 500;

% 1: unlock;    2: lock;
% 3: set zero;  4: motor control   

mode = 4; 

% 1: enable; 0: disable 
AUTO_UNLOCK = 1; 

% 'P_Ctrl', 'V_Ctrl', 'T_Ctrl'
ctrl_mode = 'V_Ctrl';

% Motor id array
motor_id = 3;

[~, MOTOR_NUM] = size(motor_id);

% (:,:,1), id;  (:,:,2), P;  (:,:,3), V; (:,:,4), T 
motor_feedback = zeros(MOTOR_NUM, T_LIMIT, 4);

% (:,:,1), P;  (:,:,2), V; (:,:,3), T;
% (:,:,4), Kp; (:,:,5), Kd
motor_input    = zeros(MOTOR_NUM, T_LIMIT, 5);

%% Set motor to zero
for num = 1:1:MOTOR_NUM
    ft_set_zero(motor_id(num));
end

if AUTO_UNLOCK == 1
    %% Auto unlock motor
    for num = 1:1:MOTOR_NUM
        ft_unlock_motor(motor_id(num));
    end
end

%% Motor parameter
for num = 1:1:MOTOR_NUM
    motor_input(num, :, 4) = ft_motor_param_set(num, T_LIMIT, 'Kp', ctrl_mode); % Kp curve
    motor_input(num, :, 5) = ft_motor_param_set(num, T_LIMIT, 'Kd', ctrl_mode); % Kd curve
end

%% Motor motion curve
for num = 1:1:MOTOR_NUM
    motor_input(num, :, 1) = ft_motor_p_set(num, T_LIMIT, ctrl_mode); % P curve
    motor_input(num, :, 2) = ft_motor_v_set(num, T_LIMIT, ctrl_mode); % V curve
    motor_input(num, :, 3) = ft_motor_t_set(num, T_LIMIT, ctrl_mode); % T curve
end

%% Data distribute
% (:,:,1), id; (:,:,2), P;  (:,:,3), V;
% (:,:,4), T;  (:,:,5), Kp; (:,:,6), Kd
motor_ctrl_data = zeros(MOTOR_NUM, T_LIMIT, 6);
for num = 1:1:MOTOR_NUM
    motor_ctrl_data(num, :, 1) = motor_id(num); % id
    motor_ctrl_data(num, :, 2) = motor_input(num, :, 1); % P
    motor_ctrl_data(num, :, 3) = motor_input(num, :, 2); % V
    motor_ctrl_data(num, :, 4) = motor_input(num, :, 3); % T
    motor_ctrl_data(num, :, 5) = motor_input(num, :, 4); % Kp
    motor_ctrl_data(num, :, 6) = motor_input(num, :, 5); % Kd
end

%% COM port
port = seriallist;
fprintf("Connect: ");
fprintf(port);

%% Unlock motor
if mode == 1
    for num = 1:1:MOTOR_NUM
        ft_unlock_motor(motor_id(num));
    end

%% Lock motor
elseif mode == 2
    for num = 1:1:MOTOR_NUM
        ft_lock_motor(motor_id(num));
    end

%% Set zero
elseif mode == 3
    for num = 1:1:MOTOR_NUM
        ft_set_zero(motor_id(num))
    end

%% Control data frame define
elseif mode == 4
    serial_port = serialport(port, 921600, 'Timeout', 0.2);

    msg = uint8(zeros(1, 30));
    msg(1) = uint8(123);  % '{', start of frame
    msg(30) = uint8(125); % '}', end of frame
    msg(2) = mode;

    %% Control motor
    for t = 1:1:T_LIMIT
        for num = 1:1:MOTOR_NUM
            msg(3:13) = ft_data_tx_convert(motor_ctrl_data, num, t); 
            write(serial_port, msg, "uint8");
            try
                motor_feedback(num, t, :) = ft_data_rx_convert(read(serial_port, 9, "uint8"));
            catch
                clear serial_port;
                for i = 1:1:MOTOR_NUM
                    ft_lock_motor(motor_id(i));
                end
                fprintf("Times: %d\n", t);
                serial_port = serialport(port, 921600, 'Timeout', 0.2);
            end
            fprintf("Times: %d \n", t);
        end
    end
    clear serial_port;
    
    ft_data_show(1,motor_input, motor_feedback, T_LIMIT, ctrl_mode);

    %% lock motor
    for num = 1:1:MOTOR_NUM
        ft_lock_motor(motor_id(num));
    end
end