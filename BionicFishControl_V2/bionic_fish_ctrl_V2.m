% @Author: luoqi 
% @Date: 2021-02-24 12:59:34 
% @Last Modified by:   luoqi 

clear; clc; close all;

%% Storage data
STORAGE_DATA = "Yes";

%% Parameter initialize
T_LIMIT = 100;
 
% 1: unlock;     2: lock; 
% 3: set zero;  4: motor control
mode  = 4;

% 1: enable; 0: disable 
AUTO_UNLOCK = 1;

% "P_Ctrl", "V_Ctrl", "T_Ctrl"
ctrl_mode = "V_Ctrl";

% Motor id array
% motor_id_list = [5, 2, 18, 16, 17, 9, 4, 1];
motor_id_list = [3];

[~, MOTOR_NUM] = size(motor_id_list);

% (:,:,1), id;  (:,:,2), P;  (:,:,3), V; (:,:,4), T 
motor_feedback = zeros(MOTOR_NUM, T_LIMIT, 4);

% (:,:,1), P;  (:,:,2), V; (:,:,3), T;
% (:,:,4), Kp; (:,:,5), Kd
motor_input    = zeros(MOTOR_NUM, T_LIMIT, 5);

%% Set motor to zero
f_set_zero(motor_id_list);

if AUTO_UNLOCK == 1
%% Auto unlock motor
    f_unlock_motor(motor_id_list);
end

%% Motor parameter
for num = 1:1:MOTOR_NUM
    motor_input(num, :, 4) = f_motor_param_set(num, T_LIMIT, 'Kp', ctrl_mode); % Kp curve
    motor_input(num, :, 5) = f_motor_param_set(num, T_LIMIT, 'Kd', ctrl_mode); % Kd curve
end

%% Motor motion curve
for num = 1:1:MOTOR_NUM
    motor_input(num, :, 1) = f_motor_p_set(num, T_LIMIT, ctrl_mode); % P curve
    motor_input(num, :, 2) = f_motor_v_set(num, T_LIMIT, ctrl_mode); % V curve
    motor_input(num, :, 3) = f_motor_t_set(num, T_LIMIT, ctrl_mode); % T curve
end

%% Data distribute
% (:,:,1), id; (:,:,2), P;  (:,:,3), V;
% (:,:,4), T;  (:,:,5), Kp; (:,:,6), Kd
motor_ctrl_data = zeros(MOTOR_NUM, T_LIMIT, 6);
for num = 1:1:MOTOR_NUM
    motor_ctrl_data(num, :, 1) = motor_id_list(num); % id
    motor_ctrl_data(num, :, 2) = motor_input(num, :, 1); % P
    motor_ctrl_data(num, :, 3) = motor_input(num, :, 2); % V
    motor_ctrl_data(num, :, 4) = motor_input(num, :, 3); % T
    motor_ctrl_data(num, :, 5) = motor_input(num, :, 4); % Kp
    motor_ctrl_data(num, :, 6) = motor_input(num, :, 5); % Kd
end

%% COM port
port = seriallist;
fprintf("Connect: "); fprintf(port); fprintf("\n");

%% Unlock motor
if mode == 1
    f_unlock_motor(motor_id_list);

%% Lock motor
elseif mode == 2
    f_lock_motor(motor_id_list);

%% Set zero
elseif mode == 3
    f_set_zero(motor_id_list)

%% Control data frame define
elseif mode == 4
    %% Control motor
    serial_port = f_set_serialport(port);
    for t = 1:1:T_LIMIT
        msg = f_get_tx_msg(motor_ctrl_data, MOTOR_NUM, t);
        write(serial_port, msg, "uint8");
    % try
    %     rx = read(serial_port, 6 + num*7, "uint8");
    %     for i = 1 : num
    %         rx_data = f_data_rx_convert(rx((4 + i*7) : (10 + i*7)));
    %         motor_feedback(i, 1) = rx_data(1);
    %         motor_feedback(i, 2) = rx_data(2);
    %         motor_feedback(i, 3) = rx_data(3);
    %         motor_feedback(i, 4) = rx_data(4);
    %     end
    % catch
    %     f_lock_motor(data(:,:,1));
    % end
        fprintf("Times: %d \n", t)
    end
    clear serial_port;
    
    if STORAGE_DATA == "Yes"
        save('motor_data.mat', 'motor_input', 'motor_feedback');
    end

    for num = 1:1:MOTOR_NUM
        f_data_show(num, motor_input, motor_feedback, T_LIMIT, ctrl_mode);
    end
    
    %% lock motor
    f_lock_motor(motor_id_list);
end