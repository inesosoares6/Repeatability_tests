function [time,pos_H_x,pos_H_y,pos_H_z,pos_OT_x,pos_OT_y,pos_OT_z,Error] = readData(test_date,test_number,test_type)
    
    path = 'C:\Users\ineso\Documents\Repos\repeatability_tests\csvFiles\';

    if strcmp(test_type,'HL')
        read_file = strcat('tests_',test_date,'032021\HL_OT_data_',test_number);
    elseif strcmp(test_type,'HTC')
        read_file = strcat('tests_',test_date,'032021\HTC_OT_data_',test_number);
    else
        error("Give a right input device: HL or HTC");
    end

    data = readtable(strcat(path,read_file));
    data_matrix = table2array(data);
    
    start = 400;
    finish = 400;
    N = size(data_matrix,1);
    
    timestamp = data_matrix(start:N-finish,1)+data_matrix(start:N-finish,2)*10^-9;
    time = timestamp - timestamp(1);
    pos_H_x = data_matrix(start:N-finish,3);
    pos_H_y = data_matrix(start:N-finish,4);
    pos_H_z = data_matrix(start:N-finish,5);
    pos_OT_x = data_matrix(start:N-finish,6);
    pos_OT_y = data_matrix(start:N-finish,7);
    pos_OT_z = data_matrix(start:N-finish,8);
    Error = data_matrix(start:N-finish,9);
end

