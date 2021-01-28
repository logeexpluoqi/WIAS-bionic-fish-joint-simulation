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
        case 1
            A     = pi;
            omega = 80;
            p_curve = A * sin(omega * (0.01:0.01:T_LIMIT/100));
        case 2
            A     = 10*pi;
            omega = 1;
            p_curve = A * sin(omega * (0.01:0.01:T_LIMIT/100));
        case 3
            A     = 31.4;
            omega = 10;
            p_curve = A * sin(omega * (0.01:0.01:T_LIMIT/100));
        case 4
            p_curve = zeros(1, T_LIMIT);
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
