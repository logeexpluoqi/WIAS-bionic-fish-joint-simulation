function port = f_set_serialport(com)
    port = serialport(com, 921600, 'Timeout', 0.1);
end