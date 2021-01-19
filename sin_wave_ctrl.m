clear; clc;

t = 0:0.01:1000;

A = 10;
W = 10;
frq = 100;

wave = A*sin(W*t);
[row, col] = size(wave);

mode = 0 ;
id = 1;
P = 0;
V = 6;
T = 0;
Kp = 10;
Kd = 2;

serial_port = serialport("COM3", 115200, 'Timeout', 0.1);
% figure(1); hold on;
for vt  =  1:col
    
    V = wave(vt);
    
    fprintf("P_dst: %04.2f, V_dst: %04.2f, T_dst: %04.2f\n", P, V, T);
    msg = uint8(zeros(1, 30));
    msg(1) = uint8(123); % '{', start of frame
    msg(30) = uint8(125); % '}', end of frame
    msg(2) = mode;
    
    [P_h, P_l] = msg_float_to_char(P);
    [V_h, V_l] = msg_float_to_char(V);
    [T_h, T_l] = msg_float_to_char(T);
    [Kp_h, Kp_l] = msg_float_to_char(Kp);
    [Kd_h, Kd_l] = msg_float_to_char(Kd);
    
    motor_ctrl_data = [id, P_h, P_l, V_h, V_l, T_h, T_l, Kp_h, Kp_l, Kd_h, Kd_l];
    for i = 3:1:13
        msg(i) = motor_ctrl_data(i-2);
    end
    
    write(serial_port, msg, "uint8");
    
    pause(1/frq);
    rx = read(serial_port, 7, "uint8");
    motor_p = msg_char_to_float(rx(2), rx(3));
    motor_v = msg_char_to_float(rx(4), rx(5));
    motor_t = msg_char_to_float(rx(6), rx(7));
    fprintf("ID: %d, ", rx(1));
    fprintf("P: %.2f, V: %.2f, T:%.2f\n\n", motor_p, motor_v, motor_t);
% %     plot(vt*0.01, sin_wave(vt),'.');
    
end
% clear serial_port;


