%-------------- Synchronize and Interpolate Data ---------------------
%
% Operador 4.0 -> Accuracy and Repeatability tests
%   - data acquired by: HoloLens2/HTCvive & OptiTrack
%
% Author: Inês Soares (ines.o.soares@inesctec.pt)

% insert test number
test_number = 18;
if test_number == 17
    read_file = '16032021/matlab_17.csv';
    write_file = 'interpolated_17.csv';
elseif test_number == 18
    read_file = '16032021/matlab_18.csv';
    write_file = 'interpolated_18.csv';
elseif test_number ==19
    read_file = '16032021/matlab_19.csv';
    write_file = 'interpolated_19.csv';
elseif test_number ==211
    read_file = '16032021/matlab_21_1.csv';
    write_file = 'interpolated_21_1.csv';
elseif test_number ==212
    read_file = '16032021/matlab_21_2.csv';
    write_file = 'interpolated_21_2.csv';
elseif test_number ==213
    read_file = '16032021/matlab_21_3.csv';
    write_file = 'interpolated_21_3.csv';
elseif test_number ==214
    read_file = '17032021/matlab_21_4.csv';
    write_file = 'interpolated_21_4.csv';
elseif test_number ==215
    read_file = '17032021/matlab_21_5.csv';
    write_file = 'interpolated_21_5.csv';
elseif test_number ==23
    read_file = '17032021/matlab_23.csv';
    write_file = 'interpolated_23.csv';
else
    error("Insert valid test number")
end

% read and save data to arrays
[time_HL,HL_x,HL_y,HL_z,time_OT,OT_x,OT_y,OT_z] = readData(read_file);

% calculate interpolation
[T_BA_x, D_BA_x] = interpolate(time_OT,OT_x,time_HL,HL_x);
[T_BA_y, D_BA_y] = interpolate(time_OT,OT_y,time_HL,HL_y);
[T_BA_z, D_BA_z] = interpolate(time_OT,OT_z,time_HL,HL_z);

% plot graphs
if(test_number == 215)
    plotGraphs(1,time_OT,OT_x,time_HL,HL_x,T_BA_x,D_BA_x,0,0,0,0,0);
else
    plotGraphs(1,time_OT,OT_z,time_HL,HL_z,T_BA_z,D_BA_z,0,0,0,0,0);
end

% calculate delay
if(test_number == 215)
    [MaxIdx_OT,MinIdx_OT,MaxIdx_HL,MinIdx_HL,delay] = calculateDelay(time_OT,OT_x,T_BA_x,D_BA_x);
else
    [MaxIdx_OT,MinIdx_OT,MaxIdx_HL,MinIdx_HL,delay] = calculateDelay(time_OT,OT_z,T_BA_z,D_BA_z);
end

% calculate velocity
if(test_number == 215)
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
if(test_number == 215)
    plotGraphs(2,time_OT,OT_x,0,0,T_BA_x,D_BA_x,cell_delay,MaxIdx_OT,MinIdx_OT,MaxIdx_HL,MinIdx_HL);
else
    plotGraphs(2,time_OT,OT_z,0,0,T_BA_z,D_BA_z,cell_delay,MaxIdx_OT,MinIdx_OT,MaxIdx_HL,MinIdx_HL);
end
result = sprintf('\nTest number: %d\nAccuracy: %f m \nDelay: %f s \nVelocity: %f m/s \n',test_number,accuracy,delay,velocity_mean);
disp(result);

% save to csv
% save2csv(write_file,time_OT,D_BA_x,D_BA_y,D_BA_z,OT_x,OT_y,OT_z);
