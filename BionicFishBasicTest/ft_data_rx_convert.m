% @Author: luoqi 
% @Date: 2021-01-23 19:12:07 
% @Last Modified by:   luoqi 

function rx_data = ft_data_rx_convert(rx)
    rx_data(1) = rx(2);
    rx_data(2) = ft_msg_char_to_float(rx(3), rx(4));
    rx_data(3) = ft_msg_char_to_float(rx(5), rx(6));
    rx_data(4) = ft_msg_char_to_float(rx(7), rx(8));
end
