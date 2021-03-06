% t_curve = motor_t_set(motor_num, T_LIMIT);
% @param motor_num: motor number
% @param T_LIMIT: time range

% @Author: luoqi 
% @Date: 2021-01-24 16:06:16 
% @Last Modified by:   luoqi 

function t_curve = ft_motor_t_set(motor_num, T_LIMIT, ctrl_type)
    if ctrl_type == "T_Ctrl"
        switch motor_num
        case 1
            t_curve(1:100) = zeros(1, 100);
            t_curve(101:200) = -10 * ones(1, 100);
            t_curve(201:T_LIMIT) =  zeros(1, T_LIMIT-200);
        case 2
            t_curve = zeros(1, T_LIMIT);
        case 3
            t_curve = zeros(1, T_LIMIT);
        case 4
            t_curve = zeros(1, T_LIMIT);
        case 5
            t_curve = zeros(1, T_LIMIT);
        case 6
            t_curve = zeros(1, T_LIMIT);
        case 7
            t_curve = zeros(1, T_LIMIT);
        case 8
            t_curve = zeros(1, T_LIMIT);
        otherwise

        end
    else
        t_curve = zeros(1, T_LIMIT);
    end

end
