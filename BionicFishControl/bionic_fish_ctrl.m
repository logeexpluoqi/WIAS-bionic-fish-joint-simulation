% @Author: luoqi 
% @Date: 2021-01-22 20:31:25 
% @Last Modified by:   luoqi 

clear; clc;

%% Parameter initialize
T_LIMIT = 1000;
MOTOR_NUM  = 4;

mode  = 4; 

motor_id = [1, 2, 3, 4];

% (:,:,1), P;  (:,:,2), V;  (:,:,3), T 
motor_feedback_data = zeros(MOTOR_NUM, T_LIMIT, 3);

% (:,:,1), P;  (:,:,2), V; (:,:,3), T;
% (:,:,4), Kp; (:,:,5), Kd
motor_input         = zeros(MOTOR_NUM, T_LIMIT, 5);

%% Motor parameter
for num = 1:1:MOTOR_NUM
    motor_input(num, :, 4) = 30*ones(T_LIMIT,1); % Kp curve
    motor_input(num, :, 5) = 2.4*ones(T_LIMIT,1); % Kd curve
end

%% Motor motion curve
for num = 1:1:MOTOR_NUM
    motor_input(num, :, 1) = (pi/3)*sin((0.1:0.1:T_LIMIT/10)*5); % P curve
    motor_input(num, :, 2) = zeros(T_LIMIT, 1); % V curve
    motor_input(num, :, 3) = zeros(T_LIMIT, 1); % T curve
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
    msg(1) = uint8(123);  % '{', start of frame
    msg(30) = uint8(125); % '}', end of frame
    msg(2) = mode;

    %% Control motor
    for t = 1:1:T_LIMIT
        for num = 1:1:MOTOR_NUM
            msg(3:13) = data_convert(motor_ctrl_data, num, t); 
            write(serial_port, msg, "uint8");
        end
    end
end