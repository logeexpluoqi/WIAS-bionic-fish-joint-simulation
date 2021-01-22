clear; clc;

TX_n = 1;
mode = 4;
id = 1;
P = 0;
V = 0;
T = 0; 
Kp = 0;
Kd = 3.8;

serial_port = serialport ("COM3",115200,'Timeout',0.1);

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

info = zeros(TX_n, 3);

for i=1:1:TX_n
    write(serial_port, msg, "uint8");
    rx = read(serial_port, 9, "uint8");
    
    if rx(1) == '{' && rx(9) == '}'
        motor_p = msg_char_to_float(rx(3), rx(4));
        motor_v = msg_char_to_float(rx(5), rx(6));
        motor_t = msg_char_to_float(rx(7), rx(8));
        
        info(i,1) = motor_p;
        info(i,2) = motor_v;
        info(i,3) = motor_t;
        
        fprintf("\nP_dst: %04.2f, V_dst: %04.2f, T_dst: %04.2f\n", P, V, T);
        fprintf("ID: %d, ", rx(2));
        fprintf("P: %.2f, V: %.2f, T:%.2f\n\n", motor_p, motor_v, motor_t);
    else
        fprintf(" ***** RX ERROR ***** \n");
        info(i,1) = 255;
        info(i,2) = 255;
        info(i,3) = 255;
    end

end

clear serial_port;


