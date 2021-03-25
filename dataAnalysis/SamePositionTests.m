%-------------- Synchronize and Interpolate Data ---------------------
%
% Operador 4.0 -> Accuracy and Repeatability tests
%   - data acquired by: HoloLens2/HTCvive & OptiTrack
%
% Author: Inês Soares (ines.o.soares@inesctec.pt)
% 
% ------------------- SAME POSITION TESTS ----------------------------

% insert test number
test_date = '17';
test_number = '10';
test_type = 1; % HL: 1 | HTC: 2

% read and save data to arrays
[timestamp,HL_x,HL_y,HL_z,OT_x,OT_y,OT_z,Error] = readData(test_date,test_number,test_type);

% calculate accuracy
error_mean_x = mean(HL_x - OT_x);
error_mean_y = mean(HL_y - OT_y);
error_mean_z = mean(HL_z - OT_z);
accuracy = sqrt(error_mean_x^2 + error_mean_y^2 + error_mean_z^2);

% calculate repeatability
li = sqrt((HL_x-mean(HL_x)).^2+(HL_y-mean(HL_y)).^2+(HL_z-mean(HL_z)).^2);
l_bar = mean(li);
st_dev = sqrt(sum((li-l_bar).^2)/(size(li,1)-1));
repeatability = l_bar + 3 * st_dev;

% calibrate
HL_x_cal = HL_x - mean(error_mean_x);
HL_y_cal = HL_y - mean(error_mean_y);
HL_z_cal = HL_z - mean(error_mean_z);
error_mean_x_cal = mean(HL_x_cal - OT_x);
error_mean_y_cal = mean(HL_y_cal - OT_y);
error_mean_z_cal = mean(HL_z_cal - OT_z);
accuracy_cal = sqrt(error_mean_x_cal^2 + error_mean_y_cal^2 + error_mean_z_cal^2);

% display results
plotGraphsSimple(timestamp,HL_x,HL_y,HL_z,OT_x,OT_y,OT_z,Error);
result = sprintf('\nTest number: %s\nAccuracy: %f m \nRepeatability: %f m \nAccuracy after calibration: %f m \n',test_number,accuracy,repeatability,accuracy_cal);
disp(result);