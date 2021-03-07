% @Author: luoqi 
% @Date: 2021-02-24 12:59:34 
% @Last Modified by:   luoqi 

clear; clc; close all;

%% Storage data
STORAGE_DATA = "YES";
DISPLAY_DATA = "YES";

%% Parameter initialize
T_LIMIT = 100;
 
% 1: power on;     2: power off; 
% 3: set zero;  4: motor control
mode  = 4;

% 1: enable; 0: disable 
AUTO_MOTOR_ON = 1;

% "P_Ctrl", "V_Ctrl", "T_Ctrl"
ctrl_mode = "V_Ctrl";

% Motor id array
% motor_id_list = [17, 9, 4, 1, 5, 2, 18, 16];
% motor_id_list = [1,2,3,4,5,9,18,17];
motor_id_list = [17,18,9,5,4,3,2,1];

[~, MOTOR_NUM] = size(motor_id_list);

% (:,:,1), id;  (:,:,2), P;  (:,:,3), V; (:,:,4), T 
motor_feedback = zeros(MOTOR_NUM, T_LIMIT, 4);

% (:,:,1), P;  (:,:,2), V; (:,:,3), T;
% (:,:,4), Kp; (:,:,5), Kd
motor_input    = zeros(MOTOR_NUM, T_LIMIT, 5);

%% Set motor to zero
f_set_zero(motor_id_list);

if AUTO_MOTOR_ON == 1
%% Auto unlock motor
    f_motor_on(motor_id_list);
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
port = serialportlist;
fprintf(">> Connect: "); fprintf(port); fprintf("\n");

%% Unlock motor
if mode == 1
    f_motor_on(motor_id_list);

%% Lock motor
elseif mode == 2
    f_motor_off(motor_id_list);

%% Set zero
elseif mode == 3
    f_set_zero(motor_id_list)

%% Control data frame define
elseif mode == 4
    %% Control motor
    serial_port = f_set_serialport(port);
%     configureCallback(serial_port, "terminater", f_rx_data);
    for t = 1:1:T_LIMIT
        msg = f_get_tx_msg(motor_ctrl_data, MOTOR_NUM, t);
        write(serial_port, msg, "uint8");
        motor_feedback(:, t, :) = f_get_rx_msg(read(serial_port, 6 + MOTOR_NUM*7, "uint8"), MOTOR_NUM);
        fprintf(" - Times: %d \n", t);
    end
    clear serial_port;
    
    if STORAGE_DATA == "YES"
        save('motor_data.mat', 'motor_input', 'motor_feedback');
    end

    %% lock motor
    f_motor_off(motor_id_list);
    if DISPLAY_DATA == "YES"
        for num = 1:1:MOTOR_NUM
            f_data_show(num, motor_input, motor_feedback, T_LIMIT, ctrl_mode);
        end
    end
end
