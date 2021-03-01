% @Author: luoqi 
% @Date: 2021-02-28 15:03:35 
% @Last Modified by:   luoqi 

function msg = f_get_rx_msg(rx, num)
    if rx(1) == '{' && rx(6 + num*7) == '}'
        msg = zeros(num, 4);
        for i = 1:num
            rx_data = f_data_rx_convert(rx((4 + (i-1)*7) : (10 + (i-1)*7)));
            msg(i, 1) = rx_data(1);
            msg(i, 2) = rx_data(2);
            msg(i, 3) = rx_data(3);
            msg(i, 4) = rx_data(4);
        end
    else
        msg = "RX data error !";
        fprintf("RX data error !\n");
    end
end
