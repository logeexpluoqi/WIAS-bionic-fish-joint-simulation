% t_curve = motor_t_set(motor_num, T_LIMIT);
% @param motor_num: motor number
% @param T_LIMIT: time range

% @Author: luoqi 
% @Date: 2021-01-24 16:06:16 
% @Last Modified by:   luoqi 

function t_curve = f_motor_t_set(motor_num, T_LIMIT)
    switch motor_num
    case 1
        t_curve = zeros(1, T_LIMIT);
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

end
