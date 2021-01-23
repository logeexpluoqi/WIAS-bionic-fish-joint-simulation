% @Author: luoqi 
% @Date: 2021-01-23 16:06:35 
% @Last Modified by:   luoqi 
% @Last Modified time: 2021-01-23 16:06:35 

function send_data = data_convert(org_data, num, t)
    id = org_data(num, t, 1);
    [P_h, P_l]   = msg_float_to_char(org_data(num, t, 2));
    [V_h, V_l]   = msg_float_to_char(org_data(num, t, 3));
    [T_h, T_l]   = msg_float_to_char(org_data(num, t, 4));
    [Kp_h, Kp_l] = msg_float_to_char(org_data(num, t, 5));
    [Kd_h, Kd_l] = msg_float_to_char(org_data(num, t, 6));

    send_data = [id, P_h, P_l, V_h, V_l, T_h, T_l, Kp_h, Kp_l, Kd_h, Kd_l];
end
