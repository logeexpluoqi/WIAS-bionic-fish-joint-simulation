% param = motor_param_set(num, T_LIMIT, param_type, ctrl_type);
% @param num: Motor number
% @param T_LIMIT: time range
% @param param_type: "Kp" or 'Kd'
% @param ctrl_type: "P_Ctrl" or "V_Ctrl" or "T_Ctrl"

% @Author: luoqi 
% @Date: 2021-01-24 13:36:23 
% @Last Modified by:   luoqi 

function param = f_motor_param_set(num, T_LIMIT, param_type, ctrl_type)

    Kp = [100, 100, 100, 100, 100, 100, 100, 100];
    Kd = [3.4, 3.4, 3.4, 3.4, 3.4, 3.4, 3.4, 3.4];
    %% Motor 1
    if num == 1
        switch param_type 
        case "Kp"
            if ctrl_type == "P_Ctrl"
                param = Kp(1) * ones(1, T_LIMIT);
            else
                param = zeros(1, T_LIMIT);
            end
        case 'Kd'
            param = Kd(1) * ones(1, T_LIMIT);
        otherwise
            fprintf("Error, type should be 'Kp' or 'Kd'! \n");
        end

    %% Motor 2
    elseif num == 2
        switch param_type 
        case "Kp"
            if ctrl_type == "P_Ctrl"
                param = Kp(2) * ones(1, T_LIMIT);
            else
                param = zeros(1, T_LIMIT);
            end
        case 'Kd'
            param = Kd(2) * ones(1, T_LIMIT);
        otherwise
            fprintf("Error, type should be 'Kp' or 'Kd'! \n");
        end
        
    %% Motor 3
    elseif num == 3
        switch param_type 
        case "Kp"
            if ctrl_type == "P_Ctrl"
                param = Kp(3) * ones(1, T_LIMIT);
            else
                param = zeros(1, T_LIMIT);
            end
        case 'Kd'
            param = Kd(3) * ones(1, T_LIMIT);
        otherwise
            fprintf("Error, type should be 'Kp' or 'Kd'! \n");
        end

    %% Motor 4
    elseif num == 4
        switch param_type 
        case "Kp"
            if ctrl_type == "P_Ctrl"
                param = Kp(4) * ones(1, T_LIMIT);
            else
                param = zeros(1, T_LIMIT);
            end
        case 'Kd'
            param = Kd(4) * ones(1, T_LIMIT);
        otherwise
            fprintf("Error, type should be 'Kp' or 'Kd'! \n");
        end

    %% Motor 5
    elseif num == 5
        switch param_type 
        case "Kp"
            if ctrl_type == "P_Ctrl"
                param = Kp(5) * ones(1, T_LIMIT);
            else
                param = zeros(1, T_LIMIT);
            end
        case 'Kd'
            param = Kd(5) * ones(1, T_LIMIT);
        otherwise
            fprintf("Error, type should be 'Kp' or 'Kd'! \n");
        end

    %% Motor 6
    elseif num == 6
        switch param_type 
        case "Kp"
            if ctrl_type == "P_Ctrl"
                param = Kp(6) * ones(1, T_LIMIT);
            else
                param = zeros(1, T_LIMIT);
            end
        case 'Kd'
            param = Kd(6) * ones(1, T_LIMIT);
        otherwise
            fprintf("Error, type should be 'Kp' or 'Kd'! \n");
        end

    %% Motor 7
    elseif num == 7
        switch param_type 
        case "Kp"
            if ctrl_type == "P_Ctrl"
                param = Kp(7) * ones(1, T_LIMIT);
            else
                param = zeros(1, T_LIMIT);
            end
        case 'Kd'
            param = Kd(7) * ones(1, T_LIMIT);
        otherwise
            fprintf("Error, type should be 'Kp' or 'Kd'! \n");
        end

    %% Motor 8
    elseif num == 8
        switch param_type 
        case "Kp"
            if ctrl_type == "P_Ctrl"
                param = Kp(8) * ones(1, T_LIMIT);
            else
                param = zeros(1, T_LIMIT);
            end
        case 'Kd'
            param = Kd(8) * ones(1, T_LIMIT);
        otherwise
            fprintf("Error, type should be 'Kp' or 'Kd'! \n");
        end
    end
end
