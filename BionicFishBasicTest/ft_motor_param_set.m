% param = motor_param_set(num, T_LIMIT, param_type, ctrl_type);
% @param num: Motor number
% @param T_LIMIT: time range
% @param param_type: "Kp" or 'Kd'
% @param ctrl_type: "P_Ctrl" or "V_Ctrl" or "T_Ctrl"

% @Author: luoqi 
% @Date: 2021-01-24 13:36:23 
% @Last Modified by:   luoqi 

function param = ft_motor_param_set(num, T_LIMIT, param_type, ctrl_type)
    %% Motor 1
    if num == 1
        switch param_type 
        case "Kp"
            if ctrl_type == "P_Ctrl"
                param = 80 * ones(1, T_LIMIT);
            else
                param = zeros(1, T_LIMIT);
            end
        case 'Kd'
            param = 3.4 * ones(1, T_LIMIT);
        otherwise
            fprintf("Error, type should be 'Kp' or 'Kd'! \n");
        end

    %% Motor 2
    elseif num == 2
        switch param_type 
        case "Kp"
            if ctrl_type == "P_Ctrl"
                param = ones(1, T_LIMIT);
            else
                param = zeros(1, T_LIMIT);
            end
        case 'Kd'
            param = ones(1, T_LIMIT);
        otherwise
            fprintf("Error, type should be 'Kp' or 'Kd'! \n");
        end
        
    %% Motor 3
    elseif num == 3
        switch param_type 
        case "Kp"
            if ctrl_type == "P_Ctrl"
                param = ones(1, T_LIMIT);
            else
                param = zeros(1, T_LIMIT);
            end
        case 'Kd'
            param = ones(1, T_LIMIT);
        otherwise
            fprintf("Error, type should be 'Kp' or 'Kd'! \n");
        end

    %% Motor 4
    elseif num == 4
        switch param_type 
        case "Kp"
            if ctrl_type == "P_Ctrl"
                param = ones(1, T_LIMIT);
            else
                param = zeros(1, T_LIMIT);
            end
        case 'Kd'
            param = ones(1, T_LIMIT);
        otherwise
            fprintf("Error, type should be 'Kp' or 'Kd'! \n");
        end

    %% Motor 5
    elseif num == 5
        switch param_type 
        case "Kp"
            if ctrl_type == "P_Ctrl"
                param = ones(1, T_LIMIT);
            else
                param = zeros(1, T_LIMIT);
            end
        case 'Kd'
            param = ones(1, T_LIMIT);
        otherwise
            fprintf("Error, type should be 'Kp' or 'Kd'! \n");
        end

    %% Motor 6
    elseif num == 6
        switch param_type 
        case "Kp"
            if ctrl_type == "P_Ctrl"
                param = ones(1, T_LIMIT);
            else
                param = zeros(1, T_LIMIT);
            end
        case 'Kd'
            param = ones(1, T_LIMIT);
        otherwise
            fprintf("Error, type should be 'Kp' or 'Kd'! \n");
        end

    %% Motor 7
    elseif num == 7
        switch param_type 
        case "Kp"
            if ctrl_type == "P_Ctrl"
                param = ones(1, T_LIMIT);
            else
                param = zeros(1, T_LIMIT);
            end
        case 'Kd'
            param = ones(1, T_LIMIT);
        otherwise
            fprintf("Error, type should be 'Kp' or 'Kd'! \n");
        end

    %% Motor 8
    elseif num == 8
        switch param_type 
        case "Kp"
            if ctrl_type == "P_Ctrl"
                param = ones(1, T_LIMIT);
            else
                param = zeros(1, T_LIMIT);
            end
        case 'Kd'
            param = ones(1, T_LIMIT);
        otherwise
            fprintf("Error, type should be 'Kp' or 'Kd'! \n");
        end
    end
end
