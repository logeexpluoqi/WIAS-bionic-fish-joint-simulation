clear; clc;

music = [1, -1, 1, -1, 5, -1, 5, -1, 6, -1, 6, -1, 5, 0, -1, ...
         4, -1, 4, -1, 3, -1, 3, -1, 2, -1, 2, -1, 1, 0, -1, ...
         5, -1, 5, -1, 4, -1, 4, -1, 3, -1, 3, -1, 2, 0, -1, ...
         5, -1, 5, -1, 4, -1, 4, -1, 3, -1, 3, -1, 2, 0, -1, ...
         1, -1, 1, -1, 5, -1, 5, -1, 6, -1, 6, -1, 5, 0, -1, ...
         4, -1, 4, -1, 3, -1, 3, -1, 2, -1, 2, -1, 1, 0];
       
[row, col] = size(music);
bais = 02;

cir_times = 100;

ctrl_mode = 2;
mode = 4;
id = 1;
P = 0;
V = 0;
T = 0;
Kp = 0;
Kd = 2.4;

serial_port = serialport("COM3", 115200, 'Timeout', 0.1);
for times = 1:cir_times
    for vt  =  1:col

        if music(vt) == -1
            val = 0; 
        elseif music(vt) == 0
            val = music(vt) + bais + 1;
        else
            val = music(vt) + bais;
        end


        if vt == col
            val = 0;
        end
        
        if ctrl_mode == 0
            P = val;
        elseif ctrl_mode == 1
            V = val;
        elseif ctrl_mode == 2
            T = val;
        end
        
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

        if music(vt) == 0
            pause(0.3);
        else
            pause(0.1);
        end
        rx = read(serial_port, 9, "uint8");
        if rx(1) == '{' && rx(9) == '}'
            motor_p = msg_char_to_float(rx(3), rx(4));
            motor_v = msg_char_to_float(rx(5), rx(6));
            motor_t = msg_char_to_float(rx(7), rx(8));
            fprintf("\nP_dst: %04.2f, V_dst: %04.2f, T_dst: %04.2f\n", P, V, T);
            fprintf("ID: %d, ", rx(2));
            fprintf("P: %.2f, V: %.2f, T:%.2f\n\n", motor_p, motor_v, motor_t);
        else
            fprintf("RX ERROR\n");
        end
    
    end
end
% clear serial_port;
clc;


