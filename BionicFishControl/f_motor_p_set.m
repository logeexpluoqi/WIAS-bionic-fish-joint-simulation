% p_curve = motor_p_set(motor_num, T_LIMIT);
% @param motor_num: motor number
% @param T_LIMIT: time range
% @param ctrl_mode: "P_Ctrl", "V_Ctrl", "T_Ctrl"

% @Author: luoqi 
% @Date: 2021-01-24 16:06:16 
% @Last Modified by:   luoqi 
 
function p_curve = f_motor_p_set(motor_num, T_LIMIT, ctrl_mode)
    if ctrl_mode == "P_Ctrl"
        switch motor_num
        case 1 % id: 16
            A     = (pi/2);
            omega = 10;
            p_curve = A * sin(omega * (0.01:0.01:T_LIMIT/100));
        case 2 % id: 18
            A     = (pi/4)*3;
            omega = 20;
            p_curve = A * sin(omega * (0.01:0.01:T_LIMIT/100));
        case 3 % id: 2
            A     = (pi/4);
            omega = 20;
            p_curve = A * sin(omega * (0.01:0.01:T_LIMIT/100));
        case 4 % id: 5
            A     = (pi/13);
            omega = 45;
            p_curve = A * sin(omega * (0.01:0.01:T_LIMIT/100));
        case 5
            p_curve = zeros(1, T_LIMIT);
        case 6
            p_curve = zeros(1, T_LIMIT);
        case 7
            p_curve = zeros(1, T_LIMIT);
        case 8
            p_curve = zeros(1, T_LIMIT);
        otherwise

        end
    else
        p_curve = zeros(1, T_LIMIT);
    end

end
