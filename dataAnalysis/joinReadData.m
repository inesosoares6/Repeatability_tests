function [time_H,pos_H_x,pos_H_y,pos_H_z,time_OT,pos_OT_x,pos_OT_y,pos_OT_z] = joinReadData(test_date,test_number,test_type)
    
    path = 'C:\Users\ineso\Documents\Repos\repeatability_tests\csvFiles\';

    if strcmp(test_type,'HL')
        read_file_H = strcat('tests_',test_date,'032021\HoloLens2_data_',test_number);
    elseif strcmp(test_type,'HTC')
        read_file_H = strcat('tests_',test_date,'032021\HTC_data_',test_number);
    else
        error("Give a right input device: HL or HTC");
    end
    read_file_OT = strcat('tests_',test_date,'032021\OptiTrack_data_',test_number);

    data_H = readtable(strcat(path,read_file_H));
    data_matrix_H = table2array(data_H);
    timestamp_H = data_matrix_H(:,1)+data_matrix_H(:,2)*10^-9;
    time_H = timestamp_H - timestamp_H(1);
    pos_H_x = data_matrix_H(:,3);
    pos_H_y = data_matrix_H(:,4);
    pos_H_z = data_matrix_H(:,5);
    
    data_OT = readtable(strcat(path,read_file_OT));
    data_matrix_OT = table2array(data_OT);
    timestamp_OT = data_matrix_OT(:,1)+data_matrix_OT(:,2)*10^-9;
    time_OT = timestamp_OT - timestamp_OT(1);
    pos_OT_x = data_matrix_OT(:,3);
    pos_OT_y = data_matrix_OT(:,4);
    pos_OT_z = data_matrix_OT(:,5);
end

