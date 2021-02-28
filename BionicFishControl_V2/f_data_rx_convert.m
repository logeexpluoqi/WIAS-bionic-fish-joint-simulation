% @Author: luoqi 
% @Date: 2021-01-23 19:12:07 
% @Last Modified by:   luoqi 

function rx_data = f_data_rx_convert(rx)
    rx_data(1) = rx(1);
    rx_data(2) = f_msg_char_to_float(rx(2), rx(3));
    rx_data(3) = f_msg_char_to_float(rx(4), rx(5));
    rx_data(4) = f_msg_char_to_float(rx(6), rx(7));
end
