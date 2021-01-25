% @Author: luoqi 
% @Date: 2021-01-25 09:36:37 
% @Last Modified by:   luoqi 

function f_data_show(num, org, dst, T_LIMIT, ctrl_mode)

     t = 1:1:T_LIMIT;
    
     if ctrl_mode == "P_Ctrl"
         type = 1;
     elseif ctrl_mode == "V_Ctrl"
         type = 2;
     elseif ctrl_mode == "T_Ctrl"
         type = 3;
     end
     
     fiugre(num)
     plot(t, org(num, :, type), '--',  ...
          t, dst(num, :, 2),    '-',   ...
          t, dst(num, :, 3),    '-',   ...
          t, dst(num, :, 4),    '-'    );
     grid on;
 
     if ctrl_mode == "P_Ctrl"
         lgd = legend("Input P", ...
                      "Feedback P", ...
                      "Feedback V", ...
                      "Feedback T");
     elseif ctrl_mode == "V_Ctrl"
         lgd = legend("Input V", ...
                      "Feedback P", ...
                      "Feedback V", ...
                      "Feedback T");
     elseif ctrl_mode == "T_Ctrl"
         lgd = legend("Input T", ...
                      "Feedback P", ...
                      "Feedback V", ...
                      "Feedback T");
     end
     lgd.NumColumns = 2;

end
