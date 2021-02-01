% p_curve = motor_p_set(motor_num, T_LIMIT);
% @param motor_num: motor number
% @param T_LIMIT: time range

% @Author: luoqi 
% @Date: 2021-01-24 16:06:16 
% @Last Modified by:   luoqi 
 
function p_curve = ft_motor_p_set(motor_num, T_LIMIT, ctrl_type)
    if ctrl_type == "P_Ctrl"
        switch motor_num
        case 1
            p_curve(1:50) = zeros(1,50);
            p_curve(51:100) = -2*pi * ones(1,50);
%             A     = (pi/13);
%             omega = 45;
%             p_curve = A * sin(omega * (0.01:0.01:T_LIMIT/100));
        case 2
            p_curve = zeros(1, T_LIMIT);
        case 3
            p_curve = zeros(1, T_LIMIT);
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
