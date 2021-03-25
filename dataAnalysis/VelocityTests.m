%-------------- Synchronize and Interpolate Data ---------------------
%
% Operador 4.0 -> Accuracy and Repeatability tests
%   - data acquired by: HoloLens2/HTCvive & OptiTrack
%
% Author: Inês Soares (ines.o.soares@inesctec.pt)
% 
% ----------------------- MOVEMENT TESTS -----------------------------

% insert test number
test_date = '17';
test_number = '17';
test_type = 1; % HL: 1 | HTC: 2

% read and save data to arrays
[time_HL,HL_x,HL_y,HL_z,time_OT,OT_x,OT_y,OT_z] = joinReadData(test_date,test_number,test_type);

% calculate interpolation
[T_BA_x, D_BA_x] = interpolate(time_OT,OT_x,time_HL,HL_x);
[T_BA_y, D_BA_y] = interpolate(time_OT,OT_y,time_HL,HL_y);
[T_BA_z, D_BA_z] = interpolate(time_OT,OT_z,time_HL,HL_z);

% plot graphs
if(strcmp(test_number,'21_5'))
    plotGraphs(1,time_OT,OT_x,time_HL,HL_x,T_BA_x,D_BA_x,0,0,0,0,0);
else
    plotGraphs(1,time_OT,OT_z,time_HL,HL_z,T_BA_z,D_BA_z,0,0,0,0,0);
end

% calculate delay
if(strcmp(test_number,'21_5'))
    [MaxIdx_OT,MinIdx_OT,MaxIdx_HL,MinIdx_HL,delay] = calculateDelay(time_OT,OT_x,T_BA_x,D_BA_x);
else
    [MaxIdx_OT,MinIdx_OT,MaxIdx_HL,MinIdx_HL,delay] = calculateDelay(time_OT,OT_z,T_BA_z,D_BA_z);
end

% calculate velocity
if(strcmp(test_number,'21_5'))
    [velocity] = calculateVelocity(T_BA_x,D_BA_x,MaxIdx_HL,MinIdx_HL);
else
    [velocity] = calculateVelocity(T_BA_z,D_BA_z,MaxIdx_HL,MinIdx_HL);
end
velocity_mean = mean(velocity);

% calculate accuracy
N = size(time_OT,1);
cell_delay = round((mean(MaxIdx_HL-MaxIdx_OT)+mean(MinIdx_HL-MinIdx_OT))/2);
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
    plotGraphs(2,time_OT,OT_x,0,0,T_BA_x,D_BA_x,cell_delay,MaxIdx_OT,MinIdx_OT,MaxIdx_HL,MinIdx_HL);
else
    plotGraphs(2,time_OT,OT_z,0,0,T_BA_z,D_BA_z,cell_delay,MaxIdx_OT,MinIdx_OT,MaxIdx_HL,MinIdx_HL);
end
result = sprintf('\nTest number: %s\nAccuracy: %f m \nDelay: %f s \nVelocity: %f m/s \n',test_number,accuracy,delay,velocity_mean);
disp(result);

% save to csv
write_file = strcat(test_date,'032021/','interpolated_',test_number,'.csv');
% save2csv(write_file,time_OT,D_BA_x,D_BA_y,D_BA_z,OT_x,OT_y,OT_z);
