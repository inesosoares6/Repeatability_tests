%-------------- Synchronize and Interpolate Data ---------------------
%
% Operador 4.0 -> Accuracy and Repeatability tests
%   - data acquired by: HoloLens2/HTCvive & OptiTrack
%
% Author: Inês Soares (ines.o.soares@inesctec.pt)

% insert test number
test_number = 17;
if test_number == 17
    read_file = '17032021/matlab_17.csv';
    write_file = 'interpolated_17.csv';
elseif test_number == 18
    read_file = 'matlab_18.csv';
    write_file = 'interpolated_18.csv';
elseif test_number ==19
    read_file = 'matlab_19.csv';
    write_file = 'interpolated_19.csv';
elseif test_number ==211
    read_file = 'matlab_21_1.csv';
    write_file = 'interpolated_21_1.csv';
elseif test_number ==212
    read_file = 'matlab_21_2.csv';
    write_file = 'interpolated_21_2.csv';
elseif test_number ==213
    read_file = 'matlab_21_3.csv';
    write_file = 'interpolated_21_3.csv';
elseif test_number ==214
    read_file = 'matlab_21_4.csv';
    write_file = 'interpolated_21_4.csv';
elseif test_number ==215
    read_file = 'matlab_21_5.csv';
    write_file = 'interpolated_21_5.csv';
elseif test_number ==23
    read_file = 'matlab_23.csv';
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
[debug1] = plotGraphs(time_OT,OT_z,time_HL,HL_z,T_BA_z,D_BA_z);

% save to csv
%[debug2] = save2csv(write_file,time_OT,D_BA_x,D_BA_y,D_BA_z,OT_x,OT_y,OT_z);

%error("Select the appropriate delay and comment this line.");

% select the appropriate delay
selected_delay = 15;
N = size(time_OT,1);

% calculate the errors
k=1;
begin = 1000;
error_mean = zeros(31,5);
for j=0:5:150
    error_mean(k,1) = j;
    error_mean(k,2) = mean(OT_x(begin:N-j) - D_BA_x(j+begin:N));
    error_mean(k,3) = mean(OT_y(begin:N-j) - D_BA_y(j+begin:N));
    error_mean(k,4) = mean(OT_z(begin:N-j) - D_BA_z(j+begin:N));
    error_mean(k,5) = sqrt(error_mean(k,2)^2 + error_mean(k,3)^2 + error_mean(k,4)^2);
    k=k+1;
end
% find(error_mean(:,4)==min(error_mean(:,4)))
 find(error_mean(:,5)==min(error_mean(:,5)))

% error_mean_x = mean(OT_x(1:N-selected_delay) - D_BA_x(selected_delay+1:N));
% error_mean_y = mean(OT_y(1:N-selected_delay) - D_BA_y(selected_delay+1:N));
% error_mean_z = mean(OT_z(1:N-selected_delay) - D_BA_z(selected_delay+1:N));
% accuracy = sqrt(error_mean_x^2 + error_mean_y^2 + error_mean_z^2);
% delay = mean(time_OT(selected_delay+1:N)-time_OT(1:N-selected_delay));
% result = sprintf('Test number: %d\nAccuracy: %f \nDelay: %f',test_number,accuracy,delay);
% disp(result);

% display final results
% figure();
% subplot(2,1,1);
% plot(T_BA_x,OT_z,'r',...
%      T_BA_x,D_BA_z);
% legend('OT','HL_{modified}');
% title('Initial result');
% xlabel('time (sec)');
% ylabel('z position (m)');
% subplot(2,1,2);
% plot(T_BA_x(1:N-selected_delay),OT_z(1:N-selected_delay),'r',...
%      T_BA_x(1:N-selected_delay),D_BA_z(selected_delay+1:N));
%  legend('OT','HL_{modified}');
%  title('Final result');
%  xlabel('time (sec)');
%  ylabel('z position (m)');