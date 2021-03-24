%-------------- Synchronize and Interpolate Data ---------------------
%
% Operador 4.0 -> Accuracy and Repeatability tests
%   - data acquired by: HoloLens2/HTCvive & OptiTrack
%
% Author: Inês Soares (ines.o.soares@inesctec.pt)

% insert test number
test_number = 19;

if test_number == 17
    read_file = 'matlab_17.csv';
    write_file = 'interpolated_17.csv';
elseif test_number == 18
    read_file = 'matlab_18.csv';
    write_file = 'interpolated_18.csv';
elseif test_number ==19
    read_file = 'matlab_19.csv';
    write_file = 'interpolated_19.csv';
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
[debug1] = plotGraphs(time_OT,OT_z,time_HL,HL_z,T_BA_z,D_BA_z);

% save to csv
[debug2] = save2csv(write_file,time_OT,D_BA_x,D_BA_y,D_BA_z,OT_x,OT_y,OT_z);

error("Select the appropriate delay and comment this line.");

% select the appropriate delay
selected_delay = 5;
N = size(time_OT,1);

% calculate the errors
error_mean_x = mean(OT_x(1:N-selected_delay+1) - D_BA_x(selected_delay:N));
error_mean_y = mean(OT_y(1:N-selected_delay+1) - D_BA_y(selected_delay:N));
error_mean_z = mean(OT_z(1:N-selected_delay+1) - D_BA_z(selected_delay:N));
accuracy = sqrt(error_mean_x^2 + error_mean_y^2 + error_mean_z^2);
delay = mean(time_OT(selected_delay:N)-time_OT(1:N-selected_delay+1));
result = sprintf('Test number: %d\nAccuracy: %f \nDelay: %f',test_number,accuracy,delay);
disp(result);

% display final results
figure();
subplot(2,1,1);
plot(T_BA_x,OT_z,'r',...
     T_BA_x,D_BA_z);
legend('OT','HL_{modified}');
title('Initial result');
xlabel('time (sec)');
ylabel('z position (m)');
subplot(2,1,2);
plot(T_BA_x(1:N-selected_delay+1),OT_z(1:N-selected_delay+1),'r',...
     T_BA_x(1:N-selected_delay+1),D_BA_z(selected_delay:N));
 legend('OT','HL_{modified}');
 title('Final result');
 xlabel('time (sec)');
 ylabel('z position (m)');