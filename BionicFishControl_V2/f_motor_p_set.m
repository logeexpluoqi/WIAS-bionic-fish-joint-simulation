% p_curve = motor_p_set(motor_num, T_LIMIT);
% @param motor_num: motor number
% @param T_LIMIT: time range
% @param ctrl_mode: "P_Ctrl", "V_Ctrl", "T_Ctrl"

% @Author: luoqi 
% @Date: 2021-01-24 16:06:16 
% @Last Modified by:   luoqi 
 
function p_curve = f_motor_p_set(motor_num, T_LIMIT, ctrl_mode)
    prec = 0.01;
    if ctrl_mode == "P_Ctrl"
        switch motor_num
        case 1 % id: 
            A     = (pi/8);
            omega = 5;
            p_curve = A * sin(omega * (prec:prec:T_LIMIT/(1/prec)));
        case 2 % id: 
            A     = (pi/3);
            omega = 5;
            p_curve = A * sin(omega * (prec:prec:T_LIMIT/(1/prec)));
        case 3 % id: 
            A     = (pi/8);
            omega = 5;
            p_curve = A * sin(omega * (prec:prec:T_LIMIT/(1/prec)));
        case 4 % id: 
            A     = (pi/8);
            omega = 5;
            p_curve = A * sin(omega * (prec:prec:T_LIMIT/(1/prec)));
        case 5 % id: 
            A     = (pi/8);
            omega = 5;
            p_curve = -A * sin(omega * (prec:prec:T_LIMIT/(1/prec)));
        case 6 % id: 
            A     = (pi/8);
            omega = 5;
            p_curve = -A * sin(omega * (prec:prec:T_LIMIT/(1/prec)));
        case 7 % id: 
            A     = (pi/3);
            omega = 5;
            p_curve = -A * sin(omega * (prec:prec:T_LIMIT/(1/prec)));
        case 8 % id: 
            A     = (pi/8);
            omega = 5;
            p_curve = -A * sin(omega * (prec:prec:T_LIMIT/(1/prec)));
        otherwise
            p_curve = zeros(1, T_LIMIT);
        end
    else
        p_curve = zeros(1, T_LIMIT);
    end

end
