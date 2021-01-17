clear; clc;

music = [1, -1, 1, -1, 5, -1, 5, -1, 6, -1, 6, -1, 5, 0, ...
         4, -1, 4, -1, 3, -1, 3, -1, 2, -1, 2, -1, 1, 0, ...
         5, -1, 5, -1, 4, -1, 4, -1, 3, -1, 3, -1, 2, 0, ...
         5, -1, 5, -1, 4, -1, 4, -1, 3, -1, 3, -1, 2, 0, ...
         1, -1, 1, -1, 5, -1, 5, -1, 6, -1, 6, -1, 5, 0, ...
         4, -1, 4, -1, 3, -1, 3, -1, 2, -1, 2, -1, 1, 0];
       
[row, col] = size(music);
bais = 7;

mode = 0 ;
id = 4;
P = 0;
T = 0;
Kp = 0;
Kd = 2;

serial_port = serialport("COM3",115200);

for vt  =  1:col
    
    if music(vt) == -1
       V = 0; 
    elseif music(vt) == 0
        V = music(vt) + bais + 1;
    else
        V = music(vt) + bais;
    end
    
    
    if vt == col
        V = 0;
    end
    
    fprintf("V: %.2f\n", V);
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
% rx = read(serial_port, 112, "uint8");
end
% clear serial_port;


