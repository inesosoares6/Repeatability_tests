%-------------- Synchronize and Interpolate Data ---------------------
%
% Operador 4.0 -> Accuracy and Repeatability tests
%   - data acquired by: HoloLens2/HTCvive & OptiTrack
%
% Author: Inês Soares (ines.o.soares@inesctec.pt)
% 
% ----------------------- MOVEMENT TESTS -----------------------------

clear all;
close all;

% insert test number
test_date = '17'; % 09 | 11 | 16 | 17
test_number = '17'; % 4 | 4_1 | 5 | 5_1 | 6 | 6_1 | 17 | 18 | 19 | 21_1 | 21_2 | 21_3 | 21_4 | 21_5 | 23
test_type = 'HL'; % HL | HTC

% read and save data to arrays
[time_H,H_x,H_y,H_z,time_OT,OT_x,OT_y,OT_z] = joinReadData(test_date,test_number,test_type);

% calculate interpolation
[T_BA_x, D_BA_x] = interpolate(time_OT,OT_x,time_H,H_x);
[T_BA_y, D_BA_y] = interpolate(time_OT,OT_y,time_H,H_y);
[T_BA_z, D_BA_z] = interpolate(time_OT,OT_z,time_H,H_z);

% plot graphs
graph_title = sprintf('Test #%s | %s.03.2021 | %s',test_number,test_date,test_type);
if(strcmp(test_number,'21_5'))
    plotGraphs(1,time_OT,OT_x,time_H,H_x,T_BA_x,D_BA_x,0,0,0,0,0);
else
    plotGraphs(1,time_OT,OT_z,time_H,H_z,T_BA_z,D_BA_z,0,0,0,0,0);
end
suptitle(graph_title);

% % calculate delay
if(strcmp(test_number,'21_5'))
    [MaxIdx_OT,MinIdx_OT,MaxIdx_H,MinIdx_H,delay] = calculateDelay(time_OT,OT_x,T_BA_x,D_BA_x);
else
    [MaxIdx_OT,MinIdx_OT,MaxIdx_H,MinIdx_H,delay] = calculateDelay(time_OT,OT_z,T_BA_z,D_BA_z);
end

% calculate velocity
if(strcmp(test_number,'21_5'))
    [velocity] = calculateVelocity(T_BA_x,D_BA_x,MaxIdx_H,MinIdx_H);
else
    [velocity] = calculateVelocity(T_BA_z,D_BA_z,MaxIdx_H,MinIdx_H);
end
velocity_mean = mean(velocity);

% calculate accuracy
N = size(time_OT,1);
cell_delay = round((mean(MaxIdx_H-MaxIdx_OT)+mean(MinIdx_H-MinIdx_OT))/2);
if cell_delay<0
    cell_delay=0;
    delay=0;
end
error_mean_x = mean(OT_x(1:N-cell_delay) - D_BA_x(cell_delay+1:N));
error_mean_y = mean(OT_y(1:N-cell_delay) - D_BA_y(cell_delay+1:N));
error_mean_z = mean(OT_z(1:N-cell_delay) - D_BA_z(cell_delay+1:N));
accuracy = sqrt(error_mean_x^2 + error_mean_y^2 + error_mean_z^2);

% display final results
if(strcmp(test_number,'21_5'))
    plotGraphs(2,time_OT,OT_x,0,0,T_BA_x,D_BA_x,cell_delay,MaxIdx_OT,MinIdx_OT,MaxIdx_H,MinIdx_H);
    suptitle(graph_title);
    plotGraphs(3,time_OT,OT_x,0,0,T_BA_x,D_BA_x,cell_delay,MaxIdx_OT,MinIdx_OT,MaxIdx_H,MinIdx_H);
else
    plotGraphs(2,time_OT,OT_z,0,0,T_BA_z,D_BA_z,cell_delay,MaxIdx_OT,MinIdx_OT,MaxIdx_H,MinIdx_H);
    suptitle(graph_title);
    plotGraphs(3,time_OT,OT_z,0,0,T_BA_z,D_BA_z,cell_delay,MaxIdx_OT,MinIdx_OT,MaxIdx_H,MinIdx_H);
end
suptitle(graph_title);
result = sprintf('\nTest date: %s.03.2021 \nTest number: %s\nAccuracy: %f cm \nDelay: %f ms \nVelocity: %f cm/s \n',test_date,test_number,accuracy*100,delay*1000,velocity_mean*100);
disp(result);

% save to csv
write_file = strcat(test_date,'032021/','interpolated_',test_number,'.csv');
% save2csv(write_file,time_OT,D_BA_x,D_BA_y,D_BA_z,OT_x,OT_y,OT_z);
