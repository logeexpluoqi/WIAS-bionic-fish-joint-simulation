% @Author: luoqi 
% @Date: 2021-02-28 21:17:20 
% @Last Modified by:   luoqi

function feedback_data = f_feedback_log(rx_data, num)
    feedback_data = zeros(num, 1, 4);
    feedback_data(:, 1, :) = rx_data;
end
