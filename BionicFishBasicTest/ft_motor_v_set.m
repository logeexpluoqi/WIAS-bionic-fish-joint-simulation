% v_curve = motor_v_set(motor_num, T_LIMIT);
% @param motor_num: motor number
% @param T_LIMIT: time range

% @Author: luoqi 
% @Date: 2021-01-24 16:06:16 
% @Last Modified by:   luoqi 

function v_curve = ft_motor_v_set(motor_num, T_LIMIT, ctrl_type)
    if ctrl_type == "V_Ctrl"
        switch motor_num
        case 1
            v_curve = 10*sin(1*(0.1:0.1:T_LIMIT/10));

        case 2
            v_curve = zeros(1, T_LIMIT);
        case 3
            v_curve = zeros(1, T_LIMIT);
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
