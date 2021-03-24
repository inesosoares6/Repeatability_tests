function [time_HL,HL_x,HL_y,HL_z,time_OT,OT_x,OT_y,OT_z] = readData(file_name)
    data = readtable(file_name);
    data_matrix = table2array(data);
    
    for i=1:size(data_matrix(:,6),1)
        if isnan(data_matrix(i,2))
            max_N = i-1;
            break;
        end
    end
    
    time_HL = data_matrix(1:max_N,1);
    HL_x = data_matrix(1:max_N,2);
    HL_y = data_matrix(1:max_N,3);
    HL_z = data_matrix(1:max_N,4);
    time_OT = data_matrix(:,5);
    OT_x = data_matrix(:,6);
    OT_y = data_matrix(:,7);
    OT_z = data_matrix(:,8);
end

