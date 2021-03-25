function [time,position_H_x,position_H_y,position_H_z,position_OT_x,position_OT_y,position_OT_z,Error] = readData(test_date,test_number,test_type)
    
    path = 'C:\Users\ineso\Documents\Repos\repeatability_tests\csvFiles\';

    if test_type == 1
        read_file = strcat('tests_',test_date,'032021\HL_OT_data_',test_number);
    elseif test_type == 2
        read_file = strcat('tests_',test_date,'032021\HTC_OT_data_',test_number);
    else
        error("Give a right input device: HL=1 and HTC=2");
    end

    data = readtable(strcat(path,read_file));
    data_matrix = table2array(data);
    timestamp = data_matrix(:,1)+data_matrix(:,2)*10^-9;
    time = timestamp - timestamp(1);
    position_H_x = data_matrix(:,3);
    position_H_y = data_matrix(:,4);
    position_H_z = data_matrix(:,5);
    position_OT_x = data_matrix(:,6);
    position_OT_y = data_matrix(:,7);
    position_OT_z = data_matrix(:,8);
    Error = data_matrix(:,9);
end

