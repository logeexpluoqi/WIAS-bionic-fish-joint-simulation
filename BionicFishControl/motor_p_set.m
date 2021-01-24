% @Author: luoqi 
% @Date: 2021-01-24 16:06:16 
% @Last Modified by:   luoqi 
 
function p_curve = motor_p_set(motor_num, T_LIMIT)
% p_curve = motor_p_set(motor_num, T_LIMIT);
% @param motor_num: motor number
% @param T_LIMIT: time range

    switch motor_num
    case 1
        p_curve = zeros(1, T_LIMIT);
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

end
