% @Author: luoqi 
% @Date: 2021-03-10 17:25:35 
% @Last Modified by:   luoqi 

function reshape_data = f_feedback_reshape(motor_feedback, id_list)
    %  This function is used to reshape motor feedback data;
    % Input ID order is [1,2,3,4,5,6,7,8], but the feedback
    % ID order is [8,1,2,3,4,5,6,7]; so we need adjust the 
    % feedback data ID order to same as the input data ID 
    % order. 

    [~, MOTOR_NUM] = size(id_list);
    [~, SIZE, ~] = size(motor_feedback);
    % (:,:,1), id;  (:,:,2), P;  (:,:,3), V; (:,:,4), T 
    reshape_data = zeros(MOTOR_NUM, SIZE, 4);
    
    for i = 1:MOTOR_NUM - 1
        reshape_data(i,:,:) = motor_feedback(i+1,:,:);
    end
    reshape_data(MOTOR_NUM,:,:) = motor_feedback(1,:,:);
end