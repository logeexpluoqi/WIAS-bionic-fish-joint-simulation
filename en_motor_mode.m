clear; clc;

mode = 1;
id = 1;
P = 0;
V = 0;
T = 0;
Kp = 0;
Kd = 0;

serial_port = serialport ("COM3", 115200, 'Timeout', 0.1);

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
rx = read(serial_port, 7, "uint8");
motor_p = msg_char_to_float(rx(2), rx(3));
motor_v = msg_char_to_float(rx(4), rx(5));
motor_t = msg_char_to_float(rx(6), rx(7));
fprintf("ID: %d, ", rx(1));
fprintf("P: %.2f, V: %.2f, T:%.2f\n\n", motor_p, motor_v, motor_t);
    
clear serial_port;