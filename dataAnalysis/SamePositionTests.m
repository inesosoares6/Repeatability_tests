%-------------- Synchronize and Interpolate Data ---------------------
%
% Operador 4.0 -> Accuracy and Repeatability tests
%   - data acquired by: HoloLens2/HTCvive & OptiTrack
%
% Author: Inês Soares (ines.o.soares@inesctec.pt)
% 
% ------------------- SAME POSITION TESTS ----------------------------

clear all;
close all;

% insert test number
test_date = '17'; % 09 | 11 | 16 | 17
test_number = '10'; % 1 | 1_1 | 2a | 2b | 2b_1 | 10 | 11 | 12 | 13 | 14 | 15 | 20_1 | 20_2 | 20_3 | 20_4 | 20_5 | 22
test_type = 'HL'; % HL | HTC

% read and save data to arrays
[timestamp,H_x,H_y,H_z,OT_x,OT_y,OT_z,Error] = readData(test_date,test_number,test_type);

% calculate accuracy
error_mean_x = mean(H_x - OT_x);
error_mean_y = mean(H_y - OT_y);
error_mean_z = mean(H_z - OT_z);
accuracy = sqrt(error_mean_x^2 + error_mean_y^2 + error_mean_z^2);

% calculate repeatability
li = sqrt((H_x-mean(H_x)).^2+(H_y-mean(H_y)).^2+(H_z-mean(H_z)).^2);
l_bar = mean(li);
st_dev = sqrt(sum((li-l_bar).^2)/(size(li,1)-1));
repeatability = l_bar + 3 * st_dev;

% calibrate
H_x_cal = H_x - error_mean_x;
H_y_cal = H_y - error_mean_y;
H_z_cal = H_z - error_mean_z;
error_mean_x_cal = mean(H_x_cal - OT_x);
error_mean_y_cal = mean(H_y_cal - OT_y);
error_mean_z_cal = mean(H_z_cal - OT_z);
accuracy_cal = sqrt(error_mean_x_cal^2 + error_mean_y_cal^2 + error_mean_z_cal^2);

% display results
graph_title = sprintf('Test #%s | %s.03.2021 | %s',test_number,test_date,test_type);
plotGraphsSimple(timestamp,H_x,H_y,H_z,OT_x,OT_y,OT_z,Error);
suptitle(graph_title);
result = sprintf('\nTest date: %s.03.2021 \nTest number: %s\nAccuracy: %f cm \nRepeatability: %f cm \nAccuracy after calibration: %f cm \n',test_date,test_number,accuracy*100,repeatability*100,accuracy_cal*100);
disp(result);