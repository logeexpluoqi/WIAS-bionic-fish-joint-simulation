% v_curve = motor_v_set(motor_num, T_LIMIT);
% @param motor_num: motor number
% @param T_LIMIT: time range
% @param ctrl_mode: "P_Ctrl", "V_Ctrl", "T_Ctrl"

% @Author: luoqi 
% @Date: 2021-01-24 16:06:16 
% @Last Modified by:   luoqi 

function v_curve = f_motor_v_set(motor_num, T_LIMIT, ctrl_mode)
    if ctrl_mode == "V_Ctrl"
        switch motor_num
        case 1
            v_curve = 5*sin(0.1:0.1:T_LIMIT/10);
        case 2
            v_curve = 10*sin(0.1:0.1:T_LIMIT/10);
        case 3
            v_curve = 15*sin(0.1:0.1:T_LIMIT/10);
        case 4
            v_curve = zeros(1, T_LIMIT);
        case 5
            v_curve = zeros(1, T_LIMIT);
        case 6
            v_curve = zeros(1, T_LIMIT);
        case 7
            v_curve = zeros(1, T_LIMIT);
        case 8
            v_curve = zeros(1, T_LIMIT);
        otherwise

        end
    else
        v_curve = zeros(1, T_LIMIT);
    end

end
